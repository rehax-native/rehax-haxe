package rehax.components.util.web;

class Util {
    public static function openUrl(url:String):Void {
      js.Browser.window.open(url, '_blank').focus();
    }
}
