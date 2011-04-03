package com.codeazur.as3redis.commands.lists {
public class RPUSHX extends LPUSH {
    public function RPUSHX(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "RPUSHX";
    }
}
}
