package game.controller;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;
import game.logic.Character;
import game.logic.Object;

class PlayerNode extends Node<PlayerNode> {
    public var character:Character;
    public var player:Player;
    public var object:Object;
}

class PlayerSystem extends ListIteratingSystem<PlayerNode> {
    private var engine:Engine;

    public function new() {
        super(PlayerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:PlayerNode, dt:Float):Void {
        var attemptedDirection:game.logic.Direction = null;
        var keys = whiplash.Input.keys;

        if(keys["ArrowLeft"] || keys["a"]) {
            attemptedDirection = West;
        } else if(keys["ArrowRight"] || keys["d"]) {
            attemptedDirection = East;
        } else if(keys["ArrowUp"] || keys["w"]) {
            attemptedDirection = North;
        } else if(keys["ArrowDown"] || keys["s"]) {
            attemptedDirection = South;
        } else {
            // node.character.requestedDirection = null;
        }

        if(attemptedDirection != null) {
            var pos:Vector2;
            var move = node.entity.get(game.logic.Move);

            if(move != null) {
                pos = move.end;
            } else {
                pos = node.object.position;
            }

            var moveSystem = engine.getSystem(game.logic.MoveSystem);
            var newPos = game.logic.MoveSystem.getPosition(pos, attemptedDirection);

            if(moveSystem.canMoveTo(newPos)) {
                node.character.requestedDirection = attemptedDirection;
            }
        }
    }

    private function onNodeAdded(node:PlayerNode) {
    }

    private function onNodeRemoved(node:PlayerNode) {
    }
}


