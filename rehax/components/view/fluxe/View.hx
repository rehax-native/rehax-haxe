package rehax.components.view.fluxe;

#if fluxe
using rehax.components.layout.Layout;


class View {
  public var parent:Null<View>;

  public var view:Null<fluxe.views.View>;

  private var hoverStyle:Style;

  public var children:Array<View> = [];

  public function new() {}

  public function createFragment() {
    view = new fluxe.views.View();
  }

  public function mount(parent:View, atIndex:Null<Int> = null) {
    this.parent = parent;
    parent.view.addSubView(view);
    // TODO
    // if (atIndex == null) {
    //   parent.view.addSubView(view);
    // } else {
    //   // parent.element.insertBefore(element, parent.element.childNodes[atIndex]);
    // }
    parent.addChild(this);
    this.componentDidMount();
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
    // var el = cast(element, js.html.DOMElement);
    // el.style.flexGrow = '';
    // switch (size.width) {
    //   case Natural:
    //     if (this.view.layoutConstraints != null) {
    //       this.view.layoutConstraints.width = null;
    //     }
    //   case Fixed(px):
    //     if (this.view.layoutConstraints == null) {
    //       this.view.layoutConstraints = {};
    //     }
    //     this.view.layoutConstraints.width = px;
    //   case Fill:
    // //     el.style.width = '100%';
    //   case Percentage(pc):
    // //     el.style.width = pc + '%';
    // }
    // switch (size.height) {
    //   case Natural:
    //     if (this.view.layoutConstraints != null) {
    //       this.view.layoutConstraints.height = null;
    //     }
    //   case Fixed(px):
    //     if (this.view.layoutConstraints == null) {
    //       this.view.layoutConstraints = {};
    //     }
    //     this.view.layoutConstraints.height = px;
    //   case Fill:
    // //     el.style.height = '100%';
    //   case Percentage(pc):
    // //     el.style.height = pc + '%';
    // }
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
}
#end
