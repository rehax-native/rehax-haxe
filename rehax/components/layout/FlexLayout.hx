package rehax.components.layout;

enum FlexDirection {
  Column;
  Row;
  ColumnReverse;
  RowReverse;
}

enum abstract FlexJustifyContent(Int) to Int {
  /** items are packed toward the start line
      |AABBCCC    |
  **/
  var FlexStart;

  /** items are packed toward to end line
      |    AABBCCC|
  **/
  var FlexEnd;

  /** items are centered along the line
      |  AABBCCC  |
  **/
  var Center;


  // Not implemented yet

  // /** items are evenly distributed in the line; first item is on the start line, last item on the end line  
  //     |AA  BB  CCC|
  // **/
  // var SpaceBetween;

  // /** items are evenly distributed in the line with equal space around them
  //     | AA BB CCC |
  // **/
  // var SpaceAround;

  // /** items are distributed so that the spacing between any two adjacent alignment subjects, before the first alignment subject, and after the last alignment subject is the same
  // **/
  // var SpaceEvenly;
}

enum abstract FlexAlignItems(Int) to Int {
  var FlexStart; // cross-start margin edge of the items is placed on the cross-start line
  var FlexEnd; // cross-end margin edge of the items is placed on the cross-end line
  var Center; // items are centered in the cross-axis
  // var Baseline; // items are aligned such as their baselines align
  var Stretch; // stretch to fill the container (still respect min-width/max-width)
}

typedef FlexItem = {
  ?order:Int,
  ?flexGrow:Float,
  ?alignSelf:FlexAlignItems,
}

typedef FlexLayoutOptions = {
  ?direction:FlexDirection,
	?items:Array<FlexItem>,
  ?justifyContent:FlexJustifyContent,
  ?alignItems:FlexAlignItems,
}

#if js
typedef FlexLayout = rehax.components.layout.web.FlexLayout.FlexLayout;
#elseif fluxe
typedef FlexLayout = rehax.components.layout.fluxe.FlexLayout.FlexLayout;
#elseif cpp
typedef FlexLayout = rehax.components.layout.cpp.FlexLayout.FlexLayout;
#end
