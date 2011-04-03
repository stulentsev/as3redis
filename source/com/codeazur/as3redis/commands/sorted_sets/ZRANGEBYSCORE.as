package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class ZRANGEBYSCORE extends RedisCommand {
    private var _key : String;
    private var _minScore : String;
    private var _maxScore : String;
    private var _withScores : Boolean = false;
    private var _offset : int;
    private var _count : int;

    public function ZRANGEBYSCORE(key:String,
                                  minScore:String,
                                  maxScore:String,
                                  withScores:Boolean = false,
                                  offset : int = NaN,
                                  count : int = NaN
            ) {
        _key = key;
        _minScore = minScore;
        _maxScore = maxScore;
        _withScores = withScores;
        _offset = offset;
        _count = count;
    }

    override public function get name():String {
        return "ZRANGEBYSCORE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _key, _minScore, _maxScore];

        if(_withScores) {
            args.push("WITHSCORES");
        }

        if(_offset != NaN && _count != NaN) {
            args.push('LIMIT');
            args.push(_offset);
            args.push(_count);
        }

        return serializeToUnified.apply(this, args);
    }

}
}