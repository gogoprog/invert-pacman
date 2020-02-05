package game.logic;

import whiplash.math.*;

class Object {
    public var position:Vector2;
    public var moveTimeOffset:Float = 0;

    public function new(x, y) {
        position = new Vector2(x, y);
    }
}
