package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class ECHO extends RedisCommand {
    protected var _text:String;
    protected var _response:String;

    public function ECHO(text:String) {
        _text = text;
    }

    override public function get name():String {
        return "ECHO";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _text);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _text + "]";
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _response = p;
        }
    }
}
}
