package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class GETBIT extends KeyValueCommand {
    public function GETBIT(key : String, offset : int) {
        super(key, offset);
    }

    override public function get name() : String {
        return "GETBIT";
    }
}
}
