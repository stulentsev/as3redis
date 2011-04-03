package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class EXPIRE extends RedisCommand {
    protected var _key:String;
    protected var _seconds:uint;

    public function EXPIRE(key:String, seconds:uint) {
        _key = key;
        _seconds = seconds;
    }

    override public function get name():String {
        return "EXPIRE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _seconds);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _seconds + "]";
    }
}
}
