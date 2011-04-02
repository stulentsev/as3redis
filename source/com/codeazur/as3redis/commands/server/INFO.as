package com.codeazur.as3redis.commands.server {
import com.codeazur.as3redis.commands.base.SimpleCommand;

import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class INFO extends SimpleCommand {
    public static const REDIS_VERSION:String = "redis_version";
    public static const UPTIME_IN_SECONDS:String = "uptime_in_seconds";
    public static const UPTIME_IN_DAYS:String = "uptime_in_days";
    public static const CONNECTED_CLIENTS:String = "connected_clients";
    public static const CONNECTED_SLAVES:String = "connected_slaves";
    public static const USED_MEMORY:String = "used_memory";
    public static const CHANGES_SINCE_LAST_SAVE:String = "changes_since_last_save";
    public static const BGSAVE_IN_PROGRESS:String = "bgsave_in_progress";
    public static const LAST_SAVE_TIME:String = "last_save_time";
    public static const TOTAL_CONNECTIONS_RECEIVED:String = "total_connections_received";
    public static const TOTAL_COMMANDS_PROCESSED:String = "total_commands_processed";
    public static const ROLE:String = "role";

    protected var _params:Dictionary;
    protected var _paramCount:uint = 0;

    public function INFO() {
        _params = new Dictionary();
    }

    override public function get result():* {
        return _params;
    }

    override public function get name():String {
        return "INFO";
    }

    override protected function processBulkResponse(response:ByteArray):void {
        _paramCount = 0;
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            var pa:Array = p.split("\r\n");
            for (var i:uint = 0; i < pa.length; i++) {
                var kv:Array = pa[i].split(":");
                if (kv.length == 2) {
                    _params[kv[0]] = kv[1];
                    _paramCount++;
                }
            }
        }
    }

    override public function toString():String {
        var t:String = (roundtrip == -1) ? "" : " (" + roundtrip + " ms)";
        var s:String = toStringCommand() + t;
        if (_params[ROLE]) {
            s += "\r  Role: " + _params[ROLE];
        }
        if (_params[REDIS_VERSION]) {
            s += "\r  RedisVersion: " + _params[REDIS_VERSION];
        }
        if (_params[USED_MEMORY]) {
            s += "\r  UsedMemory: " + _params[USED_MEMORY];
        }
        if (_params[UPTIME_IN_SECONDS]) {
            s += "\r  UptimeInSeconds: " + _params[UPTIME_IN_SECONDS];
        }
        if (_params[UPTIME_IN_DAYS]) {
            s += "\r  UptimeInDays: " + _params[UPTIME_IN_DAYS];
        }
        if (_params[CONNECTED_CLIENTS]) {
            s += "\r  ConnectedClients: " + _params[CONNECTED_CLIENTS];
        }
        if (_params[CONNECTED_SLAVES]) {
            s += "\r  ConnectedSlaves: " + _params[CONNECTED_SLAVES];
        }
        if (_params[LAST_SAVE_TIME]) {
            s += "\r  LastSaveTime: " + (new Date(parseFloat(_params[LAST_SAVE_TIME]) * 1000));
        }
        if (_params[CHANGES_SINCE_LAST_SAVE]) {
            s += "\r  ChangesSinceLastSave: " + _params[CHANGES_SINCE_LAST_SAVE];
        }
        if (_params[BGSAVE_IN_PROGRESS]) {
            s += "\r  BGSaveInProgress: " + _params[BGSAVE_IN_PROGRESS];
        }
        if (_params[TOTAL_CONNECTIONS_RECEIVED]) {
            s += "\r  TotalConnectionsReceived: " + _params[TOTAL_CONNECTIONS_RECEIVED];
        }
        if (_params[TOTAL_COMMANDS_PROCESSED]) {
            s += "\r  TotalCommandsProcessed: " + _params[TOTAL_COMMANDS_PROCESSED];
        }

        // TODO: add other fields
        return s;
    }
}
}
