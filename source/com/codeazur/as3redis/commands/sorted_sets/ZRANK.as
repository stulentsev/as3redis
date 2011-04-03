package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class ZRANK extends KeyValueCommand {
    public function ZRANK(key:String, member:*) {
        super(key, member);
    }

    override public function get name():String {
        return "ZRANK";
    }
}
}