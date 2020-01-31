package game.display;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import game.logic.Character;

class RotateNode extends Node<RotateNode> {
    public var transform:Transform;
    public var rotate:Rotate;
    public var character:Character;
}

class RotateSystem extends ListIteratingSystem<RotateNode> {
    private var engine:Engine;

    public function new() {
        super(RotateNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:RotateNode, dt:Float):Void {
        switch(node.character.direction) {
            case North: node.transform.rotation = -90;

            case East: node.transform.rotation = 0;

            case South: node.transform.rotation = 90;

            case West: node.transform.rotation = 180;
        }
    }

    private function onNodeAdded(node:RotateNode) {
    }

    private function onNodeRemoved(node:RotateNode) {
    }
}


