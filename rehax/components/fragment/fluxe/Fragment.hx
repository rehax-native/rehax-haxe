package rehax.components.fragment.fluxe;

using rehax.components.view.View;

#if fluxe

class Fragment extends View {
  public function new() {
    super();
  }

  public override function createFragment() {}

  public override function mount(parent:View, atIndex:Null<Int> = null) {
    view = parent.view;
  }
}
#end
