package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function preload(scene:phaser.Scene) {
        scene.load.spritesheet('pacmansheet', '../data/textures/pacman.png', { frameWidth: 16, frameHeight: 16 });
    }

    static public function init(scene:phaser.Scene) {
    }

    static public function createSprite(which) {
        var e = new Entity();
        e.add(new Sprite(which));
        e.add(new Transform());
        return e;
    }

    static public function createLevel() {
        var tilemap:phaser.tilemaps.Tilemap;
        tilemap = whiplash.Lib.phaserScene.add.tilemap('level');
        var tileset = tilemap.addTilesetImage('pacman', 'pacman');
        var e = new Entity();
        e.add(new TilemapLayer(tilemap, 0, tileset));
        e.add(new Transform());
        e.name = "level";
        return e;
    }

    static public function createGhost() {
        var e = new Entity();
        e.add(new Sprite("pacmansheet", 5*32 + 25));
        e.add(new Transform());
        e.add(new game.logic.Character());
        e.add(new game.logic.Object(10, 10));
        e.add(new game.controller.Player());
        return e;
    }
}
