import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class groundbranchappApp extends Application.AppBase {

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
        return [ new groundbranchappView() ];
    }
    //! For this app all that needs to be done is trigger a WatchUi refresh
    //! since the settings are only used in onUpdate().
    public function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}