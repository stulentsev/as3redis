/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HEXISTS extends KeyFieldCommand {
    public function HEXISTS(key : String, field : String) {
        super(key, field);
    }

    override public function get name():String {
        return "HEXISTS";
    }

    public function get result() : int {
        return parseInt(_responseMessage);
    }
}
}
