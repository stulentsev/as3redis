/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;

public class HINCRBY extends KeyFieldCommand {
    private var _increment : int = 0;

    public function HINCRBY(key : String, field : String, incr : int) {
        super(key, field);
        _increment = incr;
    }

    override public function get name():String {
        return "HINCRBY";
    }

    public function get increment() : * {
        return _increment;
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name, _key, _field, _increment);
    }

}
}
