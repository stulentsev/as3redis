package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.commands.lists.LPUSH;

public class RPUSH extends LPUSH {
    public function RPUSH(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "RPUSH";
    }
}
}
