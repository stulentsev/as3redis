/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class HVALS extends KeyCommand {

    public function HVALS(key : String) {
        super(key);
    }

    override public function get name() : String {
        return 'HVALS';
    }
}
}
