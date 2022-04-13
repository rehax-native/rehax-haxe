package rehax.components.layout;

typedef FlexItem = {
  ?order:Int,
  ?flexGrow:Float,
}

typedef FlexLayoutOptions = {
	?items:Array<FlexItem>,
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef FlexLayout = rehax.components.layout.fluxe.FlexLayout.FlexLayout;
#elseif cpp
typedef FlexLayout = rehax.components.layout.cpp.FlexLayout.FlexLayout;
#end
