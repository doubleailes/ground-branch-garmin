import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Activity;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;


class groundbranchappView extends WatchUi.View {

    const COLOR_BG    = Graphics.COLOR_BLACK;
    const COLOR_TEXT  = Graphics.COLOR_WHITE;
    const COLOR_NORTH = Graphics.COLOR_RED;
    var _cx, _cy, _radius;
    var _lastHeadingDeg = 0.0;
    var _timer;

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
        _timer = new Timer.Timer();
        _timer.start(method(:_onTick), 1000, true); // 1000 ms, repeating
    }

    function _onTick() as Void {
        WatchUi.requestUpdate(); // will call onUpdate()
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        System.println("Updating groundbranchappView");


        // --- background
        dc.setColor(COLOR_TEXT, COLOR_BG);
        dc.clear();

        // --- time (draw directly, no layout needed)
        var t = System.getClockTime();
        var timeStr = Lang.format("$1$:$2$", [t.hour, t.min.format("%02d")]);
        dc.setColor(COLOR_TEXT, COLOR_BG);
        dc.drawText(_cx, _cy - 76, Graphics.FONT_NUMBER_THAI_HOT, timeStr, Graphics.TEXT_JUSTIFY_CENTER);

        // --- heading
        var h = getHeadingDegrees();
        System.println("Heading (deg): " + h);

        // --- compass ring
        _drawCompassRing(dc, false, h);
        _drawCompassRing(dc, true,  h);
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

            dc.setColor(color, COLOR_BG);
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
