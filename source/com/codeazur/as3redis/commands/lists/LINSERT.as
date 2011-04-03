package com.codeazur.as3redis.commands.lists {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class LINSERT extends KeyValueValueCommand {
    private var _beforeOrAfter : String;

    public function LINSERT(key:String, beforeOrAfter:String, pivot:*, value:*) {
        super(key, pivot, value);
        _beforeOrAfter = beforeOrAfter;

        if(!beforeOrAfter) {
            throw new Error('Must specify BEFORE or AFTER for the second parameter.')
        }

        var caps : String = beforeOrAfter.toUpperCase();
        if(!(caps == 'BEFORE' || caps == 'AFTER')) {
            throw new Error('Must specify BEFORE or AFTER for the second parameter.')
        }
    }

    override public function get name():String {
        return "LINSERT";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, key, _beforeOrAfter, _value, _value2];

        return serializeToUnified.apply(this, args);
    }

}
}
