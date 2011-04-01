package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

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

//    override public function send(stream:IDataOutput):void {
//        var baValue:ByteArray = serializeValue(_value);
//        stream.writeUTFBytes(name + " " + _key + " " + baValue.length + "\r\n");
//        stream.writeBytes(baValue);
//        stream.writeUTFBytes("\r\n");
//        super.send(stream);
//    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + toStringValue(_value) + "]";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _value);
    }
}
}