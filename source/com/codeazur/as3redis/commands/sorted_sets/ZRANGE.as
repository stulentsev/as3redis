package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class ZRANGE extends RedisCommand {
    protected var _key:String;
    protected var _startIndex:int;
    protected var _endIndex:int;

    public function ZRANGE(key:String, startIndex:int, endIndex:int) {
        _key = key;
        _startIndex = startIndex;
        _endIndex = endIndex;
    }

    override public function get name():String {
        return "ZRANGE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _startIndex, _endIndex);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _startIndex + " " + _endIndex + "]";
    }
}
}