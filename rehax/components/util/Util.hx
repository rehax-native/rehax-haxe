package rehax.components.util;

#if js
typedef Util = rehax.components.util.web.Util.Util;
typedef Timer = rehax.components.util.web.Util.Timer;
#elseif fluxe
typedef Util = rehax.components.util.fluxe.Util.Util;
typedef Timer = rehax.components.util.fluxe.Util.Timer;
#elseif cpp
typedef Util = rehax.components.util.cpp.Util.Util;
typedef Timer = rehax.components.util.cpp.Util.Timer;
#end