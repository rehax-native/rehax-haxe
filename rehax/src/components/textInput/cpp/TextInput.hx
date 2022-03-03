package rehax.components.textInput.cpp;

using rehax.components.view.Layout;
using rehax.components.view.cpp.View;

#if cpp
import cpp.Pointer;
import cpp.RawPointer;

@:include("../../../../../../rehax/components/textInput/cpp/NativeTextInput.h")
@:unreflective
@:native("NativeTextInput")
@:structAccess
extern class NativeTextInput extends NativeView {
  @:native("new NativeTextInput") private static function _new():RawPointer<NativeTextInput>;
  public static inline function createInstance():Pointer<NativeTextInput> {
    return Pointer.fromRaw(_new());
  }

  function setText(text:cpp.ConstCharStar):Void;
  function getText():cpp.ConstCharStar;
  function setTextColor(color:NativeColor):Void;
}

class TextInput extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    var text = NativeTextInput.createInstance();
    native = text.reinterpret();
    text.ptr.createFragment();
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    textView.ptr.setText(cpp.ConstCharStar.fromString(text));
    return text;
  }

  public function get_text():String {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    return textView.ptr.getText();
  }

  public override function setElementStyle(style:Style) {
    for (item in style) {
      switch (item) {
        case textColor(color):
          var textView:Pointer<NativeTextInput> = native.reinterpret();
          textView.ptr.setTextColor(NativeColor.create(color.red, color.green, color.blue, color.alpha));
        default:
          super.setElementStyle(style);
      }
    }
  }
}
#end
