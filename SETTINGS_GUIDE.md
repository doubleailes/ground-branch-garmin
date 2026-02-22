# Ground Branch Watch - Settings Configuration Guide

This guide provides detailed instructions on how to configure and use the user settings for the Ground Branch Watch app.

## Overview

The Ground Branch Watch app allows you to customize three key settings:
- **Target Latitude**: The latitude coordinate of your target location
- **Target Longitude**: The longitude coordinate of your target location  
- **Proximity Radius**: The distance (in meters) at which the proximity alert triggers

These settings enable you to configure any target location worldwide and customize when alerts should trigger based on your operational needs.

## Accessing Settings

### Via Garmin Connect Mobile App

This is the primary and recommended method for configuring settings:

1. **Open Garmin Connect App**
   - Launch the Garmin Connect app on your smartphone
   - Ensure your Instinct 3 watch is paired and connected

2. **Navigate to the App**
   - Tap the menu icon (☰) or go to "More"
   - Select your Garmin Instinct 3 device
   - Tap "Connect IQ Apps" or "Apps"
   - Find and select "Ground Branch"

3. **Access Settings**
   - Tap the "Settings" button or gear icon
   - You'll see three configuration fields:
     - Target Latitude (°)
     - Target Longitude (°)
     - Proximity Radius (m)

4. **Configure Values**
   - Tap each field to edit
   - Enter your desired values (see detailed descriptions below)
   - Values are validated automatically by the app

5. **Save and Sync**
   - Changes are saved automatically
   - Settings sync to your watch within seconds
   - No watch restart required

### Via Garmin Connect Web

You can also configure settings through the Garmin Connect website:

