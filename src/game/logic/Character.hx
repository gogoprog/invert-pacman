package game.logic;

class Character {
    public var requestedDirection:Direction;
    public var direction:Direction = East;
    public var speed:Float = 10;
    public var animations:Array<String>;

    public function new() {
    }
}
