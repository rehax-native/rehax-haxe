package rehax.components.text.web;

using rehax.components.view.View;

#if js
import js.Browser.document;
import js.html.Element;

class Text extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    element = document.createTextNode('');
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    cast(element, js.html.Text).textContent = text;
    return text;
  }

  public function get_text():String {
    return cast(element, js.html.Text).textContent;
  }
}
#end
