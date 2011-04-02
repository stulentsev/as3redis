package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class SETNX extends KeyValueCommand {
    public function SETNX(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "SETNX";
    }

}
}
