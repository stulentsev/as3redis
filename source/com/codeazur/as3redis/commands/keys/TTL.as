package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class TTL extends KeyCommand {
    public function TTL(key:String) {
        super(key);
    }

    override public function get name():String {
        return "TTL";
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }
}
}
