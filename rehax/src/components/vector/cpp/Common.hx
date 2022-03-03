package rehax.components.vector.cpp;

#if cpp
using rehax.components.view.View;
using rehax.Style;
using rehax.components.vector.Common;
using rehax.components.view.cpp.View;

import cpp.Pointer;
import cpp.RawPointer;

class VectorElement extends View {
  public function new() {
    super();
  }

  public function drawOp(view:Pointer<NativeVectorContainer>, canvasWidth:Float, canvasHeight:Float) {}

  public var vectorStyle(default, set):Array<VectorStyleProperty> = [];

  public function set_vectorStyle(styles:Array<VectorStyleProperty>):Array<VectorStyleProperty> {
    this.vectorStyle = styles;
    // var el = cast(element, js.html.svg.GraphicsElement);
    // for (style in styles) {
    //     switch (style) {
    //         case Fill(color):
    //             el.setAttribute('fill', 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})');
    //         case Stroke(color):
    //             el.setAttribute('stroke', 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})');
    //         case StrokeWidth(width):
    //             el.setAttribute('stroke-width', Std.string(width));
    //         case StrokeLineCap(cap):
    //             switch (cap) {
    //                 case Butt:
    //                     el.setAttribute('stroke-linecap', 'butt');
    //                 case Square:
    //                     el.setAttribute('stroke-linecap', 'square');
    //                 case Round:
    //                     el.setAttribute('stroke-linecap', 'round');
    //             }
    //         case StrokeLineJoin(join):
    //             switch (join) {
    //                 case Miter:
    //                     el.setAttribute('stroke-linejoin', 'miter');
    //                 case Round:
    //                     el.setAttribute('stroke-linejoin', 'round');
    //                 case Bevel:
    //                     el.setAttribute('stroke-linejoin', 'bevel');
    //             }
    //     }
    // }
    return styles;
  }
}

@:include("../../../../../../rehax/components/vector/cpp/NativeVectorContainer.h")
@:unreflective
@:native("NativeVectorContainer")
@:structAccess
extern class NativeVectorContainer extends NativeView {
  @:native("new NativeVectorContainer") private static function _new():RawPointer<NativeVectorContainer>;
  public static inline function createInstance():Pointer<NativeVectorContainer> {
    return Pointer.fromRaw(_new());
  }

  function setDrawCallback(cb:Void->Void):Void;

  function circle(cx:Float, cy:Float, radius:Float):Void;

  function beginPath():Void;
  function pathHorizontalTo(x:Float):Void;
  function pathVerticalTo(y:Float):Void;
  function pathMoveTo(x:Float, y:Float):Void;
  function pathMoveBy(x:Float, y:Float):Void;
  function pathLineTo(x:Float, y:Float):Void;
  function pathArc(rx:Float, ry:Float, xAxisRotation:Float, largeArcFlag:Int, sweepFlag:Int, x:Float, y:Float):Void;
  function pathCubicBezier(x1:Float, y1:Float, x2:Float, y2:Float, x:Float, y:Float):Void;
  function pathQuadraticBezier(x1:Float, y1:Float, x:Float, y:Float):Void;
  function pathClose():Void;
  function pathStroke(width:Float, capsStyle:Int, joinStyle:Int):Void;
  function pathFill():Void;
  function endPath():Void;
}
#end
