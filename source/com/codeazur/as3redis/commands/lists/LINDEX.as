package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.RedisCommand;

import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.IDataOutput;

public class LINDEX extends KeyValueCommand {

    public function LINDEX(key:String, index:int) {
        super(key, index);
    }

    override public function get name():String {
        return "LINDEX";
    }

    public function get result() : String {
        return firstResponseBulkAsString;
    }
}
}
