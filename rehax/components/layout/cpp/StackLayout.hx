package rehax.components.layout.cpp;

#if cpp

@:include("rehax/components/layout/cpp/StackLayout.h")
@:unreflective
@:native("NativeStackLayout")
@:structAccess
extern class NativeStackLayout {
  @:native("NativeStackLayout") public function new(isHorizontal:Bool, spacing:Float) {}
  public extern function layoutContainer(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;
}

class StackLayout implements rehax.components.layout.Layout.ILayout {

  public static function Create(options:rehax.components.layout.StackLayout.StackLayoutOptions) {
    var layout = new StackLayout(options.direction == Horizontal, options.spacing != null ? options.spacing : 0.0);
    return layout;
  }

  public function new(isHorizontal:Bool, spacing:Float) {
    this.nativeLayout = new NativeStackLayout(isHorizontal, spacing);
  }

  private var nativeLayout:NativeStackLayout;

  public function layout(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>) {
    nativeLayout.layoutContainer(container);
  }
}

#end
