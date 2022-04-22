using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;
using Toybox.Application;

class OptionDelegate extends WatchUi.Menu2InputDelegate {

    var parentMenu;

    function initialize(p) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "ArcTiming": {
                var array = [[Application.loadResource(Rez.Strings.NoTimer), 0],
                    ["120 " + Application.loadResource(Rez.Strings.UnitSec), 120],
                    ["240 " + Application.loadResource(Rez.Strings.UnitSec), 240]];
                var menu = new WatchUi.Menu2({:title=>Rez.Strings.Chrono});
                for( var i = 0; i < array.size(); i++ ) {
                    menu.addItem(new MenuItem(array[i][0], "", array[i][1], {}));
                    if (Storage.getValue(item.getId()) == array[i][1]) { menu.setFocus(i);}
                }
                WatchUi.pushView(menu, new TimerDelegate(parentMenu, 0), WatchUi.SLIDE_IMMEDIATE);
                break;
            }
        }
    }
}

class TimerDelegate extends WatchUi.Menu2InputDelegate {
    
    var parentMenu;
    var indexItem;

    function initialize(p, i) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
        indexItem = i;
    }

    function onSelect(item) {
        Storage.setValue("ArcTiming", item.getId());
        parentMenu.getItem(indexItem).setSubLabel(Storage.getValue("ArcTiming").toString() + " " + Application.loadResource(Rez.Strings.UnitSec));
        parentMenu.setFocus(indexItem);
        onBack();
    }
}