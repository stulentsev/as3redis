package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class MGET extends RedisCommand {
    protected var _keys:Array;

    public function MGET(keys:Array) {
        _keys = keys;
    }

    override public function get name():String {
        return "MGET";
    }


    public function get result() : Array {
        return responseBulkAsStrings;
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var f : String in _keys) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }

    override public function toStringCommand():String {
        return "[" + name + ((_keys.length > 0) ? " " + _keys.join(" ") : "") + "]";
    }
}
}
