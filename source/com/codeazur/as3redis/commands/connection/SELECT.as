package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class SELECT extends RedisCommand {
    protected var _dbIndex:uint;

    public function SELECT(dbIndex:uint) {
        _dbIndex = dbIndex;
    }

    override public function get name():String {
        return "SELECT";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _dbIndex);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _dbIndex + "]";
    }
}
}