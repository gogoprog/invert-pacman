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
        AudioManager.init(whiplash.Lib.phaserScene);
        whiplash.Lib.phaserScene.cameras.main.setBackgroundColor('#000000');

        var e = Factory.createLevel();
        engine.addEntity(e);
        var e = Factory.createItems();
        engine.addEntity(e);

        addGhost(6, 5);
        addGhost(24, 5);
        addGhost(6, 26);
        addGhost(24, 26);

        var e = Factory.createPacman();
        engine.addEntity(e);

        engine.addSystem(new game.controller.PlayerSystem(), 1);
        engine.addSystem(new game.controller.BotSystem(), 1);
        engine.addSystem(new game.logic.CharacterSystem(), 2);
        engine.addSystem(new game.logic.MoveSystem(), 3);
        engine.addSystem(new game.logic.ObjectSystem(), 10);
        engine.addSystem(new game.logic.PickerSystem(), 10);
    }

    public function addGhost(x, y) {
        var e = Factory.createGhost();
        engine.addEntity(e);
        e.get(game.logic.Object).position.set(x, y);
    }

    static function main():Void {
        new Game();
    }
}
