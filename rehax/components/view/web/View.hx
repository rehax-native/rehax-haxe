package rehax.components.view.web;

#if js
using rehax.components.root.web.Root;
using rehax.components.view.Layout;

import js.Browser.document;
import js.html.Element;

class View {
  public var parent:Null<View>;
  public var element:Null<js.html.Node>;

  private var hoverStyle:Style;

  public function new() {}

  public function createFragment() {
    var el = document.createElement('div');
    el.style.position = 'relative';
    el.style.display = 'flex';
    el.style.flexDirection = 'column';
    el.style.alignItems = 'flex-start';
    element = el;
  }

  public function mount(parent:View, atIndex:Null<Int> = null) {
    this.parent = parent;
    if (atIndex == null) {
      parent.element.appendChild(element);
    } else {
      // parent.element.insertBefore(element, afterView.element.nextSibling);
      parent.element.insertBefore(element, parent.element.childNodes[atIndex]);
    }
    parent.addChild(this);
  }

  public function unmount() {
    removeFromParent();
    this.parent = null;
  }

  public function destroy() {}

  public function addChild(child:View) {
    child.set_size(child.size);
  }

  public function componentDidMount() {}

  public function removeFromParent() {
    if (element != null && element.parentNode != null) {
      element.parentNode.removeChild(element);
    }
  }

  public var layoutDirection(default, set):LayoutDirection;

  public function set_layoutDirection(layoutDirection:LayoutDirection):LayoutDirection {
    this.layoutDirection = layoutDirection;
    var el = cast(element, js.html.DOMElement);
    switch (layoutDirection) {
      case Vertical:
        el.style.flexDirection = 'column';
      case Horizontal:
        el.style.flexDirection = 'row';
    }
    return layoutDirection;
  }

  public var alignmentMainAxis(default, set):AlignmentMainAxis;

  public function set_alignmentMainAxis(alignmentMainAxis:AlignmentMainAxis):AlignmentMainAxis {
    this.alignmentMainAxis = alignmentMainAxis;
    var el = cast(element, js.html.DOMElement);
    switch (alignmentMainAxis) {
      case Start:
        el.style.justifyContent = 'flex-start';
      case End:
        el.style.justifyContent = 'flex-end';
      case Center:
        el.style.justifyContent = 'center';
      case SpaceBetween:
        el.style.justifyContent = 'space-between';
      case SpaceAround:
        el.style.justifyContent = 'space-around';
      case SpaceEvenly:
        el.style.justifyContent = 'space-evenly';
    }
    return alignmentMainAxis;
  }

  public var alignmentCrossAxis(default, set):AlignmentCrossAxis;

  public function set_alignmentCrossAxis(alignmentCrossAxis:AlignmentCrossAxis):AlignmentCrossAxis {
    this.alignmentCrossAxis = alignmentCrossAxis;
    var el = cast(element, js.html.DOMElement);
    switch (alignmentCrossAxis) {
      case Start:
        el.style.alignItems = 'flex-start';
      case End:
        el.style.alignItems = 'flex-end';
      case Center:
        el.style.alignItems = 'center';
      case Stretch:
        el.style.alignItems = 'stretch';
    }
    return alignmentCrossAxis;
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
      case Flex(prop):
        // flex only makes sense in the flex direction. In the cross direction it's the same as 100%
        var parentFlexDir = el.parentElement != null ? el.parentElement.style.flexDirection : 'column';
        if (parentFlexDir == 'column') {
          el.style.width = '100%';
        } else {
          el.style.width = '';
          el.style.flexGrow = prop + '';
        }
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
      case Flex(prop):
        // flex only makes sense in the flex direction. In the cross direction it's the same as 100%
        var parentFlexDir = el.parentElement != null ? el.parentElement.style.flexDirection : 'column';
        if (parentFlexDir == 'row') {
          el.style.height = '100%';
        } else {
          el.style.height = '';
          el.style.flexGrow = prop + '';
        }
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
}
#end
