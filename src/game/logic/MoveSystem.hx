package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class MoveNode extends Node<MoveNode> {
    public var object:Object;
    public var move:Move;
}

class MoveSystem extends ListIteratingSystem<MoveNode> {
    private var engine:Engine;
    private var levelEntity:Entity;
    private var tilemapLayer:TilemapLayer;

    public function new() {
        super(MoveNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        levelEntity = engine.getEntityByName("level");
        tilemapLayer = levelEntity.get(TilemapLayer);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    static public function getPosition(from:Vector2, direction:Direction) {
        var delta = new Vector2(0, 0);

        switch(direction) {
            case North: delta.y = -1;

            case East: delta.x = 1;

            case South: delta.y = 1;

            case West: delta.x = -1;
        }

        return from + delta;
    }

    public function canMoveTo(pos:Vector2) {
        var tile = tilemapLayer.getTileAt(Std.int(pos.x), Std.int(pos.y));

        if(tile == null) {
            return true;
        } else {
            if(tile.properties != null) {
                return tile.properties.crossable;
            }
        }

        return false;
    }

    private function updateNode(node:MoveNode, dt:Float):Void {
        var move = node.move;

        move.time += dt;

        var f = move.time / move.duration;

        if(f >= 1) {
            node.object.moveTimeOffset = move.time - move.duration;
            f = 1;
        }

        node.object.position = move.begin + (move.end - move.begin) * f;

        if(f == 1) {
            node.entity.remove(Move);
        }
    }

    private function onNodeAdded(node:MoveNode) {
        node.move.time = node.object.moveTimeOffset;
    }

    private function onNodeRemoved(node:MoveNode) {
    }

}


