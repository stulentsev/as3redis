package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class RENAME extends RedisCommand {
    protected var _oldKey:String;
    protected var _newKey:String;

    public function RENAME(oldKey:String, newKey:String) {
        _oldKey = oldKey;
        _newKey = newKey;
    }

    override public function get name():String {
        return "RENAME";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _oldKey, _newKey);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _oldKey + " " + _newKey + "]";
    }
}
}
