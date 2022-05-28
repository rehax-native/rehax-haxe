package rehax.components.text.web;

using rehax.components.view.View;
using rehax.Style;

#if js
import js.Browser.document;
import js.html.Element;

class Text extends View {
  public function new() {
    super();
  }

  private var textNode:js.html.Text;

  public override function createFragment() {
    textNode = document.createTextNode('');
    element = document.createElement('p');
    element.appendChild(textNode);
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    textNode.textContent = text;
    return text;
  }

  public function get_text():String {
    return textNode.textContent;
  }

  public var color(default, set):Null<Color>;

  public function set_color(color:Null<Color>):Null<Color> {
    cast(element, js.html.DOMElement).style.color = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
    return color;
  }

  public var fontSize(default, set):Null<Float>;

  public function set_fontSize(fontSize:Null<Float>):Null<Float> {
    this.fontSize = fontSize;
    cast(element, js.html.DOMElement).style.fontSize = '${fontSize}px';
    return fontSize;
  }

  public var fontFamilies(default, set):Null<Array<String>>;

  public function set_fontFamilies(fontFamilies:Null<Array<String>>):Null<Array<String>> {
    this.fontFamilies = fontFamilies;
    cast(element, js.html.DOMElement).style.fontFamily = fontFamilies.join(', ');
    return fontFamilies;
  }
}
#end
