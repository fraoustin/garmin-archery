using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;
using Toybox.Application;

class ScoringMenu extends WatchUi.Menu2 {

    function initialize(options) {
        Menu2.initialize(options);
        var round = Storage.getValue("ArcRound");
        var scoring = ["10+", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1"];   
        for( var i = 0; i < scoring.size(); i++ ) {
            addItem(
                new MenuItem(
                    Application.loadResource(Rez.Strings.Point) + " " + scoring[i],
                    round[round.size()-1][1][i] + " " + Application.loadResource(Rez.Strings.Arrow),
                    i,
                    {}
                )
            );
        }
    }
}

class ScoringDelegate extends WatchUi.Menu2InputDelegate {

    var parentMenu;

    var array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

    function initialize(p) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
    }

    function onSelect(item) {
        var round = Storage.getValue("ArcRound");
        var menu = new WatchUi.Menu2({:title=>item.getLabel()});        
        for( var i = 0; i < array.size(); i++ ) {
            menu.addItem(new ScoringMenuitemValue(array[i], i, {}, item));
            if (round[round.size()-1][1][item.getId().toNumber()] == array[i]) { menu.setFocus(i);}
        }
        WatchUi.pushView(menu, new ScoringDelegateValue(parentMenu, 0), WatchUi.SLIDE_IMMEDIATE);
    }

    function onBack(){
        WatchUi.pushView(new mainView(), new mainDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}


class ScoringMenuitemValue extends WatchUi.MenuItem {
    
    var _item;

    function initialize(label , identifier, options, item) {
        _item = item;
        MenuItem.initialize(label , "" , identifier, options);
    }

    function getParam() {
        return _item.getId();
    }

    function getPos() {
        return _item.getPos();
    }
}

class ScoringDelegateValue extends WatchUi.Menu2InputDelegate {
    
    var parentMenu;

    function initialize(p, i) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
    }

    function onSelect(item) {
        var round = Storage.getValue("ArcRound");
        round[round.size()-1][1][item.getParam().toNumber()] = item.getId().toNumber();
        Storage.setValue("ArcRound", round);
        System.println(round);
        System.println(Storage.getValue("ArcRound"));
        parentMenu.getItem(item.getParam()).setSubLabel(item.getLabel() + " " + Application.loadResource(Rez.Strings.Arrow));
        parentMenu.setFocus(item.getParam());
        onBack();
    }
}