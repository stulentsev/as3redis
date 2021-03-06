package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZCOUNT extends KeyValueValueCommand {
    public function ZCOUNT(key:String, minScore:String, maxScore:String) {
        super(key, minScore, maxScore);
    }

    override public function get name():String {
        return "ZCOUNT";
    }
}
}