package com.codeazur.as3redis.commands.connection {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.IDataOutput;

public class SELECT extends RedisCommand {
    protected var _dbIndex:uint;

    public function SELECT(dbIndex:uint) {
        _dbIndex = dbIndex;
    }

    override public function get name():String {
        return "SELECT";
    }

    override public function send(stream:IDataOutput):void {
        stream.writeUTFBytes(name + " " + _dbIndex + "\r\n");
        super.send(stream);
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _dbIndex + "]";
    }
}
}