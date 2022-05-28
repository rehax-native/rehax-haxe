package rehax.components.view.web;

#if js
using rehax.components.root.web.Root;
using rehax.components.layout.Layout;

import js.Browser.document;
import js.html.Element;

class View {
  public var parent:Null<View>;
  public var element:Null<js.html.Node>;

  public var slots:Map<String, View> = [];
  private var hoverStyle:Style;

  public function new() {}

  public function createFragment() {
    var el = document.createElement('div');
    el.style.position = 'relative';
    // el.style.display = 'flex';
    // el.style.flexDirection = 'column';
    // el.style.alignItems = 'flex-start';
    element = el;
  }

  public function mount(parent:View, atIndex:Null<Int> = null) {
    if (parent.slots.exists('default')) {
      var slot = parent.slots['default'];
      this.parent = slot;

      if (atIndex == null) {
        slot.element.appendChild(element);
      } else {
        slot.element.insertBefore(element, slot.element.childNodes[atIndex]);
      }

      slot.addChild(this);
      this.componentDidMount();
    } else if (parent.element != null) {
      this.parent = parent;
      if (atIndex == null) {
        parent.element.appendChild(element);
      } else {
        parent.element.insertBefore(element, parent.element.childNodes[atIndex]);
      }
      parent.addChild(this);
      this.componentDidMount();
    }

    parent.addChild(this);
    this.componentDidMount();
  }

  public function unmount() {
    removeFromParent();
    this.parent = null;
  }

  public function destroy() {}

  public function addChild(child:View) {
  }

  public function componentDidMount() {}

  public function removeFromParent() {
    if (element != null && element.parentNode != null) {
      element.parentNode.removeChild(element);
    }
  }

  public var layout(default, set):ILayout;

  public function set_layout(layout:ILayout) {
    this.layout = layout;
    layout.applyLayout(element);
    return layout;
  }

  public var style(default, set):rehax.Style;

  public function set_style(style:rehax.Style):rehax.Style {
    this.style = style;
    var el = cast(element, js.html.Element);
    el.setElementStyle(style);
    return style;
  }

  @:isVar
  public var size(default, set):Size = {
    width: SizeDimension.Natural,
    height: SizeDimension.Natural,
  };

  public function set_size(size:Size):Size {
    this.size = size;
    var el = cast(element, js.html.DOMElement);
    el.style.flexGrow = '';
    switch (size.width) {
      case Natural:
        el.style.width = '';
      case Fixed(px):
        el.style.width = px + 'px';
      case Fill:
        el.style.width = '100%';
      case Percentage(pc):
        el.style.width = pc + '%';
    }
    switch (size.height) {
      case Natural:
        el.style.height = '';
      case Fixed(px):
        el.style.height = px + 'px';
      case Fill:
        el.style.height = '100%';
      case Percentage(pc):
        el.style.height = pc + '%';
    }
    return size;
  }

  @:isVar
  public var position(default, set):Position;

  public function set_position(position:Position):Position {
    this.position = position;
    var el = cast(element, js.html.DOMElement);
    switch (position.left) {
      case Natural:
        el.style.position = '';
        el.style.left = '';
      case Fixed(px):
        el.style.position = 'absolute';
        el.style.left = px + 'px';
    }
    switch (position.top) {
      case Natural:
        el.style.position = '';
        el.style.top = '';
      case Fixed(px):
        el.style.position = 'absolute';
        el.style.top = px + 'px';
    }
    return position;
  }

  public var frame(get, set):Frame;

  public function set_frame(frame:Frame):Frame {
    position = frame.position;
    size = frame.size;
    return frame;
  }

  public function get_frame():Frame {
    var el = cast(element, js.html.DOMElement);
    return {
      position: position,
      size: size,
    }
  }

  public function addGesture(gesture:Gesture) {
    // if (view != null) {
    //   view.mouseEventListeners.push(gesture.fluxeGesture);
    // }
  }
}
#end
