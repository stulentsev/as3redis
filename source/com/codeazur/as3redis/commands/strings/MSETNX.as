package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.commands.strings.MSET;

import flash.utils.ByteArray;

public class MSETNX extends RedisCommand {
    protected var _keysAndValues:Array;

    public function MSETNX(keysAndValues : Array) {
        _keysAndValues = keysAndValues
    }

    override public function get name():String {
        return "MSETNX";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        if(_keysAndValues.length % 2 != 0) {
            throw new Error("There must be even number of arguments to MSET")
        }

        for each(var f : String in _keysAndValues) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }

    override public function toStringCommand():String {
        var s:String = "[" + name;
        s += " " + _keysAndValues.join(' ') + ' ';
        return s + "]";
    }

}
}