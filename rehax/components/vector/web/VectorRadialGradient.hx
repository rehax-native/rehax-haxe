package rehax.components.vector.web;

#if js
import js.Browser.document;
import js.html.Element;

using rehax.Style;
using rehax.components.view.View;
using rehax.components.vector.Common;
using rehax.components.vector.web.Common;

class VectorRadialGradient extends VectorElement {
  public function new() {
    super();
  }

  public override function createFragment() {
    var el = document.createElementNS('http://www.w3.org/2000/svg', 'radialGradient');
    element = el;
  }

  public var id(default, set):String;

  public function set_id(id:String):String {
    cast(element, js.html.svg.RadialGradientElement).setAttribute('id', id);
    return id;
  }

  public var stops(default, set):Array<{
    var offset:Float;
    var color:Color;
  }>;

	public function set_stops(stops:Array<{
		var offset:Float;
		var color:Color;
	}>):Array<{
		var offset:Float;
		var color:Color;
	}> {
    var el = cast(element, js.html.svg.RadialGradientElement);
    while (el.childNodes.length > 0) {
      el.removeChild(el.childNodes[0]);
    }
    for (stop in stops) {
      var stopEl = document.createElementNS('http://www.w3.org/2000/svg', 'stop');
      stopEl.setAttribute('offset', Std.string(stop.offset));
      stopEl.setAttribute('stop-color', 'rgba(${stop.color.red}, ${stop.color.green}, ${stop.color.blue}, ${stop.color.alpha})');
      el.appendChild(stopEl);
    }
    return stops;
  }
}
#end
