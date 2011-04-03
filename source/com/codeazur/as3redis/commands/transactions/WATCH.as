/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.transactions {
import com.codeazur.as3redis.commands.base.SimpleCommand;

import flash.utils.ByteArray;

public class WATCH extends SimpleCommand {
    private var _keys : Array;
    public function WATCH(keys : Array) {
        _keys  = keys;
    }

    override public function get name() : String {
        return "WATCH";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name];
        for each(var f : String in _keys) {
            args.push(f);
        }

        return serializeToUnified.apply(this, args);
    }


}
}
