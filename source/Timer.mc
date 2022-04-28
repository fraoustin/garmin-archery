import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Graphics as Gfx;
import Toybox.Application.Storage;
using Toybox.Application;
using Toybox.Timer as Timer;
using Toybox.Attention as Attention;


class timerView extends WatchUi.View {

    hidden var timerText;
    hidden var roundText;
    var model;

    function initialize(mdl) {
        model = mdl;
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.TimerLayout(dc));
    }

    function onShow() {
        timerText = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_NUMBER_THAI_HOT,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        roundText = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>5
        });
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        timerText.setColor(model.getColor());
        timerText.setText(model.getText());
        timerText.draw(dc);
        var round = Storage.getValue("ArcRound").size() + 1;
        roundText.setText(Application.loadResource(Rez.Strings.Round) + " " + round);
        roundText.draw(dc);
    }
}


class timerDelegate extends WatchUi.BehaviorDelegate {
    var model;

    function initialize(mdl) {
        model = mdl;
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        model.stop();
        var round = Storage.getValue("ArcRound").size() + 1;
        WatchUi.pushView(new ScoringMenu({:title=>Application.loadResource(Rez.Strings.Round) + " " + round}), new ScoringDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onBack() {
        return true;
    }

}

class timerModel{

    var counter = 0;
    var timer = 0;
    hidden var refreshTimer = new Timer.Timer();

    function initialize(tps) {
        timer = tps;
        counter = timer + 10;
    }

	function start(){
		refreshTimer.start(method(:refresh), 1000, true);
		WatchUi.requestUpdate();
	}

	function refresh(){
		counter--;
        if (counter == 0){
            stop();
        }
        if (counter == timer){
            notification("ArcStartSignal");
        }
        if (counter == 30){
            notification("ArcWarningSignal");
        }
        if (counter == 0){
            notification("ArcEndSignal");
        }
		WatchUi.requestUpdate();
    }

    function stop(){
		refreshTimer.stop();
    }

    function getValue(){
        if (counter > timer){
            return 0;
        }
        return counter - 10;
    }

    function getText(){
        if (counter > timer){
            var val = counter - timer;
            return val.toString();
        }
        return counter.toString();
    }

    function getColor(){
        if (counter > timer){
            return Graphics.COLOR_DK_GRAY;
        }
        if (counter < 30){
            return Graphics.COLOR_DK_RED;
        }
        return Graphics.COLOR_DK_GREEN;
    }

    function notification(typ){
        var t = Storage.getValue(typ);
        if (t == 1){
            vibrate(1500);
        }
        if (t == 2){
            beep(Attention.TONE_LOUD_BEEP);
        }
        if (t == 3){
            vibrate(1500);
            beep(Attention.TONE_LOUD_BEEP);
        }
        
    }

	function vibrate(duration){
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
		Attention.vibrate( vibrateData );
	}

	function beep(tone){
		Attention.playTone(tone);
		return true;
	}

}