/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.pubsub {
public class PSUBSCRIBE extends SUBSCRIBE {
    public function PSUBSCRIBE(patterns:Array) {
        super(patterns);
    }

    override public function get name():String {
        return "SUBSCRIBE";
    }

}

}
