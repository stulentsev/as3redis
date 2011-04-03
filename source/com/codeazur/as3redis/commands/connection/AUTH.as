package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class AUTH extends RedisCommand {
    protected var _password:String;

    public function AUTH(password:String) {
        _password = password;
    }

    override public function get name():String {
        return "AUTH";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _password);
    }

    override public function toStringCommand():String {
        return "[" + name + " *****]";
    }
}
}
