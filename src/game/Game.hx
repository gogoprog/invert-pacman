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
    static public var instance:Game;

    private var score:Int;

    public function new() {
        super(Config.screenWidth, Config.screenHeight, ".root", phaser.scale.scalemodes.NONE);
        instance = this;
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        Factory.init(whiplash.Lib.phaserScene);
        AudioManager.init(whiplash.Lib.phaserScene);
        whiplash.Input.preventDefaultKeys = true;
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

        var idleState = createState("idling");

        engine.addSystem(new game.logic.CharacterSystem(), 2);
        engine.addSystem(new game.logic.MoveSystem(), 3);
        engine.addSystem(new game.logic.CollisionSystem(), 4);
        engine.addSystem(new game.logic.ObjectSystem(), 10);
        engine.addSystem(new game.logic.PickerSystem(), 10);
        engine.addSystem(new game.display.RotateSystem(), 11);
        engine.addSystem(new game.display.CharacterAnimationSystem(), 11);

        var playingState = createState("playing");
        playingState.addInstance(new game.controller.PlayerSystem());
        playingState.addInstance(new game.controller.BotSystem());

        changeState("idling");

        delay(function() {
            changeState("playing");
        }, 2);

        reset();
    }

    private function addGhost(x, y) {
        var e = Factory.createGhost();
        engine.addEntity(e);
        e.get(game.logic.Object).position.set(x, y);
    }

    public function reset() {
        score = 0;
        new js.jquery.JQuery(".score .value").text(score);
    }

    public function increaseScore(val:Int) {
        score += val;
        new js.jquery.JQuery(".score .value").text(score);
    }

    public function gameOver() {
        new js.jquery.JQuery(".title").text("You've lost!");
        changeState("idling");
    }

    static function main():Void {
        new Game();
    }
}
