package com.codeazur.as3redis.commands.strings {
import com.codeazur.as3redis.commands.base.KeyCommand;

public class STRLEN extends KeyCommand {
    public function STRLEN(key:String) {
        super(key);
    }

    override public function get name():String {
        return "STRLEN";
    }

}
}
