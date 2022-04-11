package rehax.components.text.cpp;

using rehax.components.view.cpp.View;

#if cpp
import cpp.Pointer;
import cpp.RawPointer;

@:include("rehax/components/text/cpp/NativeText.h")
@:unreflective
@:native("NativeText")
@:structAccess
extern class NativeText extends NativeView {
  @:native("new NativeText") private static function _new():RawPointer<NativeText>;
  public static inline function createInstance():Pointer<NativeText> {
    return Pointer.fromRaw(_new());
  }

  function setText(text:cpp.ConstCharStar):Void;
  function getText():cpp.ConstCharStar;
  function setTextColor(color:NativeColor):Void;
}

class Text extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    var text = NativeText.createInstance();
    native = text.reinterpret();
    text.ptr.createFragment();
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    var textView:Pointer<NativeText> = native.reinterpret();
    textView.ptr.setText(cpp.ConstCharStar.fromString(text));
    return text;
  }

  public function get_text():String {
    var textView:Pointer<NativeText> = native.reinterpret();
    return textView.ptr.getText();
  }

  public override function setElementStyle(style:Style) {
    for (item in style) {
      switch (item) {
        case textColor(color):
          var textView:Pointer<NativeText> = native.reinterpret();
          textView.ptr.setTextColor(NativeColor.create(color.red, color.green, color.blue, color.alpha));
        default:
          super.setElementStyle(style);
      }
    }
  }
}
#end
