﻿package com.codeazur.as3redis.commands.sets {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class SDIFFSTORE extends RedisCommand {
    protected var _destinationKey:String;
    protected var _keys:Array;

    public function SDIFFSTORE(destinationKey:String, keys:Array) {
        _destinationKey = destinationKey;
        _keys = (keys == null) ? [] : keys;
    }

    override public function get name():String {
        return "SDIFFSTORE";
    }

    override public function send(stream:IDataOutput):void {
        stream.writeUTFBytes(name + " " + _destinationKey + " " + _keys.join(" ") + "\r\n");
        super.send(stream);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _destinationKey + " " + _keys.join(" ") + "]";
    }
}
}
