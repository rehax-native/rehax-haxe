package rehax.components.view;

enum SizeDimension {
  /** Natural, meaning the same size as its' content **/
  Natural;

  /** Fixed size in screen independent pixels **/
  Fixed(size:Float);

  /** Fill the parent **/
  Fill;

  /** Flex box grow value **/
  Flex(flex:Float);

  /** Percentage of parent **/
  Percentage(percent:Float);
}

enum PositionDimension {
  /** Natural, meaning the position it's assigned by the parent **/
  Natural;

  /** Fixed positin in screen independent pixels **/
  Fixed(size:Float);
}

typedef Size = {
  var width:SizeDimension;
  var height:SizeDimension;
}

typedef Position = {
  var left:PositionDimension;
  var top:PositionDimension;
}

typedef Frame = {
  var position:Position;
  var size:Size;
}

enum LayoutDirection {
  Vertical;
  Horizontal;
}

enum AlignmentMainAxis {
  Start;
  End;
  Center;
  SpaceBetween;
  SpaceAround;
  SpaceEvenly;
}

enum AlignmentCrossAxis {
  Start;
  End;
  Center;
  Stretch;
}
