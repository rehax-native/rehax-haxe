package rehax.components.textInput.fluxe;

using rehax.components.view.View;

#if fluxe

// TODO implement all methods

class TextInput extends View {
  public function new() {
    super();
  }

  private var textInput:fluxe.views.TextInput;

  public override function createFragment() {
    textInput = new fluxe.views.TextInput();
    view = textInput;
  }

  public var value(get, set):String;

  public function set_value(value:String):String {
    textInput.value = value;
    return value;
  }

  public function get_value():String {
    return textInput.value;
  }

  public var onValueChange(get, set):(value:String)->Void;

  public function get_onValueChange():(value:String)->Void {
    return textInput.onValueChange;
  }

  public function set_onValueChange(onValueChange:(value:String) -> Void):(value:String)->Void {
    textInput.onValueChange = onValueChange;
    return onValueChange;
  }

  public var placeholder(get, set):String;

  public function set_placeholder(placeholder:String):String {
    // cast(element, js.html.InputElement).placeholder = placeholder;
    return placeholder;
  }

  public function get_placeholder():String {
    // return cast(element, js.html.InputElement).placeholder;
    return "";
  }

  @:isVar
  public var onSubmit(get, set):Void->Void;

  public function set_onSubmit(onSubmit:Void->Void):Void->Void {
    this.onSubmit = onSubmit;
    // cast(element, js.html.InputElement).onkeydown = function(event) {
    //   if (event.keyCode == 13) {
    //     onSubmit();
    //   }
    // };
    return onSubmit;
  }

  public function get_onSubmit():Void->Void {
    return this.onSubmit;
  }

}
#end
