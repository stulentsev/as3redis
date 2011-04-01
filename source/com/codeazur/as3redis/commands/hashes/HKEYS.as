/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import flash.utils.ByteArray;
import com.codeazur.as3redis.commands.base.KeyCommand;

public class HKEYS extends KeyCommand {
    private var _keys : Array = [];

    public function HKEYS(key : String) {
        super(key);
    }

    override public function get name() : String {
        return 'HKEYS';
    }

    public function get result() : Array {
        return _keys;
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _keys.push(p);
        }
    }
}
}
