package rehax.components.root.web;

using rehax.components.view.View;

#if js
import js.Browser.document;
import js.html.Element;
import js.html.DOMElement;

using Root.ElementStyleExtender;

class ElementStyleExtender {
  static public function setElementStyle(el:Element, style:Style) {
    for (item in style) {
      switch (item) {
        case backgroundColor(color):
          el.style.backgroundColor = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
        case textColor(color):
          el.style.color = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
        case opacity(amount):
          el.style.opacity = Std.string(amount);
      }
    }
  }
}

class Root extends View {
  public function new() {
    super();
  }

  public function initialize(onReady:Void->Void) {
    document.addEventListener("DOMContentLoaded", function(event) {
      element = document.querySelector("#root-container");
      while (element.firstChild != null) {
        element.removeChild(element.firstChild);
      }
      onReady();
    });
  }

  public override function addChild(child:View) {
    if (Std.is(child.element, js.html.DOMElement)) {
      cast(child.element, js.html.DOMElement).style.flex = '1 1 auto';
    }
  }

  public override function set_style(style:rehax.Style):rehax.Style {
    var el = document.querySelector("body");
    el.setElementStyle(style);
    return style;
  }
}
#end
