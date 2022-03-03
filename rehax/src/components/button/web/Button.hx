package rehax.components.button.web;

using rehax.components.view.View;

#if js
import js.Browser.document;
import js.html.Element;

class Button extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    element = document.createElement('button');
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    cast(element, js.html.ButtonElement).innerText = text;
    return text;
  }

  public function get_text():String {
    return cast(element, js.html.ButtonElement).innerText;
  }

  @:isVar
  public var onClick(get, set):Void->Void;

  public function set_onClick(onClick:Void->Void):Void->Void {
    this.onClick = onClick;
    cast(element, js.html.ButtonElement).onclick = function(event) {
      onClick();
    };
    return onClick;
  }

  public function get_onClick():Void->Void {
    return this.onClick;
  }
}
#end
