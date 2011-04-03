package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class CONFIGRESETSTAT extends KeyCommand {
    public function CONFIGRESETSTAT() {
        super('RESETSTAT')
    }

    override public function get name():String {
        return "CONFIG";
    }
}
}