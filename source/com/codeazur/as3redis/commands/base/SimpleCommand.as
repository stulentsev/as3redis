package com.codeazur.as3redis.commands.base {
import com.codeazur.as3redis.RedisCommand;

import flash.utils.ByteArray;

public class SimpleCommand extends RedisCommand {
    public function SimpleCommand() {
    }

    override protected function getUnifiedCommand() : ByteArray {
        return serializeToUnified(name);
    }
}
}