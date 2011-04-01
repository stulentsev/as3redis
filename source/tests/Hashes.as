/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package tests {
import com.codeazur.as3redis.commands.hashes.*;
import com.codeazur.as3redis.commands.keys.DEL;

public class Hashes extends TestSuiteBase {


    public function Hashes(logger : Function) {
        super(logger);

        var fld1Exists : int = 0;

        var hk:String = 'hashes_test';

        redis.sendDEL([hk]);

        addTest('HEXISTS', [hk, 'fld1'], function(cmd : HEXISTS) : Boolean {
            fld1Exists = cmd.result;
            return true;
        });

        addTest('HDEL', [hk, 'fld1'], function(cmd : HDEL) : Boolean {
            return cmd.result == fld1Exists;
        });

        addTest('HSET', [hk, 'fld1', 1], function(cmd : HSET) : Boolean {
            // new field was set
            return cmd.result == 1;
        });

        addTest('HGET', [hk, 'fld1'], function(cmd : HGET) : Boolean {
            return cmd.result == '1';
        });

        addTest('HGET', [hk, 'not_exists'], function(cmd : HGET) : Boolean {
            return cmd.result == null;
        });

        addTest('HSET', [hk, 'fld1', 2], function(cmd : HSET) : Boolean {
            // existing field was updated
            return cmd.result == 0;
        });

        addTest('HSET', [hk, 'fld2', 0], function(cmd : HSET) : Boolean {
            // field did not exists and was set new value
            return cmd.result == 1;
        });

        addTest('HINCRBY', [hk, 'fld2', 2], function(cmd : HINCRBY) : Boolean {
            return cmd.result == 2;
        });

        addTest('HINCRBY', [hk, 'fld2', 5], function(cmd : HINCRBY) : Boolean {
            return cmd.result == 7;
        });

        addTest('HKEYS', [hk], function(cmd : HKEYS) : Boolean {
            var fields : Array = ['fld1', 'fld2'];
            return cmd.result.sort().join('') == fields.sort().join('');
        });

        addTest('HVALS', [hk], function(cmd : HVALS) : Boolean {
            var fields : Array = ['2', '7'];
            return cmd.result.sort().join('') == fields.sort().join('');
        });

        addTest('HLEN', [hk], function(cmd : HLEN) : Boolean {
            return cmd.result == 2;
        });

        addTest('HDEL', [hk, 'fld1'], function(cmd : HDEL) : Boolean {
            return cmd.result == 1;
        });

        addTest('HSETNX', [hk, 'fld1', 1], function(cmd : HSETNX) : Boolean {
            // field is a new field in the hash and value was set
            return cmd.result == 1;
        });

        addTest('HSETNX', [hk, 'fld1', 2], function(cmd : HSETNX) : Boolean {
            // field already exists in the hash and no operation was performed
            return cmd.result == 0;
        });

        addTest("HGETALL", [hk], function(cmd : HGETALL) : Boolean {
            var shouldBe : Object = {fld1 : '1',
                fld2 : '7'};

            for(var k1 : String in shouldBe) {
                if (shouldBe[k1] != cmd.result[k1])
                    return false;
            }
            return true;
        });

        addTest("HMGET", [hk, 'fld1', 'fld2'], function(cmd : HMGET): Boolean {
            var shouldBe : Array = ['1', '7'];
            return cmd.result.join('') == shouldBe.join('');
        });

        addTest("HMSET", [hk, 'fld1', 5, 'fld3', 6], function(cmd : HMSET): Boolean {
            return cmd.result == 'OK';
        });

        addTest("HGETALL", [hk], function(cmd : HGETALL) : Boolean {
            var shouldBe : Object = {fld1 : '5',
                fld2 : '7',
                fld3 : '6'
            };

            for(var k1 : String in shouldBe) {
                if (shouldBe[k1] != cmd.result[k1])
                    return false;
            }
            return true;
        });
    }
}
}