1. Log in to [connect.garmin.com](https://connect.garmin.com)
2. Select your Instinct 3 device
3. Go to Connect IQ Apps → Ground Branch → Settings
4. Edit and save your settings

## Settings Details

### 1. Target Latitude (°)

**Description**: The north-south coordinate of your target location in decimal degrees.

**Valid Range**: -90° to +90°
- **-90°**: South Pole
- **0°**: Equator
- **+90°**: North Pole

**Default Value**: 48.8584 (Eiffel Tower, Paris, France)

**Format**: Decimal degrees (not degrees-minutes-seconds)

**Examples**:
- Los Angeles, CA: `34.0522`
- London, UK: `51.5074`
- Sydney, Australia: `-33.8688`
- Tokyo, Japan: `35.6762`

**How to Find Latitude**:
1. Open Google Maps on your device
2. Long-press on your target location
3. The coordinates appear at the top or bottom
4. First number is latitude (e.g., "34.0522, -118.2437" → latitude is 34.0522)

### 2. Target Longitude (°)

**Description**: The east-west coordinate of your target location in decimal degrees.

**Valid Range**: -180° to +180°
- **-180° to 0°**: Western Hemisphere
- **0° to +180°**: Eastern Hemisphere
- **0°**: Prime Meridian (Greenwich, UK)

**Default Value**: 2.2945 (Eiffel Tower, Paris, France)

**Format**: Decimal degrees (not degrees-minutes-seconds)

**Examples**:
- Los Angeles, CA: `-118.2437`
- London, UK: `-0.1278`
- Sydney, Australia: `151.2093`
- Tokyo, Japan: `139.6503`

**How to Find Longitude**:
1. Open Google Maps on your device
2. Long-press on your target location
3. The coordinates appear at the top or bottom
4. Second number is longitude (e.g., "34.0522, -118.2437" → longitude is -118.2437)

### 3. Proximity Radius (m)

**Description**: The distance in meters from the target location at which the proximity alert triggers.

**Valid Range**: 3m to 100m

**Default Value**: 10m

**Recommendations**:
- **3-5m**: Extremely precise targeting (indoor use, specific waypoints)
- **10-20m**: Standard operational range (default recommended)
- **30-50m**: Early warning for approaching objectives
- **75-100m**: Maximum early detection

**How the Alert Works**:
- Alert triggers when you enter the radius
- GPS accuracy must be ≤10m for reliable detection
- Vibration pattern: 5 pulses over ~10 seconds
- Visual alert displays "OBJECTIVE CLOSE" for 3 seconds
- 15-second cooldown between alerts to prevent spam

**Note**: GPS accuracy varies based on:
- Satellite visibility (open sky vs. urban/forest)
- Weather conditions
- Device positioning
- Environmental interference

## Viewing Current Settings on Watch

You can check your current settings directly on your watch:

1. **Open the App**
   - Launch the Ground Branch Watch app

2. **Access Menu**
   - Press the MENU button (usually upper-left button)

3. **Select Settings Info**
   - Use UP/DOWN to navigate
   - Select "Settings Info"

4. **View Display**
   - Shows current latitude and longitude
   - Shows current proximity radius
   - Reminds you to use Garmin Connect to change values

## Common Use Cases

### Scenario 1: Training Exercise Checkpoint
```
Target: Specific GPS waypoint at training facility
Latitude: 35.1234
Longitude: -120.5678
Radius: 5m (precise checkpoint)
```

### Scenario 2: Operational Rally Point
```
Target: Pre-designated meeting location
Latitude: 47.6062
Longitude: -122.3321
Radius: 25m (large area for team assembly)
```

### Scenario 3: Perimeter Monitoring
```
Target: Restricted zone boundary
Latitude: 38.8977
Longitude: -77.0365
Radius: 50m (early warning before entering zone)
```

## Settings Persistence

Your settings are stored securely and persist across:
- ✅ App restarts
- ✅ Watch face changes
- ✅ Watch reboots
- ✅ Software updates
- ✅ Device reconnections

Settings are stored in the Garmin Connect IQ properties system and synchronized between your watch and phone automatically.

## Troubleshooting

### Settings Not Syncing

**Problem**: Changes in Garmin Connect not appearing on watch

**Solutions**:
1. Ensure watch is connected to Garmin Connect app
2. Force sync: Open Garmin Connect → Device → Sync
3. Restart the Ground Branch app on watch
4. If still not working, restart your watch

### Invalid Value Error

**Problem**: Can't save a setting value

**Solutions**:
1. Check value is within valid range:
   - Latitude: -90 to +90
   - Longitude: -180 to +180
   - Radius: 3 to 100
2. Use decimal format (e.g., 34.0522, not 34° 3' 8")
3. Don't include units or symbols (just the number)

### Alert Not Triggering

**Problem**: No alert when near target location

**Solutions**:
1. Check GPS signal: Look for GPS icon on watch
2. Wait for GPS accuracy ≤10m (may take 1-2 minutes outdoors)
3. Verify you're within the configured radius
4. Check if cooldown is active (15 seconds between alerts)
5. Verify settings are loaded: Menu → Settings Info

### Alert Triggering When Not Near Target

**Problem**: False alerts far from target

**Solutions**:
1. Verify coordinates are correct (check decimal point position)
2. Verify hemisphere (negative for south/west)
3. Increase GPS accuracy requirement (requires code change)
4. Check you didn't swap latitude and longitude

## Advanced Tips

### Finding Coordinates from Address

1. **Google Maps**:
   - Search for address
   - Right-click on map → "What's here?"
   - Coordinates displayed at bottom

2. **Apple Maps**:
   - Search for address
   - Tap and hold location
   - Swipe up on info card to see coordinates

3. **GPS Coordinate Converter Tools**:
   - Many online tools convert addresses to coordinates
   - Always use decimal degrees format

### Coordinate Format Conversion

If you have coordinates in degrees-minutes-seconds (DMS):

**DMS Format**: 34° 3' 8" N
**Decimal Format**: 34.0522

**Conversion Formula**:
```
Decimal = Degrees + (Minutes / 60) + (Seconds / 3600)
```

**Example**: 
- DMS: 34° 3' 8" N
- Calculation: 34 + (3/60) + (8/3600) = 34.0522
- Result: 34.0522

**Direction Indicators**:
- N (North) = positive latitude
- S (South) = negative latitude
- E (East) = positive longitude
- W (West) = negative longitude

### Testing Your Configuration

Before field use, test your settings:

1. Set a nearby, easily accessible location
2. Configure coordinates using Google Maps
3. Set radius to 10-15m for testing
4. Walk to location and verify alert triggers
5. Note GPS accuracy and alert timing
6. Adjust radius if needed for your use case

## Privacy and Security

- Settings are stored locally on your watch and in your Garmin account
- No coordinates or location data is transmitted to third parties
- The app only monitors your position for proximity calculations
- No location history is recorded or transmitted
- GPS data stays on your device

## Support

For issues or questions:
- Check the main [README.md](README.md) for general information
- Review Garmin Connect IQ app documentation
- Ensure you're using the latest version of the app

## Version History

- **v0.0.2**: Settings system implementation with validation and persistence
- **v0.0.1**: Initial release with compass and proximity alert
