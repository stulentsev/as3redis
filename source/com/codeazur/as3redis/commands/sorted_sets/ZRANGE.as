package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

public class ZRANGE extends KeyValueValueCommand {

    public function ZRANGE(key : String, startIndex : int, endIndex : int) {
        super(key, startIndex, endIndex);
    }

    override public function get name() : String {
        return "ZRANGE";
    }
}
}