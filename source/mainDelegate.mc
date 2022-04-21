import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
using Toybox.Application;

class mainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onPreviousPage() {
        var menu = new WatchUi.Menu2({:title=>Rez.Strings.AppName});
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.Chrono),
                Storage.getValue("ArcTiming").toString() + " " + Application.loadResource(Rez.Strings.UnitSec),
                "ArcTiming",
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.StartSignal),
                "??",
                "ArcStartSignal",
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.WarningSignal),
                "??",
                "ArcWarningSignal",
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.EndSignal),
                "??",
                "ArcEndSignal",
                {}
            )
        );
        WatchUi.pushView(menu, new OptionDelegate(menu), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    // Detect Menu button input
    //function onKey(keyEvent) {
    //    System.println(keyEvent.getKey()); // e.g. KEY_MENU = 7
    //    return true;
    //}

}