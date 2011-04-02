package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class SUNIONSTORE extends SDIFFSTORE {

    public function SUNIONSTORE(destinationKey:String, keys:Array) {
        super(destinationKey, keys);
    }

    override public function get name():String {
        return "SUNIONSTORE";
    }
}
}
