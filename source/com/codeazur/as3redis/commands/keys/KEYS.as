package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class KEYS extends RedisCommand {
    protected var _pattern:String;

    public function KEYS(pattern:String = '*') {
        _pattern = pattern;
    }

    override public function get name():String {
        return "KEYS";
    }


    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _pattern);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _pattern + "]";
    }
}
}
