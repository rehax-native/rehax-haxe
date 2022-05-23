package rehax.components.vector.web;

#if js
using rehax.components.view.View;
using rehax.components.vector.Common;

class VectorElement extends View {
  public function new() {
    super();
  }

  public var vectorStyle(default, set):Array<VectorStyleProperty>;

  public function set_vectorStyle(styles:Array<VectorStyleProperty>):Array<VectorStyleProperty> {
    this.vectorStyle = styles;
    var el = cast(element, js.html.svg.GraphicsElement);
    for (style in styles) {
      switch (style) {
        case Fill(color):
          el.setAttribute('fill', 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})');
        case Stroke(color):
          el.setAttribute('stroke', 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})');
        case StrokeWidth(width):
          el.setAttribute('stroke-width', Std.string(width));
        case StrokeLineCap(cap):
          switch (cap) {
            case Butt:
              el.setAttribute('stroke-linecap', 'butt');
            case Square:
              el.setAttribute('stroke-linecap', 'square');
            case Round:
              el.setAttribute('stroke-linecap', 'round');
          }
        case StrokeLineJoin(join):
          switch (join) {
            case Miter:
              el.setAttribute('stroke-linejoin', 'miter');
            case Round:
              el.setAttribute('stroke-linejoin', 'round');
            case Bevel:
              el.setAttribute('stroke-linejoin', 'bevel');
          }
        case FillWithDefinition(name):
          el.setAttribute('fill', 'url(\'#$name\')');
        case StrokeWithDefinition(name):
          el.setAttribute('stroke', 'url(\'#$name\')');
        case Filters(filters):
          // var imageFilter = ImageFilter.Create();
          // for (filter in filters) {
          //   switch (filter) {
          //     case Blur(radius):
          //       imageFilter = ImageFilters.Blur(radius, radius, imageFilter);
          //   }
          // }
          // paintPair.stroke.setImageFilter(imageFilter);
          // paintPair.fill.setImageFilter(imageFilter);
      }
    }
    return styles;
  }
}
#end
