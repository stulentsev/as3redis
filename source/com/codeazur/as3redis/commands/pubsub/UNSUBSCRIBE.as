/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.pubsub {
public class UNSUBSCRIBE extends SUBSCRIBE {
    public function UNSUBSCRIBE(channels : Array) {
        super(channels);
    }


    override public function get name():String {
        return "UNSUBSCRIBE";
    }

}
}
