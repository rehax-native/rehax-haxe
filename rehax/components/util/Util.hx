package rehax.components.util;

#if js
typedef Util = rehax.components.util.web.Util.Util;
#elseif cpp
typedef Util = rehax.components.util.cpp.Util.Util;
#end