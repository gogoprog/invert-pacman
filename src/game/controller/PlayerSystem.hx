package game.controller;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import game.logic.Character;

class PlayerNode extends Node<PlayerNode> {
    public var character:Character;
    public var player:Player;
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
        if(whiplash.Input.keys["ArrowLeft"]) {
            node.character.requestedDirection = West;
        } else if(whiplash.Input.keys["ArrowRight"]) {
            node.character.requestedDirection = East;
        } else if(whiplash.Input.keys["ArrowUp"]) {
            node.character.requestedDirection = North;
        } else if(whiplash.Input.keys["ArrowDown"]) {
            node.character.requestedDirection = South;
        } else {
            node.character.requestedDirection = null;
        }
    }

    private function onNodeAdded(node:PlayerNode) {
    }

    private function onNodeRemoved(node:PlayerNode) {
    }
}


