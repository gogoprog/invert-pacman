package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class PickerNode extends Node<PickerNode> {
    public var transform:Transform;
    public var picker:Picker;
    public var object:Object;
    public var character:Character;
}

class PickerSystem extends ListIteratingSystem<PickerNode> {
    private var engine:Engine;
    private var tilemapLayer:TilemapLayer;

    public function new() {
        super(PickerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        tilemapLayer = engine.getEntityByName("items").get(TilemapLayer);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:PickerNode, dt:Float):Void {
        if(node.entity.get(Move) == null) {
            var pos = node.object.position;
            var tile = tilemapLayer.getTileAt(Std.int(pos.x), Std.int(pos.y));

            if(tile != null) {
                if(tile.properties != null && tile.properties.mega) {
                    Game.instance.increaseScore(-100);
                    node.picker.chasing = true;
                    node.picker.time = 10;
                    node.character.speed = 15;
                } else {
                    Game.instance.increaseScore(-10);
                }

                tilemapLayer.removeTileAt(Std.int(pos.x), Std.int(pos.y));
            }
        }

        var picker = node.picker;

        if(picker.chasing) {
            picker.time -= dt;

            if(picker.time <= 0) {
                node.picker.chasing = false;
                node.character.speed = 10;
            }
        }
    }

    private function onNodeAdded(node:PickerNode) {
    }

    private function onNodeRemoved(node:PickerNode) {
    }
}


