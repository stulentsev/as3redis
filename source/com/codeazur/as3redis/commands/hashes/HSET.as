/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HSET extends KeyFieldCommand {
    private var _value : * = null;

    public function HSET(key : String, field : String, value : *) {
        super(key, field);
        _value = value;
    }

    override public function get name():String {
        return "HSET";
    }

    public function get value() : * {
        return _value;
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _field, _value);
    }

}
}
