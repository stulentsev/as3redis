package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class EXPIREAT extends KeyValueCommand {
    public function EXPIREAT(key:String, timestamp : uint) {
        super(key, timestamp);
    }

    override public function get name():String {
        return "EXPIREAT";
    }
}
}
