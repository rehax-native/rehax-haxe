package rehax.components.textInput;

#if js
typedef TextInput = rehax.components.textInput.web.TextInput.TextInput;
#elseif fluxe
typedef TextInput = rehax.components.textInput.fluxe.TextInput.TextInput;
#elseif cpp
typedef TextInput = rehax.components.textInput.cpp.TextInput.TextInput;
#end