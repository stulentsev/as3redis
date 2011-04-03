/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package tests {
import com.codeazur.as3redis.Redis;
import com.codeazur.as3redis.RedisCommand;
import com.codeazur.as3redis.RedisResponder;

import flash.events.Event;
import flash.events.EventDispatcher;

public class TestSuiteBase extends EventDispatcher {
    private var _logger : Function;
    private var _redis : Redis;
    private var _tests : Array;

    private var _currentTestIndex : int = -1;
    private var _currentValidator : Function;
    private var _currentArgs : Array;

    public function TestSuiteBase(logger : Function, red : Redis = null) {
        _logger = logger;
        _redis = red || new Redis();
        _tests = [];
    }


    protected function get logger():Function {
        return _logger;
    }

    public function get redis():Redis {
        return _redis;
    }

    protected function addTest(redisCmd : String, args : Array, validator : Function) : void {
        _tests.push([redisCmd, args, validator]);
    }

    private function okResponder(cmd : RedisCommand) : void {
        if(_currentValidator != null && !_currentValidator(cmd)) {
            logger('');
            logger('');
            logger("FAIL: " + cmd.name);
            logger('params: ' + buildParamsString(_currentArgs));
            logger('result: ' + cmd['result']);
            logger('');
            logger('');
        } else {
            logger("ok: " + cmd.name.toLowerCase());
        }
        runNextTest();
    }

    private function buildParamsString(args:Array):String {
        return args.join(', ');
    }

    private function errorResponder(cmd : RedisCommand) : void {
        logger("ERROR: " + cmd.name);
        runNextTest();
    }

    public function runTests() : void {
        _currentTestIndex = -1;
        runNextTest();
    }

    private function runNextTest():void {
        if(_currentTestIndex + 1 < _tests.length) {
            _currentTestIndex += 1;

            var arr : Array = _tests[_currentTestIndex];
            var cmdName : String = arr[0];
            _currentArgs = arr[1];
            _currentValidator = arr[2];

            var libMethod : Function = _redis['send' + cmdName.toUpperCase()];
            var cmd : RedisCommand = libMethod.apply(_redis, _currentArgs) as RedisCommand;

            cmd.addResponder(new RedisResponder(okResponder, errorResponder));
        } else {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

}
}
