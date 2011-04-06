package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.ByteArray;

public class OBJECT extends RedisCommand {
    public static var REFCOUNT : String = 'REFCOUNT';
    public static var ENCODING : String = 'ENCODING';
    public static var IDLETIME : String = 'IDLETIME';


    private var _subcommand : String;
    private var _parameters : Array;

    public function OBJECT(subcommand : String, args : Array = null) {
    }

    override public function get name():String {
        return "OBJECT";
    }

    override protected function getUnifiedCommand() : ByteArray {
        var args : Array = [name, _subcommand];

        if(_parameters) {
            for each(var f : String in _parameters) {
                args.push(f);
            }
        }

        return serializeToUnified.apply(this, args);
    }

}
}