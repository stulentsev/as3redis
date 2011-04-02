package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class SINTER extends SDIFF {

    public function SINTER(keys:Array) {
        super(keys);
    }

    override public function get name():String {
        return "SINTER";
    }
}
}
