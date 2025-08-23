import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class SettingsView extends WatchUi.View {

    var _selectedIndex;
    var _settings;
    
    function initialize() {
        View.initialize();
        _selectedIndex = 0;
        var app = getApp();
        _settings = [
            {
                :name => "Target Lat",
                :value => app.getTargetLatitude(),
                :type => :latitude
            },
            {
                :name => "Target Lon", 
                :value => app.getTargetLongitude(),
                :type => :longitude
            },
            {
                :name => "Radius (m)",
                :value => app.getProximityRadius(),
                :type => :radius
            }
        ];
    }

    function onLayout(dc as Dc) as Void {
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;
        
        // Title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 20, Graphics.FONT_SMALL, "SETTINGS", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw settings items
        var startY = 60;
        var itemHeight = 35;
        
        for (var i = 0; i < _settings.size(); i++) {
            var y = startY + (i * itemHeight);
            var setting = _settings[i];
            
            // Highlight selected item
            if (i == _selectedIndex) {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_DK_GRAY);
                dc.fillRectangle(5, y - 5, width - 10, itemHeight - 5);
            }
            
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(10, y, Graphics.FONT_XTINY, setting[:name], Graphics.TEXT_JUSTIFY_LEFT);
            
            var valueStr = setting[:value].format("%.6f");
            if (setting[:type] == :radius) {
                valueStr = setting[:value].format("%.1f");
            }
            dc.drawText(width - 10, y, Graphics.FONT_XTINY, valueStr, Graphics.TEXT_JUSTIFY_RIGHT);
        }
        
        // Instructions
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, height - 40, Graphics.FONT_XTINY, "SELECT to edit", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, height - 25, Graphics.FONT_XTINY, "BACK to exit", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function moveUp() as Void {
        if (_selectedIndex > 0) {
            _selectedIndex--;
            WatchUi.requestUpdate();
        }
    }
    
    function moveDown() as Void {
        if (_selectedIndex < _settings.size() - 1) {
            _selectedIndex++;
            WatchUi.requestUpdate();
        }
    }
    
    function selectCurrentItem() as Void {
        var setting = _settings[_selectedIndex];
        var textPicker = new WatchUi.TextPicker(setting[:value].toString());
        WatchUi.pushView(textPicker, new SettingsTextDelegate(setting, self), WatchUi.SLIDE_LEFT);
    }
    
    function updateSetting(index as Number, newValue as Float) as Void {
        _settings[index][:value] = newValue;
        
        var app = getApp();
        if (index == 0) {
            app.setTargetLatitude(newValue);
        } else if (index == 1) {
            app.setTargetLongitude(newValue);
        } else if (index == 2) {
            app.setProximityRadius(newValue);
        }
        
        WatchUi.requestUpdate();
    }
    
    function getSelectedIndex() as Number {
        return _selectedIndex;
    }
}

class SettingsDelegate extends WatchUi.BehaviorDelegate {

    var _view;
    
    function initialize(view as SettingsView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_UP) {
            _view.moveUp();
            return true;
        } else if (key == WatchUi.KEY_DOWN) {
            _view.moveDown();
            return true;
        } else if (key == WatchUi.KEY_ENTER) {
            _view.selectCurrentItem();
            return true;
        }
        
        return false;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }
}

class SettingsTextDelegate extends WatchUi.TextPickerDelegate {
    
    var _setting;
    var _settingsView;
    
    function initialize(setting as Dictionary, settingsView as SettingsView) {
        TextPickerDelegate.initialize();
        _setting = setting;
        _settingsView = settingsView;
    }
    
    function onTextEntered(text as String, changed as Boolean) as Boolean {
        if (changed) {
            try {
                var value = text.toFloat();
                var index = _settingsView.getSelectedIndex();
                _settingsView.updateSetting(index, value);
            } catch (e) {
                System.println("Invalid number format: " + text);
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }
}