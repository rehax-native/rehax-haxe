package rehax.components.text.cpp;

using rehax.components.view.cpp.View;
using rehax.Style;

#if cpp
import cpp.Pointer;
import cpp.RawPointer;


@:include("iostream")
@:native("std::string")
@:unreflective
@:structAccess
extern class StdString {
    @:native("std::string")
    public static function Create(str:String):StdString;
}

@:include("vector")
@:native("std::vector<std::string>")
@:unreflective
@:structAccess
extern class FontFamiliyVector {
    @:native("std::vector<std::string>")
    public static function Create():FontFamiliyVector;
    public function push_back(str:StdString):Void;
}

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
  function setFontSize(size:Float):Void;
  function setFontFamilies(fontFamilies:FontFamiliyVector):Void;
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

  public var color(default, set):Null<Color>;

  public function set_color(color:Null<Color>):Null<Color> {
    this.color = color;
    var textView:Pointer<NativeText> = native.reinterpret();
    textView.ptr.setTextColor(NativeColor.create(color.red, color.green, color.blue, color.alpha));
    return color;
  }

  public var fontSize(default, set):Null<Float>;

  public function set_fontSize(fontSize:Null<Float>):Null<Float> {
    this.fontSize = fontSize;
    var textView:Pointer<NativeText> = native.reinterpret();
    textView.ptr.setFontSize(fontSize);
    return fontSize;
  }

  public var fontFamilies(default, set):Null<Array<String>>;

  public function set_fontFamilies(fontFamilies:Null<Array<String>>):Null<Array<String>> {
    this.fontFamilies = fontFamilies;
    var vec = FontFamiliyVector.Create();
    for (fam in fontFamilies) {
      vec.push_back(StdString.Create(fam));
    }
    var textView:Pointer<NativeText> = native.reinterpret();
    textView.ptr.setFontFamilies(vec);
    return fontFamilies;
  }
}

#end
