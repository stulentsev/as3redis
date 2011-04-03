package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class BRPOPLPUSH extends KeyValueValueCommand {

    public function BRPOPLPUSH(source:String, destination:String, timeout:int) {
        super(source, destination, timeout);
    }

    override public function get name():String {
        return "BRPOPLPUSH";
    }
}
}
