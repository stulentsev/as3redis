package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZRANGEBYSCORE extends KeyValueValueCommand {
    public function ZRANGEBYSCORE(key:String, minScore:Number, maxScore:Number) {
        super(key, minScore, maxScore);
    }

    override public function get name():String {
        return "ZRANGEBYSCORE";
    }
}
}