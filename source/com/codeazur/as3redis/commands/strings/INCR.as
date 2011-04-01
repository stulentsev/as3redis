package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class INCR extends KeyCommand {
    public function INCR(key:String) {
        super(key);
    }

    override public function get name():String {
        return "INCR";
    }
}
}
