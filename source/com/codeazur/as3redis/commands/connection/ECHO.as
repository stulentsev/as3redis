package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class ECHO extends RedisCommand {
    protected var _text:String;

    public function ECHO(text:String) {
        _text = text;
    }

    override public function get name():String {
        return "ECHO";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _text);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _text + "]";
    }
}
}
