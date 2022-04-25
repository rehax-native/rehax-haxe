package rehax.components.vector.fluxeImpl;

#if fluxe

using rehax.components.vector.fluxeImpl.Common;
using fluxe.views.Externs;
using fluxe.views.ViewBuilder;

enum VectorPathOperation {
  HorizontalTo(x:Float);
  VerticalTo(y:Float);
  MoveTo(x:Float, y:Float);
  MoveBy(x:Float, y:Float);
  LineTo(x:Float, y:Float);
  Arc(rx:Float, ry:Float, xAxisRotation:Float, largeArcFlag:Int, sweepFlag:Int, x:Float, y:Float);
  CubicBezier(x1:Float, y1:Float, x2:Float, y2:Float, x:Float, y:Float);
  QuadraticBezier(x1:Float, y1:Float, x:Float, y:Float);
  Close;
}

class VectorPath extends VectorElement {
  public function new() {
    super();
  }

  public override function draw(builder:ViewBuilder) {
    var paints = makePaints();
    var path = new fluxe.views.Externs.Path();
    var currentX = 0.0;
    var currentY = 0.0;

    for (op in operations) {
      switch (op) {
        case HorizontalTo(x):
          path.moveTo(x, currentY);
          currentX = x;
        case VerticalTo(y):
          path.moveTo(currentX, y);
          currentY = y;
        case MoveTo(x, y):
          path.moveTo(x, y);
          currentX = x;
          currentY = y;
        case MoveBy(x, y):
          currentX += x;
          currentY += y;
          path.moveTo(currentX, currentY);
        case LineTo(x, y):
          path.lineTo(x, y);
          currentX = x;
          currentY = y;
        case Arc(rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x, y):
          untyped __cpp__('fluxe::ArcSize _arcSize = fluxe::ArcSize::kSmall_ArcSize');
          if (largeArcFlag > 0) {
            untyped __cpp__('_arcSize = fluxe::ArcSize::kLarge_ArcSize');
          }
          untyped __cpp__('fluxe::PathDirection _sweepFlag = fluxe::PathDirection::kCCW');
          if (sweepFlag > 0) {
            untyped __cpp__('_sweepFlag = fluxe::PathDirection::kCW');
          }
          untyped __cpp__('path.arcTo(( (double)(rx) ),( (double)(ry) ),( (double)(xAxisRotation) ),_arcSize,_sweepFlag,( (double)(x) ),( (double)(y) ))');
					currentX = x;
          currentY = y;
        case CubicBezier(x1, y1, x2, y2, x, y):
          path.cubicTo(x1, y1, x2, y2, x, y);
          currentX = x;
          currentY = y;
        case QuadraticBezier(x1, y1, x, y):
          path.quadTo(x1, y1, x, y);
        case Close:
          path.close();
      }
    }

    if (paints.hasFill) {
      var paint = paints.fill;
      builder.canvas.drawPath(path, paint);
    }
    if (paints.hasStroke) {
      var paint = paints.stroke;
      builder.canvas.drawPath(path, paint);
    }
  }

  public var operations:Array<VectorPathOperation> = [];
}
#end
