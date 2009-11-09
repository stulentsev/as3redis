﻿package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SDIFF extends RedisCommand
	{
		protected var _keys:Array;
		
		public function SDIFF(keys:Array)
		{
			_keys = (keys == null) ? [] : keys;
		}
		
		override public function get name():String {
			return "SDIFF";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _keys.join(" ") + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _keys.join(" ") + "]";
		}
	}
}
