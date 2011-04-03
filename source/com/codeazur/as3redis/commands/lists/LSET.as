package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class LSET extends RedisCommand {
    protected var _key:String;
    protected var _index:int;
    protected var _value:*;

    public function LSET(key:String, index:int, value:*) {
        _key = key;
        _index = index;
        _value = value;
    }

    override public function get name():String {
        return "LSET";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _index, _value);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _index + " " + toStringValue(_value) + "]";
    }
}
}
