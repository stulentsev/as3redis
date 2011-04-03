package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class KeyValueValueCommand extends RedisCommand {
    protected var _key:String;
    protected var _value:*;
    protected var _value2:*;

    public function KeyValueValueCommand(key:String, value:*, value2:*) {
        _key = key;
        _value = value;
        _value2 = value2;
    }

    public function get key() : String {
        return _key;
    }

    public function get value() : * {
        return _value;
    }

    public function get value2() : * {
        return _value2
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _value, _value2);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + toStringValue(_value) + " " + toStringValue(_value2) + "]";
    }

}
}