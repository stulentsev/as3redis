﻿package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class AUTH extends RedisCommand {
    protected var _password:String;

    public function AUTH(password:String) {
        _password = password;
    }

    override public function get name():String {
        return "AUTH";
    }

    override public function send(stream:IDataOutput):void {
        stream.writeUTFBytes(name + " " + _password + "\r\n");
        super.send(stream);
    }

    override public function toStringCommand():String {
        return "[" + name + " *****]";
    }
}
}
