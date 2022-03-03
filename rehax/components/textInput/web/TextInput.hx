package rehax.components.textInput.web;

using rehax.components.view.View;

#if js
import js.Browser.document;
import js.html.Element;

class TextInput extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    element = document.createElement('input');
  }

  public var value(get, set):String;

  public function set_value(value:String):String {
    cast(element, js.html.InputElement).value = value;
    return value;
  }

  public function get_value():String {
    return cast(element, js.html.InputElement).value;
  }

  public var placeholder(get, set):String;

  public function set_placeholder(placeholder:String):String {
    cast(element, js.html.InputElement).placeholder = placeholder;
    return placeholder;
  }

  public function get_placeholder():String {
    return cast(element, js.html.InputElement).placeholder;
  }

  @:isVar
  public var onSubmit(get, set):Void->Void;

  public function set_onSubmit(onSubmit:Void->Void):Void->Void {
    this.onSubmit = onSubmit;
    cast(element, js.html.InputElement).onkeydown = function(event) {
      if (event.keyCode == 13) {
        onSubmit();
      }
    };
    return onSubmit;
  }

  public function get_onSubmit():Void->Void {
    return this.onSubmit;
  }

  public var onChange(null, set):String->Void;

  public function set_onChange(onChange:String->Void):String->Void {
    var el = cast(element, js.html.InputElement);
    el.oninput = function(event) onChange(el.value);
    return onChange;
  }
}
#end
