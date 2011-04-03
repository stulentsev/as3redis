package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZREMRANGEBYRANK extends KeyValueValueCommand {
    public function ZREMRANGEBYRANK(key:String, start:Number, stop:Number) {
        super(key, start, stop);
    }

    override public function get name():String {
        return "ZREMRANGEBYRANK";
    }
}
}