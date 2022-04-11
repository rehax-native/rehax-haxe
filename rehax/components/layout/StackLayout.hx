package rehax.components.layout;

typedef StackLayoutOptions = {
	?direction:rehax.components.layout.Layout.LayoutDirection,
	?spacing:Float
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef StackLayout = rehax.components.layout.fluxe.StackLayout.StackLayout;
#elseif cpp
typedef StackLayout = rehax.components.layout.cpp.StackLayout.StackLayout;
#end
