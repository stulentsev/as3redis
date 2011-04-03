package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class LPUSHX extends KeyValueCommand {
    public function LPUSHX(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "LPUSHX";
    }
}
}
