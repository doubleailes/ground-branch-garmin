import Toybox.Lang;
import Toybox.WatchUi;

class groundbranchappDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new groundbranchappMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}