package rehax.components.util.cpp;

@:include("rehax/components/util/cpp/NativeUtil.h")
@:unreflective
@:native("NativeUtil")
@:structAccess
extern class NativeUtil {
  static function openUrl(url:cpp.ConstCharStar):Void;
}

class Util {
    public static function openUrl(url:String):Void {
        NativeUtil.openUrl(url);
    }
}
