package rehax.components.layout.fluxe;

using rehax.components.layout.Layout;
using rehax.components.layout.StackLayout;

class StackLayout implements ILayout {
  public var stackLayout = new fluxe.layout.StackLayout();
  public var fluxeLayout:fluxe.layout.ILayout;

  public function new() {
    fluxeLayout = stackLayout;
  }

  public static function Create(options:StackLayoutOptions) {
    var layout = new StackLayout();
		layout.stackLayout.layoutDirection = options.direction == Horizontal ? Horizontal : Vertical;
		layout.stackLayout.spacing = options.spacing;
    return layout;
  }
}