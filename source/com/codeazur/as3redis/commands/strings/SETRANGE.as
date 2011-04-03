package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class SETRANGE extends KeyValueValueCommand {
    public function SETRANGE(key:String, offset:int, value: String) {
        super(key, offset, value);
    }

    override public function get name():String {
        return "SETRANGE";
    }

}
}
