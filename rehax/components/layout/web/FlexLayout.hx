

package rehax.components.layout.web;

using rehax.components.layout.Layout;
using rehax.components.layout.FlexLayout;

class FlexLayout implements ILayout {
  private var options:FlexLayoutOptions;

  public static function Create(options:FlexLayoutOptions):FlexLayout {
      var layout = new FlexLayout();
      layout.options = options;
      return layout;
  }

  public function new() {}

  public function applyLayout(container:js.html.Node) {

    if (!Std.isOfType(container, js.html.Element)) {
        // return;
    }

    var el = cast(container, js.html.DOMElement);
    el.style.display = 'flex';
    el.style.flexDirection = 'column';
    el.style.justifyContent = 'flex-start';

    for (i in 0...container.childNodes.length) {
        var el = cast(container.childNodes[i], js.html.DOMElement);
        el.style.flexGrow = null;
    }

    if (options.items != null) {
        for (i in 0...options.items.length) {
            var item = options.items[i];
            if (i >= container.childNodes.length) {
                break;
            }
            var el = cast(container.childNodes[i], js.html.DOMElement);

            // el.style.flex = item.flex;
            // el.style.flexDirection = item.flexDirection;
            // el.style.flexWrap = item.flexWrap;
            // el.style.alignItems = item.alignItems;
            // el.style.justifyContent = item.justifyContent;
            // el.style.alignContent = item.alignContent;
            // el.style.order = item.order;
            if (item.flexGrow != null) {
                el.style.flexGrow = '${item.flexGrow}';
            }
            // el.style.flexShrink = item.flexShrink;
            // el.style.flexBasis = item.flexBasis;
            // el.style.alignSelf = item.alignSelf;
            // el.style.justifySelf = item.justifySelf;
        }
    }

    if (options.direction != null) {
        switch (options.direction) {
        case Column:
            el.style.flexDirection = 'column';
        case Row:
            el.style.flexDirection = 'row';
        case ColumnReverse:
            el.style.flexDirection = 'column-reverse';
        case RowReverse:
            el.style.flexDirection = 'row-reverse';
        }
    }

    if (options.justifyContent != null) {
        switch (options.justifyContent) {
        case FlexStart:
            el.style.justifyContent = 'flex-start';
        case FlexEnd:
            el.style.justifyContent = 'flex-end';
        case Center:
            el.style.justifyContent = 'center';
        // case SpaceBetween:
        //     el.style.justifyContent = 'space-between';
        // case SpaceAround:
        //     el.style.justifyContent = 'space-around';
        // case SpaceEvenly:
        //     el.style.justifyContent = 'space-evenly';
        }
    }

    if (options.alignItems != null) {
        switch (options.alignItems) {
        case FlexStart:
            el.style.alignItems = 'flex-start';
        case FlexEnd:
            el.style.alignItems = 'flex-end';
        case Center:
            el.style.alignItems = 'center';
        case Stretch:
            el.style.alignItems = 'stretch';
        }
    }
  }
}