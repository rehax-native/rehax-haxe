package rehax.components.root.cpp;

#if cpp
using rehax.components.view.cpp.View;

import cpp.Pointer;
import cpp.RawPointer;
import cpp.ConstPointer;

@:include("rehax/components/root/cpp/NativeRoot.h")
@:unreflective
@:native("NativeRoot")
extern class NativeRoot extends NativeView {
  @:native("new NativeRoot") private static function _new():RawPointer<NativeRoot>;
  public static inline function createInstance():Pointer<NativeRoot> {
    return Pointer.fromRaw(_new());
  }
  function createFragment():Void;
  function mount(parent:View):Void;
  function initialize(onReady:Void->Void):Void;
}

@:build(rehax.cpp.InjectBuild.config())
class Root extends View {
  var root:Pointer<NativeRoot>;

  public static function CreateWithExistingPlatformView(platformView:RawPointer<Void>):Root {
    var root = new Root();
    root.native.ptr.setNativeViewRaw(platformView);
    return root;
  }

  public function new() {
    super();
    this.root = NativeRoot.createInstance();
    native = this.root.reinterpret();
  }

  public function initialize(onReady:Void->Void) {
    root.ptr.initialize(onReady);
  }
}
#end
