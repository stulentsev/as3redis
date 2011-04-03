package com.codeazur.as3redis.commands.sets {
public class SINTER extends SDIFF {

    public function SINTER(keys:Array) {
        super(keys);
    }

    override public function get name():String {
        return "SINTER";
    }
}
}
