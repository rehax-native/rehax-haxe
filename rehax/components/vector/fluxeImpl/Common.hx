package rehax.components.vector.fluxeImpl;

using rehax.components.view.View;
using rehax.components.vector.Common;

#if fluxe

using fluxe.views.Externs;
using fluxe.views.ViewBuilder;

class PaintPair {
  public function new() {
    fill.setStyle(PaintStyle.Fill);
    fill.setAntiAlias(true);
    stroke.setStyle(PaintStyle.Stroke);
    stroke.setAntiAlias(true);
  }
  public var fill = new Paint();
  public var stroke = new Paint();
  public var hasFill = false;
  public var hasStroke = false;
}

class VectorElement extends View {
  public function new() {
    super();
  }

  public var vectorStyle:Array<VectorStyleProperty> = [];

  public function draw(builder:ViewBuilder) {}

  private function makePaints():PaintPair {
    var paintPair = new PaintPair();

    for (style in vectorStyle) {
      switch (style) {
        case Fill(color):
          paintPair.fill.setColor(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
          paintPair.hasFill = true;
        case Stroke(color):
          paintPair.stroke.setColor(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
          paintPair.hasStroke = true;
        case StrokeWidth(width):
          paintPair.stroke.setStrokeWidth(width);
        case StrokeLineCap(cap):
    //       switch (cap) {
    //         case Butt:
    //           el.ptr.setLineCap(0);
    //         case Square:
    //           el.ptr.setLineCap(1);
    //         case Round:
    //           el.ptr.setLineCap(2);
    //       }
        case StrokeLineJoin(join):
    //       switch (join) {
    //         case Miter:
    //           el.ptr.setLineJoin(0);
    //         case Round:
    //           el.ptr.setLineJoin(1);
    //         case Bevel:
    //           el.ptr.setLineJoin(2);
    //       }
        case FillWithDefinition(name):
          var container = cast(parent, VectorContainer);
          if (container == null) {
            continue;
          }
          for (gradient in container.linearGradients) {
            if (gradient.id == name) {
              var colors:Array<Color> = [];
              var positions:Array<cpp.Float32> = [];
              for (stop in gradient.stops) {
                var color = stop.color;
                colors.push(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
                positions.push(stop.offset);
              }
              var gradient = GradientShader.MakeLinear({
                  point0: NativePoint.Make(0, 0),
                  point1: NativePoint.Make(100, 100), // TODO
                  colors: colors,
                  positions: positions,
                  // mode: ShaderTileMode.kClamp,
              });
              paintPair.fill.setShader(gradient);
              paintPair.hasFill = true;
              break;
            }
          }
          for (gradient in container.radialGradients) {
            if (gradient.id == name) {
              var colors:Array<Color> = [];
              var positions:Array<cpp.Float32> = [];
              for (stop in gradient.stops) {
                var color = stop.color;
                colors.push(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
                positions.push(stop.offset);
              }
              var gradient = GradientShader.MakeRadial({
                  center: NativePoint.Make(50, 50), // TODO
                  radius: 50, // TODO
                  colors: colors,
                  positions: positions,
                  // mode: ShaderTileMode.kClamp,
              });
              paintPair.fill.setShader(gradient);
              paintPair.hasFill = true;
              break;
            }
          }
        case StrokeWithDefinition(name):
          var container = cast(parent, VectorContainer);
          if (container == null) {
            continue;
          }
          for (gradient in container.linearGradients) {
            if (gradient.id == name) {
              var colors:Array<Color> = [];
              var positions:Array<cpp.Float32> = [];
              for (stop in gradient.stops) {
                var color = stop.color;
                colors.push(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
                positions.push(stop.offset);
              }
              var gradient = GradientShader.MakeLinear({
                  point0: NativePoint.Make(0, 0),
                  point1: NativePoint.Make(100, 100), // TODO
                  colors: colors,
                  positions: positions,
                  // mode: ShaderTileMode.kClamp,
              });
              paintPair.stroke.setShader(gradient);
              paintPair.hasStroke = true;
              break;
            }
          }
          for (gradient in container.radialGradients) {
            if (gradient.id == name) {
              var colors:Array<Color> = [];
              var positions:Array<cpp.Float32> = [];
              for (stop in gradient.stops) {
                var color = stop.color;
                colors.push(Color.RGBA(color.red / 255.0, color.green / 255.0, color.blue / 255.0, color.alpha));
                positions.push(stop.offset);
              }
              var gradient = GradientShader.MakeRadial({
                  center: NativePoint.Make(50, 50), // TODO
                  radius: 50, // TODO
                  colors: colors,
                  positions: positions,
                  // mode: ShaderTileMode.kClamp,
              });
              paintPair.stroke.setShader(gradient);
              paintPair.hasStroke = true;
              break;
            }
          }
      }
    }
    return paintPair;
  }
}

#end
