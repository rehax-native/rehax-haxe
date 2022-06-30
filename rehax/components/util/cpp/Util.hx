package rehax.components.util.cpp;

@:include("rehax/components/util/cpp/NativeUtil.h")
@:unreflective
@:native("NativeTimer")
@:structAccess
extern class NativeTimer {
}

@:include("rehax/components/util/cpp/NativeUtil.h")
@:unreflective
@:native("NativeUtil")
@:structAccess
extern class NativeUtil {
  static function openUrl(url:cpp.ConstCharStar):Void;

  static function startInterval(intervalMs:Int, tick:() -> Void):cpp.Pointer<NativeTimer>;
  static function stopTimer(timer:cpp.Pointer<NativeTimer>):Void;
}

typedef Timer = cpp.Pointer<NativeTimer>;

class Util {
    public static function openUrl(url:String):Void {
        NativeUtil.openUrl(url);
    }

    public static function createInterval(intervalMs:Int, tick:() -> Void):Timer {
      var timer:Timer = NativeUtil.startInterval(intervalMs, tick);
      return timer;
    }

    public static function stopInterval(timer:Timer) {
      NativeUtil.stopTimer(timer);
    }
}
