package rehax.components.root;

#if js
typedef Root = rehax.components.root.web.Root.Root;
#elseif fluxe
typedef Root = rehax.components.root.fluxe.Root.Root;
#elseif cpp
typedef Root = rehax.components.root.cpp.Root.Root;
#end