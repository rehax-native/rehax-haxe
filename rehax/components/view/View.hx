package rehax.components.view;

#if js
typedef View = rehax.components.view.web.View.View;
typedef Gesture = rehax.components.view.web.Gesture.Gesture;
#elseif fluxe
typedef View = rehax.components.view.fluxe.View.View;
typedef Gesture = rehax.components.view.fluxe.Gesture.Gesture;
#elseif cpp
typedef View = rehax.components.view.cpp.View.View;
typedef Gesture = rehax.components.view.cpp.Gesture.Gesture;
#end