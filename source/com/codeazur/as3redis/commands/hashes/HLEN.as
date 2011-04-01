/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package com.codeazur.as3redis.commands.hashes {
import flash.utils.ByteArray;
import com.codeazur.as3redis.commands.base.KeyCommand;

public class HLEN extends KeyCommand {

    public function HLEN(key : String) {
        super(key);
    }

    override public function get name() : String {
        return 'HLEN';
    }

    public function get result() : int {
        if(_responseType == RESPONSE_TYPE_INTEGER) {
            return parseInt(_responseMessage)
        } else {
            throw new Error('response type for HLEN must be integer');
        }
    }

}
}
