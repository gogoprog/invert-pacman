package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class PickerNode extends Node<PickerNode> {
    public var transform:Transform;
    public var picker:Picker;
    public var object:Object;
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
                tilemapLayer.removeTileAt(Std.int(pos.x), Std.int(pos.y));
            }
        }
    }

    private function onNodeAdded(node:PickerNode) {
    }

    private function onNodeRemoved(node:PickerNode) {
    }
}


