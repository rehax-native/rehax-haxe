package rehax.components.layout.fluxe;

class StackLayout implements ILayout {
  public var fluxeLayout = new fluxe.layout.StackLayout();
  public function new() {}
  public static function Create(options:StackLayoutOptions) {
    var layout = new StackLayout();
    // TODO set direction
    return layout;
  }
}