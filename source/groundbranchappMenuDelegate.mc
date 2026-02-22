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
            WatchUi.pushView(dialog, new GenericConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :item_2) {
            // Show settings info dialog
            var lat = Properties.getValue("target_latitude");
            var lon = Properties.getValue("target_longitude");
            var radius = Properties.getValue("radius");
            
            // Fallback to defaults if null
            if (lat == null) { lat = Constants.DEFAULT_TARGET_LAT; }
            if (lon == null) { lon = Constants.DEFAULT_TARGET_LON; }
            if (radius == null) { radius = Constants.DEFAULT_PROXIMITY_RADIUS; }
            
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
            WatchUi.pushView(dialog, new GenericConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }

}

// Generic confirmation delegate for simple OK/Cancel dialogs
class GenericConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response as WatchUi.Confirm) as Boolean {
        return true;
    }
}