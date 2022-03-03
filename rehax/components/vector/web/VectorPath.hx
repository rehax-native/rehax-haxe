package rehax.components.vector.web;

#if js
import js.Browser.document;
import js.html.Element;

using rehax.components.view.View;
using rehax.components.vector.Common;
using rehax.components.vector.web.Common;

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
  static function convertPathOperationToSvgOperation(op:VectorPathOperation) {
    switch (op) {
      case HorizontalTo(x):
        return 'H $x';
      case VerticalTo(y):
        return 'V $y';
      case MoveTo(x, y):
        return 'M $x $y';
      case MoveBy(x, y):
        return 'm $x $y';
      case LineTo(x, y):
        return 'L $x $y';
      case Arc(rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x, y):
        return 'A $rx $ry $xAxisRotation $largeArcFlag $sweepFlag $x $y';
      case CubicBezier(x1, y1, x2, y2, x, y):
        return 'C $x1 $y1 $x2 $y2 $x $y';
      case QuadraticBezier(x1, y1, x, y):
        return 'Q $x1 $y1 $x $y';
      case Close:
        return 'z';
    }
  }

  public function new() {
    super();
  }

  public override function createFragment() {
    var el = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    element = el;
  }

  public var operations(default, set):Array<VectorPathOperation>;

  public function set_operations(ops:Array<VectorPathOperation>):Array<VectorPathOperation> {
    this.operations = ops;
    var el = cast(element, js.html.svg.PathElement);
    el.setAttribute('d', ops.map(VectorPath.convertPathOperationToSvgOperation).join(' '));
    return ops;
  }
}
#end
