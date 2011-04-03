package com.codeazur.as3redis.commands.sets {
public class SUNION extends SDIFF {

    public function SUNION(keys:Array) {
        super(keys);
    }

    override public function get name():String {
        return "SUNION";
    }
}
}
