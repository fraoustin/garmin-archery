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
        if (item.getId().equals("ArcTiming")){
            var menu = new WatchUi.Menu2({:title=>Rez.Strings.Chrono});
            menu.addItem(new MenuItem(Application.loadResource(Rez.Strings.NoTimer), "", 0, {}));
            menu.addItem(new MenuItem("120 " + Application.loadResource(Rez.Strings.UnitSec), "", 120, {}));
            menu.addItem(new MenuItem("240 " + Application.loadResource(Rez.Strings.UnitSec), "", 240, {}));
            if (Storage.getValue("ArcTiming") == 0) { menu.setFocus(0);}
            if (Storage.getValue("ArcTiming") == 120) { menu.setFocus(1);}
            if (Storage.getValue("ArcTiming") == 240) { menu.setFocus(2);}
            WatchUi.pushView(menu, new TimerDelegate(parentMenu, 0), WatchUi.SLIDE_IMMEDIATE);
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