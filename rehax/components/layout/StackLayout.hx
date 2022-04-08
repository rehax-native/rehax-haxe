package rehax.components.layout;

typedef StackLayoutOptions = {
	?direction:LayoutDirection
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef StackLayout = rehax.components.layout.fluxe.StackLayout.StackLayout;
#elseif cpp
// typedef View = rehax.components.view.cpp.View.View;
#end
