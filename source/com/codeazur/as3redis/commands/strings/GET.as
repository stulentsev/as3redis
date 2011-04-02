package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;

public class GET extends KeyCommand {
    private var _response : String;
    public function GET(key:String) {
        super(key);
    }

    override public function get name():String {
        return "GET";
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
