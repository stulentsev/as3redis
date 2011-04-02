package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class GET extends KeyCommand {
    public function GET(key:String) {
        super(key);
    }

    override public function get name():String {
        return "GET";
    }

    public function get result() : String {
        return firstResponseBulkAsString;
    }

}
}
