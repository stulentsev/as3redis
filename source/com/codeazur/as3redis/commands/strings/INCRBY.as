package com.codeazur.as3redis.commands.strings {
public class INCRBY extends DECRBY {

    public function INCRBY(key:String, value:uint) {
        super(key, value);
    }

    override public function get name():String {
        return "INCRBY";
    }
}
}
