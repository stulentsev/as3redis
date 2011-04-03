/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.transactions {
import com.codeazur.as3redis.commands.base.SimpleCommand;

public class EXEC extends SimpleCommand {
    public function EXEC() {
    }

    override public function get name() : String {
        return "EXEC";
    }
}
}
