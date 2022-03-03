package rehax.components.vector;

using rehax.Style;

enum StrokeLineCap {
  Butt;
  Square;
  Round;
}

enum StrokeLineJoin {
  Miter;
  Round;
  Bevel;
}

enum VectorStyleProperty {
  Fill(color:Color);
  Stroke(color:Color);
  StrokeWidth(width:Float);
  StrokeLineCap(cap:StrokeLineCap);
  StrokeLineJoin(join:StrokeLineJoin);
}
