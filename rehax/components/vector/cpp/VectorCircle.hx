package rehax.components.vector.cpp;

#if cpp
using rehax.components.view.View;
using rehax.components.vector.Common;
using rehax.components.vector.cpp.Common;

class VectorCircle extends VectorElement {
  public function new() {
    super();
  }

  public override function createFragment() {
    // var el = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
    // element = el;
  }

  public var centerX(get, set):Float;

  public function set_centerX(cx:Float):Float {
    // cast(element, js.html.svg.CircleElement).setAttribute('cx', Std.string(cx));
    return cx;
  }

  public function get_centerX():Float {
    // return Std.parseFloat(cast(element, js.html.svg.CircleElement).getAttribute('cx'));
    return 0;
  }

  public var centerY(get, set):Float;

  public function set_centerY(cy:Float):Float {
    // cast(element, js.html.svg.CircleElement).setAttribute('cy', Std.string(cy));
    return cy;
  }

  public function get_centerY():Float {
    // return Std.parseFloat(cast(element, js.html.svg.CircleElement).getAttribute('cy'));
    return 0;
  }

  public var radius(get, set):Float;

  public function set_radius(radius:Float):Float {
    // cast(element, js.html.svg.CircleElement).setAttribute('r', Std.string(radius));
    return radius;
  }

  public function get_radius():Float {
    // return Std.parseFloat(cast(element, js.html.svg.CircleElement).getAttribute('r'));
    return 0;
  }
}
#end
