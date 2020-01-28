package game.logic;

import whiplash.math.*;

class Move {
    public var time:Float = 0.0;
    public var duration:Float;

    public var begin:Vector2;
    public var end:Vector2;

    public function new(begin, end, duration) {
        this.begin = begin;
        this.end = end;
        this.duration = duration;
    }
}
