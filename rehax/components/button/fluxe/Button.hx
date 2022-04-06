package rehax.components.button.fluxe;

using rehax.components.view.View;

#if fluxe

class Button extends View {
  public function new() {
    super();
  }

  private var button:fluxe.views.Button;

  public override function createFragment() {
    button = new fluxe.views.Button();
    view = button;
  }

  public var text(get, set):String;

  public function set_text(text:String):String {
    button.title.text = text;
    return text;
  }

  public function get_text():String {
    return button.title.text;
  }

  @:isVar
  public var onClick(get, set):Void->Void;

  public function set_onClick(onClick:Void->Void):Void->Void {
    this.onClick = onClick;
    this.button.onClick = function(button:fluxe.views.Button) {
      onClick();
    };
    return onClick;
  }

  public function get_onClick():Void->Void {
    return this.onClick;
  }
}
#end
