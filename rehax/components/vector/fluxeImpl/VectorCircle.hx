package rehax.components.vector.fluxeImpl;

#if fluxe

using rehax.components.vector.fluxeImpl.Common;
using fluxe.views.ViewBuilder;

class VectorCircle extends VectorElement {
  public function new() {
    super();
  }

  public override function draw(builder:ViewBuilder) {
    var paints = makePaints();
    if (paints.hasFill) {
      builder.canvas.drawCircle(centerX, centerY, radius, paints.fill);
    }
    if (paints.hasStroke) {
      builder.canvas.drawCircle(centerX, centerY, radius, paints.stroke);
    }
  }

  public var centerX:Float;
  public var centerY:Float;
  public var radius:Float;
}
#end
