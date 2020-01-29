package game.controller;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;
import game.logic.Character;
import game.logic.Object;

class BotNode extends Node<BotNode> {
    public var character:Character;
    public var player:Bot;
    public var object:Object;
}

class BotSystem extends ListIteratingSystem<BotNode> {
    private var engine:Engine;

    public function new() {
        super(BotNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:BotNode, dt:Float):Void {

        if(node.entity.get(game.logic.Move) == null) {
            var dir:Int;
            var ncd = node.character.direction;
            var cdir = (ncd != null ? Type.enumIndex(ncd)  : - 1);

            do {
                dir = Std.random(4);
            } while(dir == (cdir + 2) % 4);

            node.character.requestedDirection = Type.createEnumIndex(game.logic.Direction, dir);
        }
    }

    private function onNodeAdded(node:BotNode) {
    }

    private function onNodeRemoved(node:BotNode) {
    }
}


