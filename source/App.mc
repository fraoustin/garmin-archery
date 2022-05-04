import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // manage default value parameter
        if (Storage.getValue("ArcTiming") == null){
            Storage.setValue("ArcTiming", 240);
        }
        if (Storage.getValue("ArcWarningSignal") == null){
            Storage.setValue("ArcWarningSignal", 1);
        }
        if (Storage.getValue("ArcEndSignal") == null){
            Storage.setValue("ArcEndSignal", 2);
        }
        if (Storage.getValue("ArcStartSignal") == null){
            Storage.setValue("ArcStartSignal", 0);
        }
        Storage.setValue("ArcRound", []); 
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new mainView(), new mainDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as App {
    return Application.getApp() as App;
}