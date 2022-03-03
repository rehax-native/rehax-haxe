package rehax.components.vector.web;

#if js
import js.Browser.document;
import js.html.Element;

using rehax.components.view.View;

class VectorContainer extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    var el = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    el.setAttribute('viewBox', '0 0 100 100');
    el.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
    element = el;
  }

  public var width(get, set):Float;

  public function set_width(width:Float):Float {
    cast(element, js.html.svg.SVGElement).setAttribute('width', Std.string(width) + 'px');
    return width;
  }

  public function get_width():Float {
    return Std.parseFloat(cast(element, js.html.svg.SVGElement).getAttribute('width'));
  }

  public var height(default, set):Float;

  public function set_height(height:Float):Float {
    cast(element, js.html.svg.SVGElement).setAttribute('height', Std.string(height) + 'px');
    return height;
  }

  public function get_height():Float {
    return Std.parseFloat(cast(element, js.html.svg.SVGElement).getAttribute('height'));
  }
}
#end
