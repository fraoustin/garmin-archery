import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Graphics;
using Toybox.Graphics as Gfx;
using Toybox.Application;

class mainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        var newround = Storage.getValue("ArcRound");
        newround.add([Storage.getValue("ArcTiming").toNumber(), [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]);
        Storage.setValue("ArcRound", newround);
        var mdl = new timerModel(Storage.getValue("ArcTiming").toNumber());
        if (Storage.getValue("ArcTiming").toNumber() > 0) {
            WatchUi.pushView(new timerView(mdl), new timerDelegate(mdl), WatchUi.SLIDE_IMMEDIATE);
            mdl.start();
        } else {
            mdl.stop();
        }
        return true;
    }
    
    function onPreviousPage() {
        viewOptions();
    }
    
    function onNextPage() {
        WatchUi.pushView(new StatOneView(), new StatOneDelegate(), WatchUi.SLIDE_IMMEDIATE);
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



class mainView extends WatchUi.View {

    hidden var myText;

    function initialize() {
        View.initialize();
    }

    function onShow() {
        myText = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_LARGE,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var round = Storage.getValue("ArcRound").size() + 1;
        myText.setText(Application.loadResource(Rez.Strings.Round) + " " + round);
        myText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}