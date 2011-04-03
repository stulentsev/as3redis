package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class KeyValueCommand extends RedisCommand {
    protected var _key:String;
    protected var _value:*;

    public function KeyValueCommand(key:String, value:*) {
        _key = key;
        _value = value;
    }

    public function get key() : String {
        return _key;
    }

    public function get value() : * {
        return _value;
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _value);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + toStringValue(_value) + "]";
    }

}
}