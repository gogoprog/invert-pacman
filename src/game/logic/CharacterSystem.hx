package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class CharacterNode extends Node<CharacterNode> {
    public var character:Character;
    public var object:Object;
}

class CharacterSystem extends ListIteratingSystem<CharacterNode> {
    private var engine:Engine;
    private var levelEntity:Entity;
    private var tilemapLayer:TilemapLayer;

    public function new() {
        super(CharacterNode, updateNode, onNodeAdded, onNodeRemoved);
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

    private function updateNode(node:CharacterNode, dt:Float):Void {
        var character = node.character;

        if(character.requestedDirection != null) {
            if(node.entity.get(Move) == null) {
                var moveSystem = engine.getSystem(MoveSystem);
                var pos = MoveSystem.getPosition(node.object.position, character.requestedDirection);

                if(moveSystem.canMoveTo(pos)) {
                    node.entity.add(new Move(node.object.position, pos, 0.1));
                }
            }
        }
    }

    private function onNodeAdded(node:CharacterNode) {
    }

    private function onNodeRemoved(node:CharacterNode) {
    }
}


