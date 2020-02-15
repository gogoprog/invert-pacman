package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static var tilemap:phaser.tilemaps.Tilemap;
    static var tileset;

    static public function preload(scene:phaser.Scene) {
        scene.load.spritesheet('pacmansheet', '../data/textures/pacman.png', { frameWidth: 16, frameHeight: 16 });
    }

    static public function init(scene:phaser.Scene) {
        tilemap = whiplash.Lib.phaserScene.add.tilemap('level');
        tileset = tilemap.addTilesetImage('pacman', 'pacman');
        scene.anims.create({
            key: 'pacman',
            frames: [
            { key:'pacmansheet', frame: 21 + 512/16},
            { key:'pacmansheet', frame: 21 },
            { key:'pacmansheet', frame: 22 },
            { key:'pacmansheet', frame: 21 },
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'ghostRight',
            frames: [
            { key:'pacmansheet', frame: 5*32 + 21},
            { key:'pacmansheet', frame: 5*32 + 22},
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'ghostLeft',
            frames: [
            { key:'pacmansheet', frame: 5*32 + 23},
            { key:'pacmansheet', frame: 5*32 + 24},
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'ghostUp',
            frames: [
            { key:'pacmansheet', frame: 5*32 + 25},
            { key:'pacmansheet', frame: 5*32 + 26},
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'ghostDown',
            frames: [
            { key:'pacmansheet', frame: 5*32 + 27},
            { key:'pacmansheet', frame: 5*32 + 28},
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'ghostFear',
            frames: [
            { key:'pacmansheet', frame: 9*32 + 21},
            { key:'pacmansheet', frame: 9*32 + 22},
            ],
            frameRate: 10,
            repeat: -1
        });
    }

    static public function createSprite(which) {
        var e = new Entity();
        e.add(new Sprite(which));
        e.add(new Transform());
        return e;
    }

    static public function createLevel() {
        var e = new Entity();
        e.add(new TilemapLayer(tilemap, 0, tileset));
        e.add(new Transform());
        e.name = "level";
        return e;
    }

    static public function createItems() {
        var e = new Entity();
        e.add(new TilemapLayer(tilemap, 1, tileset));
        e.add(new Transform());
        e.name = "items";
        return e;
    }

    static public function createGhost() {
        var e = new Entity();
        e.add(new Sprite("pacmansheet", 5*32 + 25));
        e.get(Sprite).anims.play("ghostRight");
        e.add(new Transform());
        e.add(new game.logic.Character());
        e.add(new game.logic.Object(10, 10));
        e.add(new game.controller.Player());
        e.get(game.logic.Character).animations = ["ghostUp", "ghostRight", "ghostDown", "ghostLeft"];
        e.get(game.logic.Character).fearAnimation = "ghostFear";
        return e;
    }

    static public function createPacman() {
        var e = new Entity();
        e.name = "pacman";
        e.add(new Sprite("pacmansheet", 21));
        e.get(Sprite).anims.play("pacman");
        e.add(new Transform());
        e.add(new game.logic.Character());
        e.add(new game.logic.Object(15, 15));
        e.add(new game.logic.Picker());
        e.add(new game.controller.Bot());
        e.add(new game.display.Rotate());
        e.get(game.logic.Character).speed = 10;
        return e;
    }
}
