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
}

@:include("rehax/components/layout/cpp/NativeFlexLayout.h")
@:unreflective
@:native("NativeFlexLayout")
@:structAccess
extern class NativeFlexLayout {
  @:native("NativeFlexLayout") public function new(isHorizontal:Bool, isReverse:Bool);
  public extern function layoutContainer(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;

  public extern function clearItems():Void;
  public extern function addItem(item:NativeFlexItem):Void;
}

class FlexLayout implements rehax.components.layout.Layout.ILayout {

  public static function Create(options:rehax.components.layout.FlexLayout.FlexLayoutOptions) {
		var layout = new FlexLayout(
      options.direction == Row || options.direction == RowReverse,
      options.direction == ColumnReverse || options.direction == RowReverse,
      options.items
    );
    return layout;
  }

  var items:Array<rehax.components.layout.FlexLayout.FlexItem> = [];

  public function new(isHorizontal:Bool, isReverse:Bool, items:Array<rehax.components.layout.FlexLayout.FlexItem>) {
    this.nativeLayout = new NativeFlexLayout(isHorizontal, isReverse);
    this.items = items;
  }

  private var nativeLayout:NativeFlexLayout;

  public function layout(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>) {
    nativeLayout.clearItems();
    for (item in items) {
      var n = new NativeFlexItem();
      n.hasFlexGrow = item.flexGrow != null;
      if (n.hasFlexGrow) {
        n.flexGrow = item.flexGrow;
      }
      nativeLayout.addItem(n);
    }
    nativeLayout.layoutContainer(container);
  }
}

#end
