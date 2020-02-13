package game.display;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import game.logic.Character;

class CharacterAnimationNode extends Node<CharacterAnimationNode> {
    public var character:Character;
    public var sprite:Sprite;
}

class CharacterAnimationSystem extends ListIteratingSystem<CharacterAnimationNode> {
    private var engine:Engine;

    public function new() {
        super(CharacterAnimationNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:CharacterAnimationNode, dt:Float):Void {
        var character = node.character;

        if(character.animations != null) {
            if(node.entity.get(game.logic.Move) == null) {
                // node.sprite.anims.stop();
            } else {
                var direction = character.direction;

                if(direction != null) {
                    var n =  Type.enumIndex(direction);
                    var anim = character.animations[n];

                    if(node.sprite.anims.getCurrentKey() != anim) {
                        node.sprite.anims.play(anim);
                    }
                }
            }
        }
    }

    private function onNodeAdded(node:CharacterAnimationNode) {
    }

    private function onNodeRemoved(node:CharacterAnimationNode) {
    }
}


