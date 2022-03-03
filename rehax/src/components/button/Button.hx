package rehax.components.button;

#if js
typedef Button = rehax.components.button.web.Button.Button;
#elseif cpp
typedef Button = rehax.components.button.cpp.Button.Button;
#end