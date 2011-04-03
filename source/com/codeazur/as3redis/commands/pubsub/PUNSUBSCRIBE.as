/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.pubsub {
public class PUNSUBSCRIBE extends SUBSCRIBE {
    public function PUNSUBSCRIBE(patterns : Array) {
        super(patterns);
    }


    override public function get name():String {
        return "PUNSUBSCRIBE";
    }

}
}
