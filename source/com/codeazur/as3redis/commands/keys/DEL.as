package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class DEL extends RedisCommand {
    protected var _keys:Array;

    public function DEL(keys:Array) {
        _keys = keys;
    }

    override public function get name():String {
        return "DEL";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var k : String in _keys) {
            args.push(k);
        }

        return serializeToUnified.apply(this, args);
    }

    override public function toStringCommand():String {
        return "[" + name + ((_keys.length > 0) ? " " + _keys.join(" ") : "") + "]";
    }
}
}
