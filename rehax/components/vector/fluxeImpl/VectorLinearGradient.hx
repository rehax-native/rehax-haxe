package rehax.components.vector.fluxeImpl;

#if fluxe
using rehax.components.view.View;
using rehax.components.vector.Common;
using rehax.Style;

using rehax.components.vector.fluxeImpl.Common;
using fluxe.views.ViewBuilder;

class VectorLinearGradient extends VectorElement {
  public function new() {
    super();
  }

  public override function createFragment() {
  }

  public override function mount(parent:View, atIndex:Null<Int> = null) {
    this.parent = parent;
    var container = cast(parent, VectorContainer);
    container.addLinearGradientDefinition(this);
  }

  public var id:String;

  public var stops:Array<{
    var offset:Float;
    var color:Color;
  }>;
}
#end
