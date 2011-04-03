/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class KeyFieldCommand extends RedisCommand {
    protected var _key:String;
    protected var _field:String;

    public function KeyFieldCommand(key:String, value:String) {
        _key = key;
        _field = value;
    }

    public function get key() : String {
        return _key;
    }

    public function get field() : String {
        return _field;
    }

    override public function toStringCommand():String {
        return "[" + name + " " + _key + " " + _field + "]";
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _field);
    }


}
}
