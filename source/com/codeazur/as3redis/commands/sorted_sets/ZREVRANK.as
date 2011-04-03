package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class ZREVRANK extends KeyValueCommand {
    public function ZREVRANK(key:String, member:*) {
        super(key, member);
    }

    override public function get name():String {
        return "ZREVRANK";
    }
}
}