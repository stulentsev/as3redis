/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {


import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class HINCRBY extends KeyValueValueCommand {
    public function HINCRBY(key : String, field : String, incr : int) {
        super(key, field, incr);
    }

    override public function get name():String {
        return "HINCRBY";
    }

    public function get increment() : * {
        return value2;
    }
}
}
