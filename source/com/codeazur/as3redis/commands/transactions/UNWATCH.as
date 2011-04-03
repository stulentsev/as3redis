/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.transactions {
import com.codeazur.as3redis.commands.base.SimpleCommand;

public class UNWATCH extends SimpleCommand {
    public function UNWATCH() {
    }

    override public function get name() : String {
        return "UNWATCH";
    }
}
}
