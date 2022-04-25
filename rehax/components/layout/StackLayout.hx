package rehax.components.layout;

enum StackLayoutDirection {
  Vertical;
  Horizontal;
}

typedef StackLayoutOptions = {
  ?direction:StackLayoutDirection,
  ?spacing:Float
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef StackLayout = rehax.components.layout.fluxe.StackLayout.StackLayout;
#elseif cpp
typedef StackLayout = rehax.components.layout.cpp.StackLayout.StackLayout;
#end
