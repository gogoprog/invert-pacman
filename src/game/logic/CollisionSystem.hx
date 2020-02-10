package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.math.*;

class CollisionNode extends Node<CollisionNode> {
    public var object:Object;
}

class CollisionSystem extends ListIteratingSystem<CollisionNode> {
    private var engine:Engine;
    private var grid:Map<Int, Map<Int, Bool>>;

    public function new() {
        super(CollisionNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        grid = new Map<Int, Map<Int, Bool>>();
        var collides = true;

        while(collides) {
            collides = false;

            for(node in nodeList) {
                var move = node.entity.get(Move);

                if(move != null) {
                    if(getGrid(move.end)) {
                        node.object.position = move.begin;
                        node.entity.remove(Move);
                        collides = true;
                    } else {
                        setGrid(move.end, true);
                    }
                } else {
                    setGrid(node.object.position, true);
                }
            }
        }
    }

    private function updateNode(node:CollisionNode, dt:Float):Void {
    }

    private function onNodeAdded(node:CollisionNode) {
    }

    private function onNodeRemoved(node:CollisionNode) {
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


