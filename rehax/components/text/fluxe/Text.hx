package rehax.components.text.fluxe;

using rehax.components.view.View;

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
}
#end
