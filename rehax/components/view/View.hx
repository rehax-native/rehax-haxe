package rehax.components.view;

#if js
typedef View = rehax.components.view.web.View.View;
#elseif fluxe
typedef View = rehax.components.view.fluxe.View.View;
#elseif cpp
typedef View = rehax.components.view.cpp.View.View;
#end