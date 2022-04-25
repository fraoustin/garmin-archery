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
}