using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;
using Toybox.Application;

class OptionMenu extends WatchUi.Menu2 {
    
    var parameters;

    function initialize(options, parameters) {
        parameters = parameters;
        Menu2.initialize(options);      
        for( var i = 0; i < parameters.size(); i++ ) {
            addItem(
                new OptionMenuitem(
                    parameters[i][1],
                    parameters[i][0],
                    parameters[i][2],
                    {},
                    i
                )
            );
        }
    }
}

class OptionDelegate extends WatchUi.Menu2InputDelegate {

    var parentMenu;

    function initialize(p) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
    }

    function onSelect(item) {
        var menu = new WatchUi.Menu2({:title=>item.getLabel()});
        var array = item.getParameters();
        for( var i = 0; i < array.size(); i++ ) {
            menu.addItem(new OptionMenuitemValue(array[i][1], array[i][0], {}, item));
            if (Storage.getValue(item.getId()) == array[i][0]) { menu.setFocus(i);}
        }
        WatchUi.pushView(menu, new OptionDelegateValue(parentMenu, 0), WatchUi.SLIDE_IMMEDIATE);
    }
}

class OptionMenuitem extends WatchUi.MenuItem {
    
    var _parameters;
    var _pos;

    function initialize(label , identifier, parameters, options, pos) {
        _pos = pos;
        _parameters = parameters;
        var subLabel = "";      
        for( var i = 0; i < parameters.size(); i++ ) {
            if (Storage.getValue(identifier) == parameters[i][0]) { subLabel = parameters[i][1];}
        }
        MenuItem.initialize(label , subLabel , identifier, options);
    }

    function getParameters() {
        return _parameters;
    }

    function getPos() {
        return _pos;
    }
}

class OptionMenuitemValue extends WatchUi.MenuItem {
    
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

class OptionDelegateValue extends WatchUi.Menu2InputDelegate {
    
    var parentMenu;

    function initialize(p, i) {
        Menu2InputDelegate.initialize();
        parentMenu = p;
    }

    function onSelect(item) {
        Storage.setValue(item.getParam(), item.getId());
        parentMenu.getItem(item.getPos()).setSubLabel(item.getLabel());
        parentMenu.setFocus(item.getPos());
        onBack();
    }
}