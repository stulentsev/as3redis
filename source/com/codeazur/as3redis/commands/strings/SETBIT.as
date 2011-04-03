package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class SETBIT extends KeyValueValueCommand {
    public function SETBIT(key:String, offset:*, value: *) {
        super(key, offset, value);
    }

    override public function get name():String {
        return "SETBIT";
    }

}
}
