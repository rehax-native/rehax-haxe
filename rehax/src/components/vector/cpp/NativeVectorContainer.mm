#include "NativeVectorContainer.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NativeVectorView : NSView
{
@public
  std::function<void(void)> drawCallback;
  NSBezierPath * path;
  float currentX, currentY;
}

- (void)drawRect:(NSRect)aRect;
- (BOOL)isFlipped;
@end

@implementation NativeVectorView
- (void)drawRect:(NSRect)aRect
{
  drawCallback();
}
- (BOOL)isFlipped {
    return YES;
}
@end


void NativeVectorContainer::createFragment() {
  NativeVectorView * view = [NativeVectorView new];
  // [view setFrame:NSMakeRect(0, 0, 200, 200)];
  // [view setStringValue:@""];
  // view.editable = YES;
  // view.bezeled = NO;
  // [view setBackgroundColor:[NSColor clearColor]];
  // [view sizeToFit];
  // // [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
  nativeView = (void *) CFBridgingRetain(view);
}

void NativeVectorContainer::setDrawCallback(std::function<void(void)> cb)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  view->drawCallback = cb;
}

void NativeVectorContainer::beginPath()
{
  NSLog(@"Begin path");
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  view->path = [NSBezierPath bezierPath];
  view->currentX = 0;
  view->currentY = 0;
  // [view->path setFlatness:100];
}

void NativeVectorContainer::pathHorizontalTo(float x)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path lineToPoint:NSMakePoint(x, view->currentY)];
  view->currentX = x;
}

void NativeVectorContainer::pathVerticalTo(float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path lineToPoint:NSMakePoint(view->currentX, y)];
  view->currentY = y;
}

void NativeVectorContainer::pathMoveTo(float x, float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path moveToPoint:NSMakePoint(x, y)];
  view->currentX = x;
  view->currentY = y;
}

void NativeVectorContainer::pathMoveBy(float x, float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  view->currentX += x;
  view->currentY += y;
  [view->path moveToPoint:NSMakePoint(view->currentX, view->currentY)];
}

void NativeVectorContainer::pathLineTo(float x, float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path lineToPoint:NSMakePoint(x, y)];
  view->currentX = x;
  view->currentY = y;
}

static double vectorAngle(double ux, double uy, double vx, double vy)
{
  const double sign = (ux * vy - uy * vx < 0) ? -1 : 1;
  const double umag = sqrt(ux * ux + uy * uy);
  const double vmag = sqrt(ux * ux + uy * uy);
  const double dot = ux * vx + uy * vy;

  double div = dot / (umag * vmag);

  if (div > 1) {
      div = 1;
  }

  if (div < -1) {
      div = -1;
  }

  return sign * acos(div);
}

static CGPoint mapToEllipse(double x, double y, double rx, double ry, double cosphi, double sinphi, double centerx, double centery)
{
  x *= rx;
  y *= ry;

  const double xp = cosphi * x - sinphi * y;
  const double yp = sinphi * x + cosphi * y;

  return CGPointMake((CGFloat)(xp + centerx), (CGFloat)(yp + centery));
}

