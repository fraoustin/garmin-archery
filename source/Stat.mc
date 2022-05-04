import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Graphics;
using Toybox.Graphics as Gfx;
using Toybox.Application;
import Toybox.Math;



function getResult() as Void{
    var score = [10, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
    var rounds = Storage.getValue("ArcRound");
    // scoring = [time, rounds, arrows, [number of 10+, number of 10, number of 9, number of 8, ... , number of 1], total 
    var scoring = [0, 0, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 0];   
    for( var i = 0; i < rounds.size(); i++ ) {
        scoring[0] = scoring[0] + rounds[i][0];
        scoring[1] = scoring[1] + 1;
        for( var j = 0; j < rounds[i][1].size(); j++ ) {
            scoring[3][j] = scoring[3][j] + rounds[i][1][j];
            scoring[2] = scoring[2] + rounds[i][1][j]; 
            scoring[4] = scoring[4] + score[j] * rounds[i][1][j];      
        }
    }  
    return scoring;
}

class StatOneDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        return true;
    }
    
    function onPreviousPage() {
        WatchUi.pushView(new mainView(), new mainDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onNextPage() {
        WatchUi.pushView(new StatTwoView(), new StatTwoDelegate(), WatchUi.SLIDE_IMMEDIATE); 
    }

    // Disabled onBack ...
    function onKey(keyEvent) {
        if (keyEvent.getKey() == 5){
            return true;
        }
        return false;
    }
}

class StatOneView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onShow() {
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.StatOneLayout(dc));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        dc.clear();
        var result = getResult();
        var LAYOUT_VALIGN_MIDDLE = dc.getHeight() / 2;
        View.onUpdate(dc);
        var maxScore = result[2] * 10;
        var text = new WatchUi.Text({
            :text=> result[4].toString() + " / " +  maxScore.toString(),
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>LAYOUT_VALIGN_MIDDLE -65
        });
        text.draw(dc);
        var mean = 0;
        if (result[2] > 0) {
            mean = result[4].toFloat()/result[2].toFloat();
        }
        text = new WatchUi.Text({
            :text=>Application.loadResource(Rez.Strings.Mean) + " " + mean.format("%.2f").toString(),
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>LAYOUT_VALIGN_MIDDLE -35
        });
        text.draw(dc);
        var min=0;
        var sec=0;        
        if (result[0] > 0) {
            min = result[0]/60;
            sec = result[0] - min*60;
        }        
        text = new WatchUi.Text({
            :text=>min.toString() + ":" + sec.format("%02d").toString(),
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>LAYOUT_VALIGN_MIDDLE +5
        });
        text.draw(dc);
        var meantime = 0;
        if (result[0] > 2) {
            meantime = result[0]/result[2];
        }
        text = new WatchUi.Text({
            :text=>Application.loadResource(Rez.Strings.Mean) + " " +  meantime.toString() + " " + Application.loadResource(Rez.Strings.UnitSec),
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>LAYOUT_VALIGN_MIDDLE +35
        });
        text.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

class StatTwoDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        return true;
    }
    
    function onPreviousPage() {
        WatchUi.pushView(new StatOneView(), new StatOneDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onNextPage() {
        WatchUi.pushView(new mainView(), new mainDelegate(), WatchUi.SLIDE_IMMEDIATE);   
    }

    // Disabled onBack ...
    function onKey(keyEvent) {
        if (keyEvent.getKey() == 5){
            return true;
        }
        return false;
    }
}

class StatTwoView extends WatchUi.View {

    var text;

    function initialize() {
        View.initialize();
    }

    function onShow() {
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.StatTwoLayout(dc));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        dc.clear();
        // Call the parent onUpdate function to redraw the layout
        var RAYON = dc.getWidth() / 2;
        var BASSQU = RAYON / Math.sqrt(2);
        var LAYOUT_INIT_RECT = RAYON - BASSQU;
        var scoring = ["10+", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1"];
        var scoringColor = [Graphics.COLOR_YELLOW, Graphics.COLOR_YELLOW, Graphics.COLOR_ORANGE, Graphics.COLOR_DK_RED, Graphics.COLOR_RED, Graphics.COLOR_DK_BLUE, Graphics.COLOR_BLUE, Graphics.COLOR_BLACK, Graphics.COLOR_DK_GRAY, Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE];
        for( var i = 0; i < scoring.size(); i++ ) {
            text = new WatchUi.Text({
                :text=>scoring[i],
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_XTINY,
                :locX =>LAYOUT_INIT_RECT + 20,
                :locY=>LAYOUT_INIT_RECT + i*2*BASSQU/10,
                :justification=>Graphics.TEXT_JUSTIFY_RIGHT
            });        
            text.draw(dc);
        }

        var score = getResult()[3];
        var maxScore = 1;
        var widthBarFull = 2*BASSQU - 70;
        for( var i = 0; i < score.size(); i++ ) {
            text = new WatchUi.Text({
                :text=>score[i].toString(),
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_XTINY,
                :locX =>LAYOUT_INIT_RECT - 20 + 2*BASSQU,
                :locY=>LAYOUT_INIT_RECT + i*2*BASSQU/10,
                :justification=>Graphics.TEXT_JUSTIFY_RIGHT
            });        
            text.draw(dc);
            if (score[i] > maxScore ){
                maxScore = score[i];
            }
        }
        for( var i = 0; i < score.size(); i++ ) {
            var x = LAYOUT_INIT_RECT + 22;
            var y = LAYOUT_INIT_RECT + i*2*BASSQU/10 +5;
            var heightbar = 10;
            var widthbar = widthBarFull * score[i] / maxScore;
            dc.setColor(scoringColor[i], Graphics.COLOR_BLACK);
            dc.fillRoundedRectangle(x, y, widthbar, heightbar, 10);
            dc.fillRectangle(x, y, widthbar-10, heightbar);
        }


    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}