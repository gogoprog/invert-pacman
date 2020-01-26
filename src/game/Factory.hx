package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function preload(scene:phaser.Scene) {
        // scene.load.spritesheet('pacman', '../data/spritesheets/pacman.png', { frameWidth: 16, frameHeight: 16});
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
        return e;
    }

}
