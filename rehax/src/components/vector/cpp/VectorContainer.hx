package rehax.components.vector.cpp;

#if cpp
using rehax.components.view.Layout;
using rehax.components.view.cpp.View;
using rehax.components.vector.cpp.Common;

import cpp.Pointer;
import cpp.RawPointer;

class VectorContainer extends View {
  public function new() {
    super();
  }

  public override function createFragment() {
    var container = NativeVectorContainer.createInstance();
    native = container.reinterpret();
    container.ptr.createFragment();
    container.ptr.setDrawCallback(() -> draw());
  }

  var elements:Array<VectorElement> = [];

  public override function addChild(child:View, atIndex:Int) {
    super.addChild(child, atIndex);
    elements.push(cast(child, VectorElement));
  }

  private function draw() {
    var container:Pointer<NativeVectorContainer> = native.reinterpret();
    for (el in elements) {
      el.drawOp(container, width, height);
    }
  }

  public var width:Float;
  public var height:Float;
}
#end
