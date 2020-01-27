package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class ObjectNode extends Node<ObjectNode> {
    public var transform:Transform;
    public var object:Object;
}

class ObjectSystem extends ListIteratingSystem<ObjectNode> {
    private var engine:Engine;
    private var levelEntity:Entity;

    public function new() {
        super(ObjectNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        levelEntity = engine.getEntityByName("level");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:ObjectNode, dt:Float):Void {
        var object = node.object;
        var pos = object.position;
        var wpos = node.transform.position;

        wpos.x = (pos.x + 0.5) * Config.tileWidth;
        wpos.y = (pos.y + 0.5) * Config.tileHeight;
    }

    private function onNodeAdded(node:ObjectNode) {
    }

    private function onNodeRemoved(node:ObjectNode) {
    }
}


