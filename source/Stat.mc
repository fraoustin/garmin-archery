import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Graphics;
using Toybox.Graphics as Gfx;
using Toybox.Application;

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
}

class StatOneView extends WatchUi.View {

    hidden var myText;

    function initialize() {
        View.initialize();
    }

    function onShow() {
        myText = new WatchUi.Text({
            :text=>"Stat 1",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_LARGE,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.StatLayout(dc));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        myText.draw(dc);
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
}

class StatTwoView extends WatchUi.View {

    hidden var myText;

    function initialize() {
        View.initialize();
    }

    function onShow() {
        myText = new WatchUi.Text({
            :text=>"Stat 2",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_LARGE,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.StatLayout(dc));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        myText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}