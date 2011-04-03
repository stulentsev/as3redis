package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class SETEX extends KeyValueValueCommand {
    public function SETEX(key:String, seconds:*, value: *) {
        super(key, seconds, value);
    }

    override public function get name():String {
        return "SETEX";
    }

}
}
