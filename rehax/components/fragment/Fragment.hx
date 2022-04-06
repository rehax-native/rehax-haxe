package rehax.components.fragment;

#if js
typedef Fragment = rehax.components.fragment.web.Fragment.Fragment;
#elseif fluxe
typedef Fragment = rehax.components.fragment.fluxe.Fragment.Fragment;
#elseif cpp
typedef Fragment = rehax.components.fragment.cpp.Fragment.Fragment;
#end