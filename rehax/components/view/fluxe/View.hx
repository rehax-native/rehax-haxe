package rehax.components.view.fluxe;

#if fluxe
using rehax.components.layout.Layout;


class View {
  public var parent:Null<View>;

  public var view:Null<fluxe.views.View>;

  public var slots:Map<String, View> = [];

  private var hoverStyle:Style;

  public var children:Array<View> = [];

  public function new() {}

  public function createFragment() {
    view = new fluxe.views.View();
  }

  public function mount(parent:View, atIndex:Null<Int> = null) {
    if (parent.slots.exists('default')) {
      var slot = parent.slots['default'];
      this.parent = slot;
      slot.view.addSubView(view);
      slot.addChild(this);
      this.componentDidMount();
    } else if (parent.view != null) {
      this.parent = parent;
      parent.view.addSubView(view);
      parent.addChild(this);
      this.componentDidMount();
    }
    // TODO
    // if (atIndex == null) {
    //   parent.view.addSubView(view);
    // } else {
    //   // parent.element.insertBefore(element, parent.element.childNodes[atIndex]);
    // }
  }

  public function mountAtSlot(parent:View, slot:String) {
    if (parent.slots.exists(slot)) {
      var slot = parent.slots[slot];
      this.parent = slot;
      slot.addChild(this);
      this.componentDidMount();
    }
  }

  public function unmount() {
    removeFromParent();
    this.parent = null;
  }

  public function destroy() {}

  public function addChild(child:View) {
    children.push(child);
    // child.set_size(child.size);
  }

  public function componentDidMount() {}

  public function removeFromParent() {
    if (this.parent != null) {
      this.parent.view.removeSubView(this.view);
      this.parent != null;
    }
  }

  public var layout(default, set):ILayout;

  public function set_layout(layout:ILayout) {
    this.layout = layout;
    this.view.layout = layout.fluxeLayout;
    return layout;
  }

  public var style(default, set):rehax.Style;

  public function set_style(style:rehax.Style):rehax.Style {
    for (item in style) {
      switch (item) {
        case backgroundColor(color):
          this.view.backgroundColor = fluxe.views.Externs.Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha);
        case textColor(color):
        // view.setBackgroundColor();
        // el.style.color = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
        case opacity(amount):
        // el.style.opacity = Std.string(amount);
      }
    }

    this.style = style;
    // var el = cast(element, js.html.Element);
    // el.setElementStyle(style);
    return style;
  }

  @:isVar
  public var size(default, set):Size = {
    width: SizeDimension.Natural,
    height: SizeDimension.Natural,
  };

  public function set_size(size:Size):Size {
    this.size = size;

    switch (size.width) {
      case Natural:
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.width = null;

      case Fixed(size):
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.width = Fixed(size);

      case Fill:
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.width = Fill;

      case Percentage(percent):
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.width = Percentage(percent);
    }

    switch (size.height) {
      case Natural:
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.height = null;

      case Fixed(size):
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.height = Fixed(size);

      case Fill:
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.height = Fill;

      case Percentage(percent):
        if (this.view.layoutSizeOverride == null) {
          this.view.layoutSizeOverride = {
            width: null,
            height: null,
          };
        }
        this.view.layoutSizeOverride.height = Percentage(percent);
    }

    return size;
  }

  @:isVar
  public var position(default, set):Position;

  public function set_position(position:Position):Position {
    this.position = position;
    // var el = cast(element, js.html.DOMElement);
    // switch (position.left) {
    //   case Natural:
    //     el.style.position = '';
    //     el.style.left = '';
    //   case Fixed(px):
    //     el.style.position = 'absolute';
    //     el.style.left = px + 'px';
    // }
    // switch (position.top) {
    //   case Natural:
    //     el.style.position = '';
    //     el.style.top = '';
    //   case Fixed(px):
    //     el.style.position = 'absolute';
    //     el.style.top = px + 'px';
    // }
    return position;
  }

  public var frame(get, set):Frame;

  public function set_frame(frame:Frame):Frame {
    position = frame.position;
    size = frame.size;
    return frame;
  }

  public function get_frame():Frame {
    return {
      position: position,
      size: size,
    }
  }

  public function addGesture(gesture:Gesture) {
    if (view != null) {
      view.mouseEventListeners.push(gesture.fluxeGesture);
    }
  }
}
#end
