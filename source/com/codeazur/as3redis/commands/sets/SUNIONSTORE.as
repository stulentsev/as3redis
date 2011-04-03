package com.codeazur.as3redis.commands.sets {
public class SUNIONSTORE extends SDIFFSTORE {

    public function SUNIONSTORE(destinationKey:String, keys:Array) {
        super(destinationKey, keys);
    }

    override public function get name():String {
        return "SUNIONSTORE";
    }
}
}
