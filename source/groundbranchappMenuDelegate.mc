import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class groundbranchappMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :settings) {
            var settingsView = new SettingsView();
            var settingsDelegate = new SettingsDelegate(settingsView);
            WatchUi.pushView(settingsView, settingsDelegate, WatchUi.SLIDE_LEFT);
        } else if (item == :item_1) {
            System.println("item 1");
        } else if (item == :item_2) {
            System.println("item 2");
        }
    }

}