import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class groundbranchappApp extends Application.AppBase {

    // Default values for settings
    const DEFAULT_TARGET_LAT = 58.895626;
    const DEFAULT_TARGET_LON = 10.8323056;
    const DEFAULT_RADIUS_M = 10.0;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        // Save properties when exiting
        saveProperties();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new groundbranchappView(), new groundbranchappDelegate() ];
    }

    // Get target latitude from properties
    function getTargetLatitude() as Float {
        var value = getProperty("targetLatitude");
        if (value != null) {
            return value as Float;
        }
        return DEFAULT_TARGET_LAT;
    }

    // Set target latitude
    function setTargetLatitude(lat as Float) as Void {
        // Clamp latitude to valid range (-90 to 90)
        if (lat < -90.0) { lat = -90.0; }
        if (lat > 90.0) { lat = 90.0; }
        setProperty("targetLatitude", lat);
        saveProperties();
    }

    // Get target longitude from properties
    function getTargetLongitude() as Float {
        var value = getProperty("targetLongitude");
        if (value != null) {
            return value as Float;
        }
        return DEFAULT_TARGET_LON;
    }

    // Set target longitude
    function setTargetLongitude(lon as Float) as Void {
        // Clamp longitude to valid range (-180 to 180)
        if (lon < -180.0) { lon = -180.0; }
        if (lon > 180.0) { lon = 180.0; }
        setProperty("targetLongitude", lon);
        saveProperties();
    }

    // Get proximity radius from properties
    function getProximityRadius() as Float {
        var value = getProperty("proximityRadius");
        if (value != null) {
            return value as Float;
        }
        return DEFAULT_RADIUS_M;
    }

    // Set proximity radius
    function setProximityRadius(radius as Float) as Void {
        // Ensure radius is positive and reasonable
        if (radius < 1.0) { radius = 1.0; }
        if (radius > 1000.0) { radius = 1000.0; }
        setProperty("proximityRadius", radius);
        saveProperties();
    }

}

function getApp() as groundbranchappApp {
    return Application.getApp() as groundbranchappApp;
}