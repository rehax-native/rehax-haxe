package rehax.components.vector.cpp;

#if cpp
using rehax.components.view.View;
using rehax.components.vector.Common;
using rehax.components.vector.cpp.Common;

import cpp.Pointer;
import cpp.RawPointer;

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

  public override function createFragment() {}

  public override function mount(parent:View, atIndex:Null<Int> = null) {
    this.parent = parent;
    isMounted = true;
    // parent.addChild(this, );
  }

  public var operations(default, set):Array<VectorPathOperation>;

  public function set_operations(ops:Array<VectorPathOperation>):Array<VectorPathOperation> {
    this.operations = ops;
    return ops;
  }

  public override function drawOp(view:Pointer<NativeVectorContainer>, canvasWidth:Float, canvasHeight:Float) {
    view.ptr.beginPath();
    for (op in operations) {
      switch (op) {
        case HorizontalTo(x):
          view.ptr.pathHorizontalTo(x);
        case VerticalTo(y):
          view.ptr.pathVerticalTo(y);
        case MoveTo(x, y):
          view.ptr.pathMoveTo(x, y);
        case MoveBy(x, y):
          view.ptr.pathMoveBy(x, y);
        case LineTo(x, y):
          view.ptr.pathLineTo(x, y);
        case Arc(rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x, y):
          view.ptr.pathArc(rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x, y);
        case CubicBezier(x1, y1, x2, y2, x, y):
          view.ptr.pathCubicBezier(x1, y1, x2, y2, x, y);
        case QuadraticBezier(x1, y1, x, y):
          view.ptr.pathQuadraticBezier(x1, y1, x, y);
        case Close:
          view.ptr.pathClose();
      }
    }

    var lineWidth = 0.0;
    var lineCap = 0;
    var lineJoin = 0;
    var shouldStroke = false;
    var shouldFill = false;

    for (style in vectorStyle) {
      switch (style) {
        case Fill(color):
          shouldFill = true;
        case Stroke(color):
          shouldStroke = true;
        case StrokeWidth(width):
          lineWidth = width;
        case StrokeLineCap(cap):
          switch (cap) {
            case Butt:
              lineCap = 0;
            case Square:
              lineCap = 1;
            case Round:
              lineCap = 2;
          }
        case StrokeLineJoin(join):
          switch (join) {
            case Miter:
              lineJoin = 0;
            case Round:
              lineJoin = 1;
            case Bevel:
              lineJoin = 2;
          }
      }
    }

    if (shouldStroke) {
      view.ptr.pathStroke(lineWidth, lineCap, lineJoin);
    }
    if (shouldFill) {
      view.ptr.pathFill();
    }

    view.ptr.endPath();
  }
}
#end
