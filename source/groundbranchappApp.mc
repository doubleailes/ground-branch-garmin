import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class groundbranchappApp extends Application.AppBase {

    var _view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        _view = new groundbranchappView();
        return [ _view ];
    }
    //! Called when the user updates the settings of the app via Garmin Connect
    //! Reloads the settings and refreshes the UI
    public function onSettingsChanged() as Void {
        if (_view != null) {
            _view.reloadSettings();
        }
        WatchUi.requestUpdate();
    }

}