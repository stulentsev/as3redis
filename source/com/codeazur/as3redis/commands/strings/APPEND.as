package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class APPEND extends KeyValueCommand {
    public function APPEND(key : String, value : String) {
        super(key, value);
    }

    override public function get name() : String {
        return "APPEND";
    }
}
}
