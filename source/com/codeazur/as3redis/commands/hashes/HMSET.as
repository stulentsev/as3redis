/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HMSET extends KeyCommand {
    private var _keysAndValues : Array;

    public function HMSET(key : String, keysAndValues : Array) {
        super(key);
        _keysAndValues = keysAndValues;
    }

    override public function get name():String {
        return "HMSET";
    }

    public function get result() : String {
        return _responseMessage;
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _key];

        if(_keysAndValues.length % 2 != 0) {
            throw new Error("There must be even number of arguments to HMSET")
        }
        for each(var f : String in _keysAndValues) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }
}
}
