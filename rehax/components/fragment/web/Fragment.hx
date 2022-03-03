package rehax.components.fragment.web;

using rehax.components.view.View;

#if js
import js.Browser.document;
import js.html.Element;

class Fragment extends View {
  public function new() {
    super();
  }

  public override function createFragment() {}

  public override function mount(parent:View, atIndex:Null<Int> = null) {
    element = parent.element;
  }
}
#end
