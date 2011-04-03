package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SDIFF extends RedisCommand {
    protected var _keys:Array;

    public function SDIFF(keys:Array) {
        _keys = (keys == null) ? [] : keys;
    }

    override public function get name():String {
        return "SDIFF";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var k : String in _keys) {
            args.push(k);
        }
        return serializeToUnified.apply(this, args);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _keys.join(" ") + "]";
    }
}
}
