package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.commands.base.KeyValueValueCommand;

import flash.utils.ByteArray;

public class ZRANGE extends KeyValueValueCommand {
    private var _withScores : Boolean = false;

    public function ZRANGE(key : String, startIndex : int, endIndex : int, withScores : Boolean = false) {
        super(key, startIndex, endIndex);
        _withScores = withScores;
    }

    override public function get name() : String {
        return "ZRANGE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _key, value, value2];

        if(_withScores) {
            args.push("WITHSCORES");
        }

        return serializeToUnified.apply(this, args);
    }

}
}