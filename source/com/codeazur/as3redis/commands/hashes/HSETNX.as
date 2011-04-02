/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class HSETNX extends HSET {
    public function HSETNX(key : String, field : String, value : *) {
        super(key, field, value);
    }

    override public function get name():String {
        return "HSETNX";
    }
}
}
