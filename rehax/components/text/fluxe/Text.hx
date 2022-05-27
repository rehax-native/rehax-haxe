package rehax.components.text.fluxe;

using rehax.components.view.View;
using rehax.Style;

#if fluxe

class Text extends View {
  public function new() {
    super();
  }

  private var fluxeText:fluxe.views.Text;

  public override function createFragment() {
    fluxeText = new fluxe.views.Text();
    view = fluxeText;
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    this.fluxeText.text = text;
    return text;
  }

  public function get_text():String {
    return this.fluxeText.text;
  }

  public var color(default, set):Null<Color>;

  public function set_color(color:Null<Color>):Null<Color> {
    this.color = color;
    this.fluxeText.textColor = fluxe.views.Externs.Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha);
    return color;
  }

  public var fontSize(default, set):Null<Float>;

  public function set_fontSize(fontSize:Null<Float>):Null<Float> {
    this.fontSize = fontSize;
    this.fluxeText.textSize = fontSize;
    return fontSize;
  }

  public var fontFamilies(default, set):Null<Array<String>>;

  public function set_fontFamilies(fontFamilies:Null<Array<String>>):Null<Array<String>> {
    this.fontFamilies = fontFamilies;
    this.fluxeText.fontFamilies = fontFamilies;
    return fontFamilies;
  }
}

#end
