﻿package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class SREM extends KeyValueCommand {
    public function SREM(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "SREM";
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }
}
}
