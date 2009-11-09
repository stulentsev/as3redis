﻿package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SMEMBERS extends RedisCommand
	{
		protected var _key:String;
		
		public function SMEMBERS(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "SMEMBERS";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}