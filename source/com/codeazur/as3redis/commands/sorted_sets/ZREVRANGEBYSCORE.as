package com.codeazur.as3redis.commands.sorted_sets {

public class ZREVRANGEBYSCORE extends ZRANGEBYSCORE {
    public function ZREVRANGEBYSCORE(key:String,
                                  minScore:String,
                                  maxScore:String,
                                  withScores:Boolean = false,
                                  offset : int = NaN,
                                  count : int = NaN
            ) {
        super(key, minScore, maxScore, withScores, offset, count);
    }

    override public function get name():String {
        return "ZREVRANGEBYSCORE";
    }
}
}