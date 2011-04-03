/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
public class HSETNX extends HSET {
    public function HSETNX(key : String, field : String, value : *) {
        super(key, field, value);
    }

    override public function get name():String {
        return "HSETNX";
    }
}
}
