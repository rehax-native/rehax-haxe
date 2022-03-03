package rehax.components.button.cpp;

using rehax.components.view.Layout;
using rehax.components.view.cpp.View;
using rehax.components.view.Layout;

#if cpp
import cpp.Pointer;
import cpp.RawPointer;

@:include("../../../../../../rehax/components/button/cpp/NativeButton.h")
@:unreflective
@:native("NativeButton")
@:structAccess
extern class NativeButton extends NativeView {
  @:native("new NativeButton") private static function _new():RawPointer<NativeButton>;
  public static inline function createInstance():Pointer<NativeButton> {
    return Pointer.fromRaw(_new());
  }

  function setText(text:cpp.ConstCharStar):Void;
  function getText():cpp.ConstCharStar;
  function setTextColor(color:NativeColor):Void;
  function setOnClick(onClick:Void->Void):Void;
}

class Button extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    var button = NativeButton.createInstance();
    native = button.reinterpret();
    button.ptr.createFragment();
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    var button:Pointer<NativeButton> = native.reinterpret();
    button.ptr.setText(cpp.ConstCharStar.fromString(text));
    return text;
  }

  public function get_text():String {
    var button:Pointer<NativeButton> = native.reinterpret();
    return button.ptr.getText();
  }

  public override function setElementStyle(style:Style) {
    for (item in style) {
      switch (item) {
        case textColor(color):
          var button:Pointer<NativeButton> = native.reinterpret();
          button.ptr.setTextColor(NativeColor.create(color.red, color.green, color.blue, color.alpha));
        default:
          super.setElementStyle(style);
      }
    }
  }

  @:isVar
  public var onClick(get, set):Void->Void;

  public function set_onClick(onClick:Void->Void):Void->Void {
    var button:Pointer<NativeButton> = native.reinterpret();
    this.onClick = onClick;
    button.ptr.setOnClick(onClick);
    return onClick;
  }

  public function get_onClick():Void->Void {
    return this.onClick;
  }
}
#end
