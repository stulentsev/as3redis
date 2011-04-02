package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.commands.base.SimpleCommand;

import flash.utils.ByteArray;

public class RANDOMKEY extends SimpleCommand {
    private var _response : String;

    public function RANDOMKEY() {
    }

    override public function get name():String {
        return "RANDOMKEY";
    }

    public function get result () : String {
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
