﻿package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class MGET extends RedisCommand {
    protected var _keys:Array;

    public function MGET(keys:Array) {
        _keys = keys;
    }

    override public function get name():String {
        return "MGET";
    }

    override public function send(stream:IDataOutput):void {
        var cmd:String = name;
        for (var i:uint = 0; i < _keys.length; i++) {
            cmd += " " + _keys[i];
        }
        cmd += "\r\n";
        stream.writeUTFBytes(cmd);
        super.send(stream);
    }

    override public function toStringCommand():String {
        return "[" + name + ((_keys.length > 0) ? " " + _keys.join(" ") : "") + "]";
    }
}
}
