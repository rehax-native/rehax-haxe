package rehax.components.fragment;

#if js
typedef Fragment = rehax.components.fragment.web.Fragment.Fragment;
#elseif cpp
typedef Fragment = rehax.components.fragment.cpp.Fragment.Fragment;
#end