package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class CONFIGSET extends KeyValueValueCommand {
    public function CONFIGSET(parameter: String, value : *) {
        super('SET', parameter, value)
    }

    override public function get name():String {
        return "CONFIG";
    }
}
}