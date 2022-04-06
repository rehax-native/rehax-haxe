package rehax.components.text;

#if js
typedef Text = rehax.components.text.web.Text.Text;
#elseif fluxe
typedef Text = rehax.components.text.fluxe.Text.Text;
#elseif cpp
typedef Text = rehax.components.text.cpp.Text.Text;
#end