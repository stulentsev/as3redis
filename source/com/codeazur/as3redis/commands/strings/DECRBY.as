package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class DECRBY extends KeyValueCommand {

    public function DECRBY(key:String, value:uint) {
        super(key, value);
    }

    override public function get name():String {
        return "DECRBY";
    }
    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _value + "]";
    }
}
}