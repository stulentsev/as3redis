package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.commands.base.KeyValueCommand;

import flash.utils.ByteArray;

public class CONFIG extends RedisCommand {
    public static var GET : String = 'GET';
    public static var RESETSTAT : String = 'RESETSTAT';
    public static var SET : String = 'SET';


    private var _subcommand : String;
    private var _parameters : Array;

    public function CONFIG(subcommand : String, args : Array = null) {
    }

    override public function get name():String {
        return "CONFIG";
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