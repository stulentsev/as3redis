package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SMOVE extends RedisCommand {
    protected var _sourceKey:String;
    protected var _destinationKey:String;
    protected var _value:*;

    public function SMOVE(sourceKey:String, destinationKey:String, value:*) {
        _sourceKey = sourceKey;
        _destinationKey = destinationKey;
        _value = value;
    }

    override public function get name():String {
        return "SMOVE";
    }

    override protected function getUnifiedCommand() :ByteArray {
        return serializeToUnified(name, _sourceKey, _destinationKey, _value);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _sourceKey + " " + _destinationKey + " " + toStringValue(_value) + "]";
    }
}
}
