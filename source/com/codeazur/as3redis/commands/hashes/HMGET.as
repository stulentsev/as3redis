/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HMGET extends KeyCommand {
    private var _fields : Array;
    private var _values : Array = [];

    public function HMGET(key : String, fields : Array) {
        super(key);
        _fields = fields;
    }

    override public function get name():String {
        return "HMGET";
    }

    public function get result() : Array {
        return _values;
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _values.push(p);
        }
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _key];
        for each(var f : String in _fields) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }
}
}
