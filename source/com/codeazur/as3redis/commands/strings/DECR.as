package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class DECR extends KeyCommand {
    public function DECR(key:String) {
        super(key);
    }

    override public function get name():String {
        return "DECR";
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }
}
}
