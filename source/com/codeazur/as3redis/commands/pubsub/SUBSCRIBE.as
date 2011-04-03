/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.pubsub {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SUBSCRIBE extends RedisCommand {
    private var _channels : Array;

    public function SUBSCRIBE(channels : Array) {
        _channels = channels;
    }

    override public function get name():String {
        return "SUBSCRIBE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var f : String in _channels) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }
}
}
