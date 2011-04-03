package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class ZADD extends RedisCommand {
    protected var _key:String;
    protected var _score:Number;
    protected var _value:*;

    public function ZADD(key:String, score:Number, value:*) {
        _key = key;
        _score = score;
        _value = value;
    }

    override public function get name():String {
        return "ZADD";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _score, _value);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _score + " " + toStringValue(_value) + "]";
    }
}
}