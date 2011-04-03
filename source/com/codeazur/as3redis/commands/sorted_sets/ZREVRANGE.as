package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class ZREVRANGE extends KeyValueValueCommand {
    public function ZREVRANGE(key:String, startIndex:int, endIndex:int) {
        super(key, startIndex, endIndex);
    }

    override public function get name():String {
        return "ZREVRANGE";
    }
}
}