package com.codeazur.as3redis.commands.lists {

public class BRPOP extends BLPOP {

    public function BRPOP(keys:Array, timeout:int = 0) {
        super(keys, timeout);
    }

    override public function get name():String {
        return "BRPOP";
    }

}
}
