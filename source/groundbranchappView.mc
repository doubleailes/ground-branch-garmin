import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Activity;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Position;     // <— GPS
import Toybox.Attention;   // <— vibration

class groundbranchappView extends WatchUi.View {

    const COLOR_BG    = Graphics.COLOR_BLACK;
    const COLOR_TEXT  = Graphics.COLOR_WHITE;
    const COLOR_NORTH = Graphics.COLOR_RED;
    const COLOR_ALERT_BG = Graphics.createColor(255, 56, 0, 0);

    var _cx, _cy, _radius;
    var _lastHeadingDeg = 0.0;
    var _timer;

    // Proximity state (ADD THESE)
    var _alertActive = false;
    var _cooldown    = false;
    var _alertOffTimer;
    var _cooldownTimer;
    var lat, lon;

    // Target (your coords)
    const TARGET_LAT = 58.895626;
    const TARGET_LON = 10.8323056;
    const RADIUS_M   = 10.0;  // ton seuil
    const ACC_MAX_M  = 10.0;  // filtre précision GPS

    //global variables
    var lastLocation = null;
    var locationAcquired = false;
    var gpsQuality = null;
    var isTS = false;

    function initialize() {
        System.println("Initializing groundbranchappView");
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        System.println("Layouting groundbranchappView");
        _cx = dc.getWidth()  / 2.0;
        _cy = dc.getHeight() / 2.0;
        // slightly larger for AMOLED 50mm
        _radius = (dc.getWidth() < dc.getHeight() ? dc.getWidth() : dc.getHeight()) * 0.40;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("Showing groundbranchappView");
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
        _timer = new Timer.Timer();
        _timer.start(method(:_onTick), 1000, true); // 1000 ms, repeating
    }
        // Method to handle the position calls
    function onPosition(info as Position.Info) as Void {
        if (!locationAcquired) {
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_MSG);
            }
            locationAcquired = true;
        }

        if (info != null && info.position != null) {
            lastLocation = info.position;
        }

        gpsQuality = info.accuracy;
        WatchUi.requestUpdate();
    }

    function _onTick() as Void {
        WatchUi.requestUpdate(); // will call onUpdate()
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        System.println("Updating groundbranchappView");
        if (_alertActive) {
            _drawBackground(dc);
        }
        if (!_alertActive) {
            dc.setColor(COLOR_TEXT, COLOR_BG);
            dc.clear();

            // --- time (draw directly, no layout needed)
            var t = System.getClockTime();
            var timeStr = Lang.format("$1$:$2$", [t.hour, t.min.format("%02d")]);
            dc.setColor(COLOR_TEXT, COLOR_BG);
            dc.drawText(_cx, _cy - 76, Graphics.FONT_NUMBER_THAI_HOT, timeStr, Graphics.TEXT_JUSTIFY_CENTER);

        }
        
        // --- heading
        var h = getHeadingDegrees();
        System.println("Heading (deg): " + h);

        // --- compass ring
        _drawCompassRing(dc, false, h);
        _drawCompassRing(dc, true,  h);

        // --- proximity check + possible overlay
        try {
            _checkProximity(dc);
        } catch(e) {
        System.println("[onUpdate] ERROR type: " + e.getErrorMessage());
        System.println("[onUpdate] ERROR details: " + e.toString());
        }
    }

        // ---------- PROXIMITY ----------
    function _checkProximity(dc as Dc) as Void {
        var info = Position.getInfo();
        if (info == null || info.position == null) {
            // optional: show "ACQUIRING GPS" hint
            dc.setColor(COLOR_TEXT, COLOR_BG);
            dc.drawText(_cx, _cy + 36, Graphics.FONT_XTINY, "ACQUIRING GPS…", Graphics.TEXT_JUSTIFY_CENTER);
            return;
        }

        var acc = info.accuracy; // meters (may be null)
        System.println("Initiate the proximity check");
        var myLocation = info.position.toDegrees();
        lat = myLocation[0] as Float;
        lon = myLocation[1] as Float;

        var dist = _haversine(lat, lon, TARGET_LAT, TARGET_LON); // meters
        System.println("GPS dist=" + dist + "m acc=" + acc);

        // Only consider a trigger when both distance and accuracy are tight
        var accOk = (acc != null && acc <= ACC_MAX_M);
        if (accOk && dist <= RADIUS_M && !_cooldown) {
            _triggerProximityAlert();
        }

        // Overlay if active
        if (_alertActive) {
            _drawAlertOverlay(dc);
        }
    }

    function _triggerProximityAlert() as Void {
        System.println("[ALERT] Objective close!");
        _alertActive = true;
        _cooldown = true;

        var vibeData = [
            new Attention.VibeProfile(50, 2000),
            new Attention.VibeProfile(0, 2000),
            new Attention.VibeProfile(50, 2000),
            new Attention.VibeProfile(0, 2000),
            new Attention.VibeProfile(50, 2000)
        ];

        try {
            Attention.vibrate(vibeData);
        } catch(e) {
            System.println("Vibrate not supported: " + e.getErrorMessage());
        }

        if (_alertOffTimer == null) { _alertOffTimer = new Timer.Timer(); }
        _alertOffTimer.start(method(:_endAlert), 3000, false);

        if (_cooldownTimer == null) { _cooldownTimer = new Timer.Timer(); }
        _cooldownTimer.start(method(:_endCooldown), 15000, false);
    }

    function _endAlert() as Void { _alertActive = false; }
    function _endCooldown() as Void { _cooldown = false; }

    function _drawBackground(dc as Dc) as Void {
        // Draw the background
        // 1) Red circular plate that fits the screen
        var r = (dc.getWidth() < dc.getHeight() ? dc.getWidth() : dc.getHeight()) / 2.0 - 2;
        dc.setColor(COLOR_ALERT_BG, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(_cx, _cy, r);
    }

    function _drawAlertOverlay(dc as Dc) as Void {

        // 2) Text in Red with transparent background
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_cx, _cy - 18, Graphics.FONT_MEDIUM, "OBJECTIVE", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(_cx, _cy + 28, Graphics.FONT_MEDIUM, "CLOSE",     Graphics.TEXT_JUSTIFY_CENTER);
    }

        // Haversine (meters)
    function _haversine(lat1 as Float, lon1 as Float, lat2 as Float, lon2 as Float) as Float {
        var R = 6371000.0;
        var dLat = Math.toRadians(lat2 - lat1);
        var dLon = Math.toRadians(lon2 - lon1);
        var a = Math.sin(dLat/2)*Math.sin(dLat/2) +
                Math.cos(Math.toRadians(lat1)) *
                Math.cos(Math.toRadians(lat2)) *
                Math.sin(dLon/2)*Math.sin(dLon/2);
        var c = 2* Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return R * c;
    }

    function _drawCompassRing(dc as Dc, isNorthRing as Boolean, headingDeg as Float) as Void {
        System.println("Drawing " + (isNorthRing ? "North" : "South") + " Compass Ring");
        var labels;
        var color;
        if (isNorthRing) {
            labels = ["N","","","","","","",""];
            color = COLOR_NORTH;
        } else {
            labels = ["","NE","E","SE","S","SW","W","NW"];
            color = COLOR_TEXT;
        }
        var step = 360.0 / labels.size();

        var fontAll   = Graphics.FONT_TINY;
        var fontNorth = Graphics.FONT_TINY;

        for (var i = 0; i < labels.size(); i++) {
            var aDeg = (i * step) - headingDeg;
            var aRad = Math.toRadians(aDeg);

            var x = _cx + _radius * Math.sin(aRad);
            var y = _cy - _radius * Math.cos(aRad);

            var isNorth = (labels[i] == "N");
            var fontUse = isNorth ? fontNorth : fontAll;

            var dims = dc.getTextDimensions(labels[i], fontUse);
            var yCentered = y - (dims[1] / 2.0);

            if (isNorth) { yCentered += 2; }

            dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, yCentered, fontUse, labels[i], Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Debug ring
        // dc.setColor(COLOR_TEXT, COLOR_BG);
        // dc.setPenWidth(1);
        // dc.drawCircle(_cx, _cy, _radius);
    }

    function getHeadingDegrees() as Float {
        System.println("Current Heading: " + _lastHeadingDeg);
        var info = Activity.getActivityInfo();
        if (info != null && info.currentHeading != null) {
            _lastHeadingDeg = Math.toDegrees(info.currentHeading);
        }
        return _lastHeadingDeg;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
        if (_timer != null) {
            _timer.stop();
        }
    }

}
