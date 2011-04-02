package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class LTRIM extends RedisCommand {
    protected var _key:String;
    protected var _startIndex:int;
    protected var _endIndex:int;

    public function LTRIM(key:String, startIndex:int, endIndex:int) {
        _key = key;
        _startIndex = startIndex;
        _endIndex = endIndex;
    }

    override public function get name():String {
        return "LTRIM";
    }
    public function get result() : String {
        return _responseMessage;
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _startIndex, _endIndex);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _startIndex + " " + _endIndex + "]";
    }
}
}
