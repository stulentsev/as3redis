package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class ZRANGEBYSCORE extends RedisCommand {
    protected var _key:String;
    protected var _minScore:Number;
    protected var _maxScore:Number;

    public function ZRANGEBYSCORE(key:String, minScore:Number, maxScore:Number) {
        _key = key;
        _minScore = minScore;
        _maxScore = maxScore;
    }

    override public function get name():String {
        return "ZRANGEBYSCORE";
    }

    override protected function getUnifiedCommand():ByteArray {
        return serializeToUnified(name, _key, _minScore, _maxScore);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _minScore + " " + _maxScore + "]";
    }
}
}