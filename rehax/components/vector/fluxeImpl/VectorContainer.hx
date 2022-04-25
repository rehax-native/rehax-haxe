package rehax.components.vector.fluxeImpl;

using rehax.components.view.View;

#if fluxe

using rehax.components.vector.fluxeImpl.Common;
using fluxe.views.ViewBuilder;
using fluxe.views.Externs;

class FluxeVector extends fluxe.views.View {

  public function new() {
    super();
  }

  public var width:Float = 0.0;
  public var height:Float = 0.0;
  public var container:VectorContainer;

  public override function measureLayout(constraints:fluxe.layout.LayoutConstraint, parentSize:fluxe.layout.LayoutTypes.PossibleLayoutSize) {
    this.layoutSize = {
      width: width,
      height: height,
    };
  }

  public override function build(builder:ViewBuilder) {
    container.draw(builder);
  }
}

class VectorContainer extends View {
  public function new() {
    super();
  }

  private var vector:FluxeVector;

  public override function createFragment() {
    vector = new FluxeVector();
    vector.container = this;
    view = vector;
  }

  public var linearGradients:Array<VectorLinearGradient> = [];
  public var radialGradients:Array<VectorRadialGradient> = [];

  public function addLinearGradientDefinition(definition:VectorLinearGradient) {
    linearGradients.push(definition);
  }

  public function addRadialGradientDefinition(definition:VectorRadialGradient) {
    radialGradients.push(definition);
  }

  public function draw(builder:ViewBuilder) {
    for (view in children) {
      var el = cast(view, VectorElement);
      el.draw(builder);
    }
  }

  public var width(get, set):Float;

  public function set_width(width:Float):Float {
    vector.width = width;
    return width;
  }

  public function get_width():Float {
    return vector.width;
  }

  public var height(default, set):Float;

  public function set_height(height:Float):Float {
    vector.height = height;
    return height;
  }

  public function get_height():Float {
    return vector.height;
  }
}
#end
