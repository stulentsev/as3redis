package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.ByteArray;

public class EXPIRE extends KeyValueCommand {

    public function EXPIRE(key:String, seconds:uint) {
        super(key, seconds);
    }

    override public function get name():String {
        return "EXPIRE";
    }
}
}
