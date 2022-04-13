package rehax.components.layout.fluxe;

using rehax.components.layout.Layout;
using rehax.components.layout.FlexLayout;

class FlexLayout implements ILayout {
  public var flexLayout = new fluxe.layout.FlexLayout();
  public var fluxeLayout:fluxe.layout.ILayout;

  public function new() {
    flexLayout.direction = Column;
    fluxeLayout = flexLayout;
  }

  public static function Create(options:FlexLayoutOptions) {
    var layout = new FlexLayout();
    layout.flexLayout.itemInfos = options.items;
    // TODO set direction
    return layout;
  }
}