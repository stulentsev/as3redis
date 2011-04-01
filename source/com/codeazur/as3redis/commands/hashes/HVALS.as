/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import flash.utils.ByteArray;
import com.codeazur.as3redis.commands.base.KeyCommand;

public class HVALS extends KeyCommand {
    private var _values : Array = [];

    public function HVALS(key : String) {
        super(key);
    }

    override public function get name() : String {
        return 'HVALS';
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
}
}
