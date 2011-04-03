package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class GETRANGE extends KeyValueValueCommand {
    public function GETRANGE(key:String, start:*, end: *) {
        super(key, start, end);
    }

    override public function get name():String {
        return "GETRANGE";
    }

}
}
