package rehax.components.util.web;

typedef Timer = haxe.Timer;

class Util {
    public static function openUrl(url:String):Void {
      js.Browser.window.open(url, '_blank').focus();
    }

    public static function createInterval(intervalMs:Int, tick:() -> Void):Timer {
      var timer = new haxe.Timer(intervalMs);
      timer.run = tick;
      return timer;
    }

    public static function stopInterval(timer:Timer) {
      timer.stop();
    }
}
