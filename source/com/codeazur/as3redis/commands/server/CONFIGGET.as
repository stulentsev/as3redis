package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class CONFIGGET extends KeyValueCommand {
    public function CONFIGGET(parameter : *) {
        super('GET', parameter)
    }

    override public function get name():String {
        return "CONFIG";
    }
}
}