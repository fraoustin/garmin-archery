using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class Areaoption extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Areaoption"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), 35);
    }

}

class Background extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_WHITE);
        dc.clear();
    }

}

class BackgroundBlack extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "BackgroundBlack"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
    }

}
