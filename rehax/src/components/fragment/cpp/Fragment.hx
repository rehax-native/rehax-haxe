package rehax.components.fragment.cpp;

using rehax.components.view.cpp.View;

#if cpp
@:include("../../../../../rehax/backend/cpp/NativeFragment.h")
@:unreflective
@:native("NativeFragment")
@:structAccess
extern class NativeFragment extends NativeView {
  function new();
}

class Fragment extends View {
  public function new() {
    super();
  }
}
#end
