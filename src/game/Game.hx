package game;

import js.Lib;
import js.jquery.*;
import js.Browser.document;
import js.Browser.window;
import phaser.Game;
import phaser.Phaser;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.Node;
import whiplash.*;
import whiplash.math.*;
import whiplash.phaser.*;
import whiplash.common.components.Active;

class Game extends Application {
    public function new() {
        super(Config.screenWidth, Config.screenHeight, ".root", phaser.scale.scalemodes.NONE);
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        Factory.init(whiplash.Lib.phaserScene);
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        AudioManager.init(whiplash.Lib.phaserScene);
        whiplash.Lib.phaserScene.cameras.main.setBackgroundColor('#000000');
        var e = Factory.createLevel();
        engine.addEntity(e);
    }

    static function main():Void {
        new Game();
    }
}
