package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZINCRBY extends KeyValueValueCommand {
    public function ZINCRBY(key:String, increment:Number, member:Number) {
        super(key, increment, member);
    }

    override public function get name():String {
        return "ZINCRBY";
    }
}
}