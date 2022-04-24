import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
using Toybox.Application;

class mainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        var mdl = timerModel(Storage.getValue("ArcTiming").toNumber());
        WatchUi.pushView(new timerView(mdl), new timerDelegate(mdl), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
    
    function onPreviousPage() {
        viewOptions();
    }
    
    function viewOptions() {
        var paramSignal = [
                            [0, Application.loadResource(Rez.Strings.NoSignal)], 
                            [1, Application.loadResource(Rez.Strings.Vibrate)], 
                            [2, Application.loadResource(Rez.Strings.Tone)], 
                            [3, Application.loadResource(Rez.Strings.Vibrate) + " + " + Application.loadResource(Rez.Strings.Tone)]
                        ];
        var menu = new OptionMenu({:title=>Rez.Strings.AppName}, 
            [
                ["ArcTiming", Application.loadResource(Rez.Strings.Chrono), 
                    [
                        [0, Application.loadResource(Rez.Strings.NoTimer)], 
                        [120, "120 " + Application.loadResource(Rez.Strings.UnitSec)], 
                        [240, "240 " + Application.loadResource(Rez.Strings.UnitSec)]
                    ]
                ],
                ["ArcStartSignal", Application.loadResource(Rez.Strings.StartSignal), paramSignal],
                ["ArcWarningSignal", Application.loadResource(Rez.Strings.WarningSignal), paramSignal],
                ["ArcEndSignal", Application.loadResource(Rez.Strings.EndSignal), paramSignal]
            ]);
        WatchUi.pushView(menu, new OptionDelegate(menu), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    // Detect Menu button input
    //function onKey(keyEvent) {
    //    System.println(keyEvent.getKey()); // e.g. KEY_MENU = 7
    //    return true;
    //}

}