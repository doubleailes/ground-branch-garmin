import Toybox.Lang;
import Toybox.Application.Properties;

// Application-wide constants
module Constants {
    // Default target location: Eiffel Tower, Paris, France
    const DEFAULT_TARGET_LAT = 48.8584;
    const DEFAULT_TARGET_LON = 2.2945;
    const DEFAULT_PROXIMITY_RADIUS = 10.0;  // in meters
    
    // Load property value with fallback to default
    function getPropertyOrDefault(key as String, defaultValue as Float) as Float {
        var value = Properties.getValue(key);
        return (value != null) ? value : defaultValue;
    }
}
