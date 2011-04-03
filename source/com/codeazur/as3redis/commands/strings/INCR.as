package com.codeazur.as3redis.commands.strings {
public class INCR extends DECR {
    public function INCR(key:String) {
        super(key);
    }

    override public function get name():String {
        return "INCR";
    }
}
}
