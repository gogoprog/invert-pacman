package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.math.*;
import game.logic.CharacterSystem;

class CollisionSystem extends ListIteratingSystem<CharacterNode> {
    private var engine:Engine;
    private var grid:Map<Int, Map<Int, Bool>>;
    private var pacman:Entity;
    private var pacmanPos:Vector2;
    private var pacmanPicker:game.logic.Picker;

    public function new() {
        super(CharacterNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        pacman = engine.getEntityByName("pacman");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        var collides = true;

        while(collides) {
            grid = new Map<Int, Map<Int, Bool>>();
            collides = false;

            for(node in nodeList) {
                var move = node.entity.get(Move);

                if(move == null) {
                    setGrid(node.object.position, true);
                }
            }

            for(node in nodeList) {
                var move = node.entity.get(Move);

                if(move != null) {
                    if(getGrid(move.end)) {
                        node.object.position = move.begin;
                        node.entity.remove(Move);
                        collides = true;
                        continue;
                    } else {
                        setGrid(move.end, true);
                    }
                }
            }
        }

        pacmanPicker = pacman.get(Picker);
        pacmanPos = pacman.get(Object).position;
        super.update(dt);
    }

    private function updateNode(node:CharacterNode, dt:Float):Void {
        if(node.entity.name != "pacman") {
            var pos = node.object.position;
            var distance = pacmanPos.getDistance(pos);

            if(distance < 1.42) {
                if(pacmanPicker.chasing) {
                    engine.removeEntity(node.entity);
                } else {
                    pacmanPos.set(15, 15);
                    Game.instance.increaseScore(100);
                }
            }
        }
    }

    private function onNodeAdded(node:CharacterNode) {
    }

    private function onNodeRemoved(node:CharacterNode) {
    }

    private function setGrid(pos:Vector2, value:Bool) {
        var x = Std.int(pos.x);
        var y = Std.int(pos.y);

        if(grid[x] == null) {
            grid[x] = new Map<Int, Bool>();
        }

        grid[x][y] = value;
    }

    private function getGrid(pos:Vector2):Bool {
        var x = Std.int(pos.x);
        var y = Std.int(pos.y);

        if(grid[x] == null) {
            return false;
        }

        return grid[x][y] == true;
    }
}


