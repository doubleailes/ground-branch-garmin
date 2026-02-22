import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

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
            // Show settings info dialog - load and format current settings
            var latitude = Constants.getPropertyOrDefault("target_latitude", Constants.DEFAULT_TARGET_LAT);
            var longitude = Constants.getPropertyOrDefault("target_longitude", Constants.DEFAULT_TARGET_LON);
            var radius = Constants.getPropertyOrDefault("radius", Constants.DEFAULT_PROXIMITY_RADIUS);
            
            // Format values for display
            var latitudeString = latitude.format("%.4f");
            var longitudeString = longitude.format("%.4f");
            var radiusString = radius.format("%.0f");
            
            // Build message with current settings
            var message = Lang.format(
                "Lat: $1$°\nLon: $2$°\nRadius: $3$m\n\nChange in\nGarmin Connect",
                [latitudeString, longitudeString, radiusString]
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