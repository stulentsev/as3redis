package com.codeazur.as3redis.commands.keys {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class SORT extends RedisCommand {
    protected var _key:String;
    protected var _limitMin:int;
    protected var _limitMax:int;
    protected var _desc:Boolean;
    protected var _alpha:Boolean;
    protected var _byPattern:String;
    protected var _getPatterns:Array;
    protected var _storeToKey:String;

    private var _resultElements:Array;

    public function SORT(key:String,
                         limitMin:int = -1,
                         limitMax:int = -1,
                         desc:Boolean = false,
                         alpha:Boolean = false,
                         byPattern:String = null,
                         getPatterns:Array = null,
                         store:String = null) {
        _key = key;
        _limitMin = limitMin;
        _limitMax = limitMax;
        _desc = desc;
        _alpha = alpha;
        _byPattern = byPattern;
        _getPatterns = getPatterns;
        _storeToKey = store;
    }

    override public function get name():String {
        return "SORT";
    }

    override protected function getUnifiedCommand():ByteArray {
        var args:Array = [name, _key];
        if (_limitMin >= 0 && _limitMax >= 0) {
            args.push('LIMIT');
            args.push(_limitMin);
            args.push(_limitMax);
        } else if (!(_limitMin < 0 && _limitMax < 0)) {
            _limitMin = Math.max(0, _limitMin);
            _limitMax = Math.max(0, _limitMax);
            if (_limitMin < _limitMax) {
                args.push('LIMIT');
                args.push(_limitMin);
                args.push(_limitMax);
            } else if (_limitMin > _limitMax) {
                args.push('LIMIT');
                args.push(_limitMax);
                args.push(_limitMin);
            }
        }
        if (_desc) {
            args.push("DESC");
        }
        if (_alpha) {
            args.push("ALPHA");
        }
        if (_byPattern != null) {
            args.push("BY");
            args.push(_byPattern);
        }

        if (_getPatterns != null && _getPatterns.length > 0) {
            for each (var gp:String in _getPatterns) {
                args.push("GET");
                args.push(gp);
            }
        }

        if(_storeToKey != null) {
            args.push("STORE");
            args.push(_storeToKey);
        }

        return serializeToUnified.apply(this, args);
    }

    override protected function processBulkResponse(response:ByteArray):void {
        if (response && response.length > 0) {
            var p:String = response.readUTFBytes(response.length);
            _resultElements.push(p);
        }
    }

    override public function toStringCommand():String {
        var s:String = name + " " + _key;
        if (_limitMin >= 0 && _limitMax >= 0) {
            s += " LIMIT " + _limitMin + " " + _limitMax;
        } else if (!(_limitMin < 0 && _limitMax < 0)) {
            _limitMin = Math.max(0, _limitMin);
            _limitMax = Math.max(0, _limitMax);
            if (_limitMin < _limitMax) {
                s += " LIMIT " + _limitMin + " " + _limitMax;
            } else if (_limitMin > _limitMax) {
                s += " LIMIT " + _limitMax + " " + _limitMin;
            }
        }
        if (_desc) {
            s += " DESC";
        }
        if (_alpha) {
            s += " ALPHA";
        }
        if (_byPattern != null) {
            s += " BY " + _byPattern;
        }
        if (_getPatterns != null && _getPatterns.length > 0) {
            s += " GET " + _getPatterns.join(" GET ");
        }
        return "[" + s + "]";
    }
}
}
