package com.codeazur.as3redis.commands.sorted_sets {

public class ZREVRANGE extends ZRANGE {
    public function ZREVRANGE(key:String, startIndex:int, endIndex:int, withScores : Boolean = false) {
        super(key, startIndex, endIndex, withScores);
    }

    override public function get name():String {
        return "ZREVRANGE";
    }
}
}