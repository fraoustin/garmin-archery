import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Graphics;
using Toybox.Graphics as Gfx;
using Toybox.Application;
using Toybox.ActivityRecording;
import Toybox.FitContributor;

var session = null; 
var totalArrowField = null;
var totalScoreField = null;
var meanScoreField = null;
var totalArrowTenMore = null;
var totalArrowTen = null;
var totalArrowNine = null;
var totalArrowHeight = null;
var totalArrowSeven = null;
var totalArrowSix = null;
var totalArrowFive = null;
var totalArrowFour = null;
var totalArrowThree = null;
var totalArrowTwo = null;
var totalArrowOne = null;

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
        if (Toybox has :ActivityRecording) {                          // check device for activity recording
            if ((session == null) || (session.isRecording() == false)) {
                session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Arrow",                              // set session name
                        :sport=>ActivityRecording.SPORT_SHOOTING,       // set sport type
                        :subSport=>ActivityRecording.SUB_SPORT_GENERIC // set sub sport type
                });
                totalArrowField = session.createField(Application.loadResource(Rez.Strings.Arrow), 1, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalScoreField = session.createField(Application.loadResource(Rez.Strings.Point), 2, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                meanScoreField = session.createField(Application.loadResource(Rez.Strings.Mean), 3, FitContributor.DATA_TYPE_FLOAT, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowTenMore = session.createField(Application.loadResource(Rez.Strings.NumberOfTenMore), 4, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowTen = session.createField(Application.loadResource(Rez.Strings.NumberOfTen), 5, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowNine = session.createField(Application.loadResource(Rez.Strings.NumberOfNine), 6, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowHeight = session.createField(Application.loadResource(Rez.Strings.NumberOfHeight), 7, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowSeven = session.createField(Application.loadResource(Rez.Strings.NumberOfSeven), 8, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowSix = session.createField(Application.loadResource(Rez.Strings.NumberOfSix), 9, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowFive = session.createField(Application.loadResource(Rez.Strings.NumberOfFive), 10, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowFour = session.createField(Application.loadResource(Rez.Strings.NumberOfFour), 11, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowThree = session.createField(Application.loadResource(Rez.Strings.NumberOfThree), 12, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowTwo = session.createField(Application.loadResource(Rez.Strings.NumberOfTwo), 13, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                totalArrowOne = session.createField(Application.loadResource(Rez.Strings.NumberOfTOne), 14, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
                session.start();                                     // call start session
            }
        }
        return true;
    }
    
    function onPreviousPage() {
        viewOptions();
    }
    
    function onNextPage() {
        WatchUi.pushView(new StatOneView(), new StatOneDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onBack() {
        if (Toybox has :ActivityRecording) {                          // check device for activity recording
            if ((session != null) && session.isRecording()) {
            } else {
                Toybox.System.exit();
            }
        } else {
            Toybox.System.exit();
        }
        
        
        var menu = new WatchUi.Menu2({:title=>Application.loadResource(Rez.Strings.AppName)});
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.Save),
                "",
                1,
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Application.loadResource(Rez.Strings.Restart),
                "",
                2,
                {}
            )
        );
        WatchUi.pushView(menu, new SaveInputDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
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


class SaveInputDelegate extends WatchUi.Menu2InputDelegate  {
    function initialize() {
        Menu2InputDelegate .initialize();
    }

    function onSelect(item) {
        if (item.getId() == 1) {
            session.stop();                                      // stop the session
            var result = getResult();
            var score = result[3];
            totalArrowField.setData(result[2]);
            totalScoreField.setData(result[4]);
            var mean = 0;
            if (result[2] > 0) {
                mean = result[4].toFloat()/result[2].toFloat();
            }
            meanScoreField.setData(mean.format("%.2f").toFloat());
            totalArrowTenMore = score[0];
            totalArrowTen = score[1];
            totalArrowNine = score[2];
            totalArrowHeight = score[3];
            totalArrowSeven = score[4];
            totalArrowSix = score[5];
            totalArrowFive = score[6];
            totalArrowFour = score[7];
            totalArrowThree = score[8];
            totalArrowTwo = score[9];
            totalArrowOne = score[10];
            session.save();                                      // save the session
            session = null;                                      // set session control variable to null
            Toybox.System.exit();
        } else {
            WatchUi.pushView(new mainView(), new mainDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }
}