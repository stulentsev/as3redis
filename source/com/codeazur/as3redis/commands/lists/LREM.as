package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class LREM extends RedisCommand {
    protected var _key:String;
    protected var _count:int;
    protected var _value:*;

    public function LREM(key:String, count:int, value:*) {
        _key = key;
        _count = count;
        _value = value;
    }

    override public function get name():String {
        return "LREM";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _count, _value);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _count + " " + toStringValue(_value) + "]";
    }
}
}
