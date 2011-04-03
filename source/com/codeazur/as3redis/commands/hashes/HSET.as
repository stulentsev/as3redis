/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {

import com.codeazur.as3redis.commands.base.KeyValueValueCommand;
public class HSET extends KeyValueValueCommand {

    public function HSET(key : String, field : String, value : *) {
        super(key, field, value);
        _value = value;
    }

    override public function get name():String {
        return "HSET";
    }
}
}
