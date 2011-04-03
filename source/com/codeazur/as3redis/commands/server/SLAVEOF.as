package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SLAVEOF extends RedisCommand {
    protected var _host:String;
    protected var _port:int;

    public function SLAVEOF(host:String = null, port:int = -1) {
        _host = host;
        _port = port;
    }

    override public function get name():String {
        return "SLAVEOF";
    }

    override protected function getUnifiedCommand() : ByteArray {
        if (_host != null && _host.length > 0 && _port >= 0) {
            return serializeToUnified(name, _host,  _port);
        } else if (_host == null && _port < 0) {
            return serializeToUnified(name, "no", "one");
        } else {
            throw(new Error("Host and port must both either be valid or null/-1"));
        }
    }

    override public function toStringCommand():String {
        if (_host != null && _host.length > 0 && _port >= 0) {
            return "[" + name + " " + _host + " " + _port + "]";
        } else if (_host == null && _port < 0) {
            return "[" + name + " no one]";
        } else {
            return "[" + name + "] INVALID ARGUMENTS";
        }
    }
}
}