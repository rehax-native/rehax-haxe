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
    if (options.direction != null) {
      switch (options.direction) {
        case Column:
          layout.flexLayout.direction = Column;
        case Row:
          layout.flexLayout.direction = Row;
        case ColumnReverse:
          layout.flexLayout.direction = ColumnReverse;
        case RowReverse:
          layout.flexLayout.direction = RowReverse;
      }
    }
    if (options.items != null) {
      layout.flexLayout.itemInfos = options.items;
    }
    return layout;
  }
}