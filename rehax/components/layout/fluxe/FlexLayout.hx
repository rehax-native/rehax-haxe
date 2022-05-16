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
          layout.flexLayout.direction = fluxe.layout.FlexLayout.FlexDirection.Column;
        case Row:
          layout.flexLayout.direction = fluxe.layout.FlexLayout.FlexDirection.Row;
        case ColumnReverse:
          layout.flexLayout.direction = fluxe.layout.FlexLayout.FlexDirection.ColumnReverse;
        case RowReverse:
          layout.flexLayout.direction = fluxe.layout.FlexLayout.FlexDirection.RowReverse;
      }
    }

    if (options.justifyContent != null) {
      switch (options.justifyContent) {
        case FlexStart:
          layout.flexLayout.justifyContent = fluxe.layout.FlexLayout.FlexJustifyContent.FlexStart;
        case FlexEnd:
          layout.flexLayout.justifyContent = fluxe.layout.FlexLayout.FlexJustifyContent.FlexEnd;
        case Center:
          layout.flexLayout.justifyContent = fluxe.layout.FlexLayout.FlexJustifyContent.Center;
        // case SpaceBetween:
        //   layout.flexLayout.justifyContent = fluxe.layout.FlexLayout.FlexJustifyContent.SpaceBetween;
        // case SpaceAround:
        //   layout.flexLayout.justifyContent = fluxe.layout.FlexLayout.FlexJustifyContent.SpaceAround;
      }
    }

    if (options.alignItems != null) {
      switch (options.alignItems) {
        case FlexStart:
          layout.flexLayout.alignItems = fluxe.layout.FlexLayout.FlexAlignItems.FlexStart;
        case FlexEnd:
          layout.flexLayout.alignItems = fluxe.layout.FlexLayout.FlexAlignItems.FlexEnd;
        case Center:
          layout.flexLayout.alignItems = fluxe.layout.FlexLayout.FlexAlignItems.Center;
        // case Baseline:
        //   layout.flexLayout.alignItems = fluxe.layout.FlexLayout.FlexAlignItems.Baseline;
        case Stretch:
          layout.flexLayout.alignItems = fluxe.layout.FlexLayout.FlexAlignItems.Stretch;
      }
    }

    if (options.items != null) {
      layout.flexLayout.itemInfos = options.items.map((item) -> {
        return {
          order: item.order,
          flexGrow: item.flexGrow,
          alignSelf: switch (item.alignSelf) {
            case FlexStart: fluxe.layout.FlexLayout.FlexAlignItems.FlexStart;
            case FlexEnd: fluxe.layout.FlexLayout.FlexAlignItems.FlexEnd;
            case Center: fluxe.layout.FlexLayout.FlexAlignItems.Center;
            case Stretch: fluxe.layout.FlexLayout.FlexAlignItems.Stretch;
          }
        };
      });
    }
    return layout;
  }
}