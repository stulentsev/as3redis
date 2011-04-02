/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HGETALL extends KeyCommand {
    private var _keyValues : Object = null;

    private var _tempKey : String = null;

    public function HGETALL(key : String) {
        super(key);
    }

    override public function get result() : * {
        return _keyValues;
    }

    override public function get name():String {
        return "HGETALL";
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);

            if(_tempKey == null) {
                _tempKey = p;
            } else {
                if(_keyValues == null) {
                    _keyValues = {};
                }

                _keyValues[_tempKey] = p;
                _tempKey = null;
            }
        }
    }
}
}
