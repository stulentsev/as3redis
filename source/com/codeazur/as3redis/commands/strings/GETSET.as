package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.ByteArray;

public class GETSET extends KeyValueCommand {
    private var _response : String;

    public function GETSET(key:String, value:*) {
        super(key, value);
    }

    override public function get name():String {
        return "GETSET";
    }

    public function get result() : String {
        return _response;
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _response = p;
        }
    }

}
}
