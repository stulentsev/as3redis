package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class SINTERSTORE extends SDIFFSTORE {
    public function SINTERSTORE(destinationKey:String, keys:Array) {
        super(destinationKey, keys);
    }

    override public function get name():String {
        return "SINTERSTORE";
    }
}
}
