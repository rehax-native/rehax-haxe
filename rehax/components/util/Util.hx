package rehax.components.util;

#if js
typedef Util = rehax.components.util.web.Util.Util;
typedef Timer = rehax.components.util.web.Util.Timer;
#elseif cpp
typedef Util = rehax.components.util.cpp.Util.Util;
typedef Timer = rehax.components.util.cpp.Util.Timer;
#end