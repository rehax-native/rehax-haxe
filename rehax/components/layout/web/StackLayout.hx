

package rehax.components.layout.web;

using rehax.components.layout.Layout;
using rehax.components.layout.StackLayout;

class StackLayout implements ILayout {
  private var options:StackLayoutOptions;

  public static function Create(options:StackLayoutOptions):StackLayout {
      var layout = new StackLayout();
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

    if (options.direction != null) {
        switch (options.direction) {
        case Vertical:
            el.style.flexDirection = 'column';
        case Horizontal:
            el.style.flexDirection = 'row';
        }
    } else {
        el.style.flexDirection = 'column';
    }

    if (options.spacing != null) {
        el.style.gap = '${options.spacing}px';
    } else {
        el.style.gap = '5px';
    }
  }
}