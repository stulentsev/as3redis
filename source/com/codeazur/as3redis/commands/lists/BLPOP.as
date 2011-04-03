package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.ByteArray;

public class BLPOP extends RedisCommand {
    private var _keys : Array;
    private var _timeout : int;

    public function BLPOP(keys:Array, timeout:int = 0) {
        _keys = keys;
        _timeout = timeout;
    }

    override public function get name():String {
        return "BLPOP";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var f : String in _keys) {
            args.push(f);
        }
        args.push(_timeout);

        return serializeToUnified.apply(this, args);
    }

}
}
