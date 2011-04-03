package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class ZUNIONSTORE extends ZINTERSTORE {
    public function ZUNIONSTORE(destination : String,
            numKeys : int,
            keys : Array,
            weights : Array = null,
            aggregate : String = null) {
        super(destination, numKeys, keys, weights, aggregate);
    }

    override public function get name():String {
        return "ZUNIONSTORE";
    }
}
}