package rehax.components.textInput.cpp;

using rehax.components.view.cpp.View;

#if cpp
import cpp.Pointer;
import cpp.RawPointer;

@:include("rehax/components/textInput/cpp/NativeTextInput.h")
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
  function setPlaceholder(text:cpp.ConstCharStar):Void;
  function setTextColor(color:NativeColor):Void;
  function setTextAlignment(alignment:Int):Void;
  function setOnValueChange(onValueChange:() -> Void):Void;
}

enum TextAlignment {
  Left;
  Center;
  Right;
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

  public var value(get, set):String;

  public function set_value(value:String):String {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    textView.ptr.setText(cpp.ConstCharStar.fromString(value));
    return value;
  }

  public function get_value():String {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    return textView.ptr.getText();
  }

  public var onValueChange(null, set):(value:String)->Void;

  public function set_onValueChange(onValueChange:(value:String) -> Void):(value:String)->Void {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    textView.ptr.setOnValueChange(() -> {
      onValueChange(textView.ptr.getText());
    });
    return onValueChange;
  }

  public var placeholder(null, set):String;

  public function set_placeholder(text:String):String {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    textView.ptr.setPlaceholder(cpp.ConstCharStar.fromString(text));
    return text;
  }

  public var textAlignment(null, set):TextAlignment;

  public function set_textAlignment(textAlignment:TextAlignment):TextAlignment {
    var textView:Pointer<NativeTextInput> = native.reinterpret();
    switch (textAlignment) {
      case Left:
        textView.ptr.setTextAlignment(0);
      case Center:
        textView.ptr.setTextAlignment(1);
      case Right:
        textView.ptr.setTextAlignment(2);
    }
    return textAlignment;
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
