package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class KeyCommand extends RedisCommand {
    protected var _key:String;

    public function KeyCommand(key:String) {
        _key = key;
    }

    public function get key() : String {
        return _key;
    }

//    override public function send(stream:IDataOutput):void {
//        stream.writeUTFBytes(name + " " + _key + "\r\n");
//        super.send(stream);
//    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + "]";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key);
    }
}
}