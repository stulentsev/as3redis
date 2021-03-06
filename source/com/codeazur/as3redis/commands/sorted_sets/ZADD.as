package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZADD extends KeyValueValueCommand {
    public function ZADD(key:String, score:Number, value:*) {
        super(key, score, value);
    }

    override public function get name():String {
        return "ZADD";
    }
}
}