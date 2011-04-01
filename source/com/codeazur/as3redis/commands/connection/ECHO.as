﻿package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class ECHO extends RedisCommand {
    protected var _text:String;

    public function ECHO(text:String) {
        _text = text;
    }

    override public function get name():String {
        return "ECHO";
    }

    override public function send(stream:IDataOutput):void {
        var baText:ByteArray = new ByteArray();
        baText.writeUTFBytes(_text);
        stream.writeUTFBytes(name + " " + baText.length + "\r\n" + _text + "\r\n");
        super.send(stream);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _text + "]";
    }
}
}
