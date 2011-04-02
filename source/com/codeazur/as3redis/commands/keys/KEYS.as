﻿package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class KEYS extends RedisCommand {
    protected var _pattern:String;
    protected var _keys:Array;

    public function KEYS(pattern:String = '*') {
        _pattern = pattern;
        _keys = [];
    }

    override public function get name():String {
        return "KEYS";
    }


    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _pattern);
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
//            var pa:Array = p.split(" ");
//            for (var i:uint = 0; i < pa.length; i++) {
//                _keys.push(pa[i]);
//            }
            _keys.push(p);
        }
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _pattern + "]";
    }
}
}
