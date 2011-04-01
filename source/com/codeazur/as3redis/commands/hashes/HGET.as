/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HGET extends KeyFieldCommand {
    private var _value : String = null;

    public function HGET(key : String, field : String) {
        super(key, field);
    }

    override public function get name():String {
        return "HGET";
    }

    public function get result() : * {
        return _value;
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _value = p;
        }
    }
}
}
