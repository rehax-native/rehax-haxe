package rehax.components.layout.cpp;

#if cpp

@:include("rehax/components/layout/cpp/FlexLayout.h")
@:unreflective
@:native("NativeFlexLayout")
@:structAccess
extern class NativeFlexLayout {
  @:native("NativeFlexLayout") public function new(isHorizontal:Bool, isReverse:Bool);
  public extern function layoutContainer(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;
}

class FlexLayout implements rehax.components.layout.Layout.ILayout {

  public static function Create(options:rehax.components.layout.FlexLayout.FlexLayoutOptions) {
    var layout = new FlexLayout(false/* options.direction == Horizontal */, false /* is reverse */);
    return layout;
  }

  public function new(isHorizontal:Bool, isReverse:Bool) {
    this.nativeLayout = new NativeFlexLayout(isHorizontal, isReverse);
  }

  private var nativeLayout:NativeFlexLayout;

  public function layout(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>) {
    nativeLayout.layoutContainer(container);
  }
}

#end
