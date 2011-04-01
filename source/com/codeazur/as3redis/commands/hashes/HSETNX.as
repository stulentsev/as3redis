/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HSETNX extends KeyFieldCommand {
    private var _value : * = null;

    public function HSETNX(key : String, field : String, value : *) {
        super(key, field);
        _value = value;
    }

    override public function get name():String {
        return "HSETNX";
    }

    public function get value() : * {
        return _value;
    }

    public function get result() : int {
        if(_responseType == RESPONSE_TYPE_INTEGER) {
            return parseInt(_responseMessage)
        } else {
            throw new Error('response type for HSETNX must be integer');
        }
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _field, _value);
    }

}
}