void NativeVectorContainer::pathArc(float rx, float ry, float xAxisRotation, int largeArcFlag, int sweepFlag, float endX, float endY)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;

  double const px = view->currentX;
  double const py = view->currentY;
  double const cx = endX;
  double const cy = endY;
  
  const double TAU = M_PI * 2.0;
  
  const double sinphi = sin(xAxisRotation * TAU / 360);
  const double cosphi = cos(xAxisRotation * TAU / 360);
  
  const double pxp = cosphi * (px - cx) / 2 + sinphi * (py - cy) / 2;
  const double pyp = -sinphi * (px - cx) / 2 + cosphi * (py - cy) / 2;
  
  if (pxp == 0 && pyp == 0) {
      return;
  }
  
  rx = abs(rx);
  ry = abs(ry);
  
  const double lambda = (CGFloat) (pow(pxp, 2) / pow(rx, 2) + pow(pyp, 2) / pow(ry, 2));
  
  if (lambda > 1) {
      rx *= sqrt(lambda);
      ry *= sqrt(lambda);
  }
  
  const double rxsq =  pow(rx, 2);
  const double rysq =  pow(ry, 2);
  const double pxpsq =  pow(pxp, 2);
  const double pypsq =  pow(pyp, 2);
  
  double radicant = (rxsq * rysq) - (rxsq * pypsq) - (rysq * pxpsq);
  
  if (radicant < 0) {
      radicant = 0;
  }
  
  radicant /= (rxsq * pypsq) + (rysq * pxpsq);
  radicant = sqrt(radicant) * (largeArcFlag == sweepFlag ? -1 : 1);
  
  const double centerxp = radicant * rx / ry * pyp;
  const double centeryp = radicant * -ry / rx * pxp;
  
  const double centerx = cosphi * centerxp - sinphi * centeryp + (px + cx) / 2;
  const double centery = sinphi * centerxp + cosphi * centeryp + (py + cy) / 2;
  
  const double vx1 = (pxp - centerxp) / rx;
  const double vy1 = (pyp - centeryp) / ry;
  const double vx2 = (-pxp - centerxp) / rx;
  const double vy2 = (-pyp - centeryp) / ry;
  
  double ang1 = vectorAngle(1, 0, vx1, vy1);
  double ang2 = vectorAngle(vx1, vy1, vx2, vy2);
  
  if (sweepFlag == 0 && ang2 > 0) {
      ang2 -= TAU;
  }
  
  if (sweepFlag == 1 && ang2 < 0) {
      ang2 += TAU;
  }
  
  const int segments = (int) MAX(ceil(abs(ang2) / (TAU / 4.0)), 1.0);
  
  ang2 /= segments;
  
  for (int i = 0; i < segments; i++) {
      
      const double a = 4.0 / 3.0 * tan(ang2 / 4.0);
      
      const double x1 = cos(ang1);
      const double y1 = sin(ang1);
      const double x2 = cos(ang1 + ang2);
      const double y2 = sin(ang1 + ang2);
      
      CGPoint p1 = mapToEllipse(x1 - y1 * a, y1 + x1 * a, rx, ry, cosphi, sinphi, centerx, centery);
      CGPoint p2 = mapToEllipse(x2 + y2 * a, y2 - x2 * a, rx, ry, cosphi, sinphi, centerx, centery);
      CGPoint p = mapToEllipse(x2, y2, rx, ry, cosphi, sinphi, centerx, centery);
      
      [view->path curveToPoint:NSMakePoint(p.x, p.y) controlPoint1:NSMakePoint(p1.x, p1.y) controlPoint2:NSMakePoint(p2.x, p2.y)];
      view->currentX = p.x;
      view->currentY = p.y;
      
      ang1 += ang2;
  }
}

void NativeVectorContainer::pathCubicBezier(float x1, float y1, float x2, float y2, float x, float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path curveToPoint:NSMakePoint(x, y) controlPoint1:NSMakePoint(x1, y1) controlPoint2:NSMakePoint(x2, y2)];
  view->currentX = x;
  view->currentY = y;
}

void NativeVectorContainer::pathQuadraticBezier(float x1, float y1, float x, float y)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  float startX = view->currentX;
  float startY = view->currentY;
  NSPoint p1 = NSMakePoint(startX + (x1 - startX) * 2.0 / 3.0, startY + (y1 - startY) * 2.0 / 3.0);
  NSPoint p2 = NSMakePoint(p1.x + (x - startX) / 3.0, p1.y + (y - startY) / 3.0);
  [view->path
    curveToPoint:NSMakePoint(x, y)
    controlPoint1:p1
    controlPoint2:p2
  ];
  view->currentX = x;
  view->currentY = y;
}

void NativeVectorContainer::pathClose()
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path closePath];
}

void NativeVectorContainer::pathStroke(float width, int capsStyle, int joinStyle)
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  view->path.lineWidth = width;

  // enum StrokeLineCap {
  //     Butt;
  //     Square;
  //     Round;
  // }

  // enum StrokeLineJoin {
  //     Miter;
  //     Round;
  //     Bevel;
  // }
  switch(capsStyle) {
    case 0:
      view->path.lineCapStyle = NSLineCapStyleButt;
      break;
    case 1:
      view->path.lineCapStyle = NSLineCapStyleSquare;
      break;
    case 2:
      view->path.lineCapStyle = NSLineCapStyleRound;
      break;
  }
  switch(joinStyle) {
    case 0:
      view->path.lineJoinStyle = NSLineJoinStyleMiter;
      break;
    case 1:
      view->path.lineJoinStyle = NSLineJoinStyleRound;
      break;
    case 2:
      view->path.lineJoinStyle = NSLineJoinStyleBevel;
      break;
  }
  [view->path stroke];
}

void NativeVectorContainer::pathFill()
{
  NativeVectorView * view = (__bridge NativeVectorView *) nativeView;
  [view->path fill];
}

void NativeVectorContainer::endPath()
{
}
