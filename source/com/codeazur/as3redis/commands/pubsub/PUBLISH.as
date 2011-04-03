/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.pubsub {
import com.codeazur.as3redis.commands.base.KeyValueCommand;

public class PUBLISH extends KeyValueCommand {
    public function PUBLISH(channel : String, message : String) {
        super(channel, message)
    }

    override public function get name():String {
        return "PUBLISH";
    }

}
}
