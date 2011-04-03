package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SDIFFSTORE extends RedisCommand {
    protected var _destinationKey:String;
    protected var _keys:Array;

    public function SDIFFSTORE(destinationKey:String, keys:Array) {
        _destinationKey = destinationKey;
        _keys = (keys == null) ? [] : keys;
    }

    override public function get name():String {
        return "SDIFFSTORE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _destinationKey];
        for each(var k : String in _keys) {
            args.push(k);
        }
        return serializeToUnified.apply(this, args);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _destinationKey + " " + _keys.join(" ") + "]";
    }
}
}
