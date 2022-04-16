package rehax.components.layout;

typedef FlexItem = {
  ?order:Int,
  ?flexGrow:Float,
}

enum FlexDirection {
  Column;
  Row;
  ColumnReverse;
  RowReverse;
}

typedef FlexLayoutOptions = {
  ?direction: FlexDirection,
	?items:Array<FlexItem>,
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef FlexLayout = rehax.components.layout.fluxe.FlexLayout.FlexLayout;
#elseif cpp
typedef FlexLayout = rehax.components.layout.cpp.FlexLayout.FlexLayout;
#end
