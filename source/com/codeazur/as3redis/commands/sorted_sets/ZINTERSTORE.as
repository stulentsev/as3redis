package com.codeazur.as3redis.commands.sorted_sets {
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.commands.base.KeyCommand;

import flash.utils.ByteArray;

public class ZINTERSTORE extends RedisCommand {
    private var _destination : String;
    private var _numKeys : int;
    private var _keys : Array;
    private var _weights : Array;
    private var _aggregate : String;

    public function ZINTERSTORE(destination : String,
            numKeys : int,
            keys : Array,
            weights : Array = null,
            aggregate : String = null) {
        _destination = destination;
        _numKeys = numKeys;
        _keys = keys;
        _weights = weights;
        _aggregate = aggregate;

        var upcased : String = aggregate.toUpperCase();
        if(aggregate && !(upcased == 'SUM' || upcased == 'MIN' || upcased == 'MAX')) {
            throw new Error("Aggregate must be one of [SUM, MIN, MAX]");
        }
    }

    override public function get name():String {
        return "ZINTERSTORE";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _destination, _numKeys];

        for each(var f : String in _keys) {
            args.push(f);
        }

        if(_weights) {
            for each(f in _weights) {
                args.push(f);
            }
        }

        if(_aggregate) {
            args.push('AGGREGATE');
            args.push(_aggregate.toUpperCase());
        }

        return serializeToUnified.apply(this, args);
    }

}
}