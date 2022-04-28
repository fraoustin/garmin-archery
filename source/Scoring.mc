using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;
using Toybox.Application;

class ScoringMenu extends WatchUi.Menu2 {

    function initialize(options) {

        Menu2.initialize(options);
        addItem(
            new MenuItem(
                "Item 1 Label",
                "Item 1 subLabel",
                "itemOneId",
                {}
            )
        );
        addItem(
            new MenuItem(
                "Item 2 Label",
                "Item 2 subLabel",
                "itemTwoId",
                {}
            )
        );
    }
}

class ScoringDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        System.println(item.getId());
    }

    function onBack(){
        var newround = Storage.getValue("ArcRound");
        newround.add([120, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]);
        Storage.setValue("ArcRound", newround);
        WatchUi.pushView(new mainView(), new mainDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}