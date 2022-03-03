package rehax.components.text;

#if js
typedef Text = rehax.components.text.web.Text.Text;
#elseif cpp
typedef Text = rehax.components.text.cpp.Text.Text;
#end