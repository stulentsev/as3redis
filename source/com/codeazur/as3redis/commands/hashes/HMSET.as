/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HMSET extends KeyCommand {
    private var _fields : Array;

    public function HMSET(key : String, fields : Array) {
        super(key);
        _fields = fields;
    }

    override public function get name():String {
        return "HMSET";
    }

    public function get result() : String {
        return _responseMessage;
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
