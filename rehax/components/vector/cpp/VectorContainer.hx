package rehax.components.vector.cpp;

#if cpp
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
  }

  public var linearGradients:Array<VectorLinearGradient> = [];
  public var radialGradients:Array<VectorRadialGradient> = [];

  public function addLinearGradientDefinition(definition:VectorLinearGradient) {
    linearGradients.push(definition);
  }

  public function addRadialGradientDefinition(definition:VectorRadialGradient) {
    radialGradients.push(definition);
  }

  public var width:Float;
  public var height:Float;
}
#end
