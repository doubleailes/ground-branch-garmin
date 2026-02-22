import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application.Properties;

class groundbranchappMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            // Show about dialog
            var dialog = new WatchUi.Confirmation(Rez.Strings.about_text);
            WatchUi.pushView(dialog, new AboutConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :item_2) {
            // Show settings info dialog
            var lat = Properties.getValue("target_latitude");
            var lon = Properties.getValue("target_longitude");
            var radius = Properties.getValue("radius");
            
            // Fallback to defaults if null
            if (lat == null) { lat = 48.8584; }
            if (lon == null) { lon = 2.2945; }
            if (radius == null) { radius = 10.0; }
            
            // Format settings values for display
            var latStr = lat.format("%.4f");
            var lonStr = lon.format("%.4f");
            var radiusStr = radius.format("%.0f");
            
            // Build message with current settings
            var message = Lang.format(
                "Lat: $1$°\nLon: $2$°\nRadius: $3$m\n\nChange in\nGarmin Connect",
                [latStr, lonStr, radiusStr]
            );
            
            var dialog = new WatchUi.Confirmation(message);
            WatchUi.pushView(dialog, new SettingsConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }

}

class AboutConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response as WatchUi.Confirm) as Boolean {
        return true;
    }
}

class SettingsConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response as WatchUi.Confirm) as Boolean {
        return true;
    }
}