package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.commands.base.SimpleCommand;

public class BGREWRITEAOF extends SimpleCommand {
    public function BGREWRITEAOF() {
    }

    override public function get name():String {
        return "BGREWRITEAOF";
    }
}
}