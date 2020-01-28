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
        var e = Factory.createCharacter();
        engine.addEntity(e);

        e.get(game.logic.Object).position.set(10, 10);
        e.get(game.logic.Character).requestedDirection = South;

        engine.addSystem(new game.logic.CharacterSystem(), 1);
        engine.addSystem(new game.logic.MoveSystem(), 2);
        engine.addSystem(new game.logic.ObjectSystem(), 10);
    }

    static function main():Void {
        new Game();
    }
}
