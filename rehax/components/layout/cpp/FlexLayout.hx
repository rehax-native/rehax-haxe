package rehax.components.layout.cpp;

#if cpp

@:include("rehax/components/layout/cpp/NativeFlexLayout.h")
@:unreflective
@:native("NativeFlexItem")
@:structAccess
extern class NativeFlexItem {
  @:native("NativeFlexItem") public function new();
  public var flexGrow:Float;
  public var hasFlexGrow:Bool;
  public var alignSelf:Int;
}

@:include("rehax/components/layout/cpp/NativeFlexLayout.h")
@:unreflective
@:native("NativeFlexLayout")
@:structAccess
extern class NativeFlexLayout {
  @:native("NativeFlexLayout") public function new();
  public extern function layoutContainer(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;
  public extern function setOptions(
    isHorizontal:Bool,
    isReverse:Bool,
    justifyContent:Int,
    alignItems:Int
  ):Void;

  public extern function clearItems():Void;
  public extern function addItem(item:NativeFlexItem):Void;
}

class FlexLayout implements rehax.components.layout.Layout.ILayout {

  public static function Create(options:rehax.components.layout.FlexLayout.FlexLayoutOptions) {
		var layout = new FlexLayout(
      options.direction == Row || options.direction == RowReverse,
      options.direction == ColumnReverse || options.direction == RowReverse,
      options.justifyContent != null ? options.justifyContent : FlexStart,
      options.alignItems != null ? options.alignItems : FlexStart,
      options.items
    );
    return layout;
  }

  var items:Array<rehax.components.layout.FlexLayout.FlexItem> = [];
  var isHorizontal:Bool;
  var isReverse:Bool;
  var justifyContent:Int;
  var alignItems:Int;

  public function new(isHorizontal:Bool, isReverse:Bool, justifyContent:rehax.components.layout.FlexLayout.FlexJustifyContent, alignItems:rehax.components.layout.FlexLayout.FlexAlignItems, items:Array<rehax.components.layout.FlexLayout.FlexItem>) {
    this.nativeLayout = new NativeFlexLayout();
    this.items = items;
    this.isHorizontal = isHorizontal;
    this.isReverse = isReverse;
    this.justifyContent = justifyContent;
    this.alignItems = alignItems;
  }

  private var nativeLayout:NativeFlexLayout;

  public function layout(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>) {
    nativeLayout.clearItems();
    if (items != null) {
      for (item in items) {
        var n = new NativeFlexItem();
        n.hasFlexGrow = item.flexGrow != null;
        if (n.hasFlexGrow) {
          n.flexGrow = item.flexGrow;
        }
        if (item.alignSelf != null) {
          n.alignSelf = item.alignSelf;
        } else {
          n.alignSelf = -1;
        }
        nativeLayout.addItem(n);
      }
    }
    nativeLayout.setOptions(
      isHorizontal,
      isReverse,
      justifyContent,
      alignItems
    );
    nativeLayout.layoutContainer(container);
  }
}

#end
