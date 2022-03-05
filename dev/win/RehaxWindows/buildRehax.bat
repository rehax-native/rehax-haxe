echo "Building Rehax"
cd ..\..\..
echo "Current dir %cd%"
haxe -lib hxcpp -p rehax -p dev dev.App -cpp dev/win/lib --debug --macro "rehax.cpp.InjectBuild.config()" -D static_link -D REHAX_INCLUDE="%cd%" -D include_prefix="rhx" -D HXCPP_VERBOSE -D winrt -D dll_export -D HXCPP_M64