/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyFieldCommand;

public class HDEL extends KeyFieldCommand {
    public function HDEL(key : String, field : String) {
        super(key, field);
    }

    override public function get name():String {
        return "HDEL";
    }
}
}
