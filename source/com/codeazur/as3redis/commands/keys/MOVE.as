package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class MOVE extends RedisCommand {
    protected var _key:String;
    protected var _dbIndex:uint;

    public function MOVE(key:String, dbIndex:uint) {
        _key = key;
        _dbIndex = dbIndex;
    }

    override public function get name():String {
        return "MOVE";
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key,  _dbIndex);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _dbIndex + "]";
    }
}
}