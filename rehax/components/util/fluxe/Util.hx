package rehax.components.util.fluxe;

typedef Timer = fluxe.animation.Timer;

class Util {
    public static function openUrl(url:String):Void {
        // NativeUtil.openUrl(url);
    }

    public static function createInterval(intervalMs:Int, tick:() -> Void):Timer {
      var timer:Timer = fluxe.animation.Timer.startInterval(intervalMs, tick);
      return timer;
    }

    public static function stopInterval(timer:Timer) {
      fluxe.animation.Timer.stopTimer(timer);
    }
}
