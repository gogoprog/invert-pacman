package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class MoveNode extends Node<MoveNode> {
    public var object:Object;
    public var move:Move;
}

class MoveSystem extends ListIteratingSystem<MoveNode> {
    private var engine:Engine;

    public function new() {
        super(MoveNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:MoveNode, dt:Float):Void {
        var move = node.move;

        move.time += dt;

        var f = Math.min(move.time / move.duration, 1);

        node.object.position = move.begin + (move.end - move.begin) * f;

        if(f==1) {
            node.entity.remove(Move);
        }
    }

    private function onNodeAdded(node:MoveNode) {
    }

    private function onNodeRemoved(node:MoveNode) {
    }
}


