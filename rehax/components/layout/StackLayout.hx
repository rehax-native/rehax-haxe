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
typedef StackLayout = rehax.components.layout.web.StackLayout.StackLayout;
#elseif fluxe
typedef StackLayout = rehax.components.layout.fluxe.StackLayout.StackLayout;
#elseif cpp
typedef StackLayout = rehax.components.layout.cpp.StackLayout.StackLayout;
#end
