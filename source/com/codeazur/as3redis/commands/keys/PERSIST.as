package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class PERSIST extends KeyCommand {
    public function PERSIST(key:String) {
        super(key);
    }

    override public function get name():String {
        return "PERSIST";
    }
}
}
