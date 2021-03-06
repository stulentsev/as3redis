﻿package com.codeazur.as3redis {
import com.codeazur.as3redis.commands.connection.*;
import com.codeazur.as3redis.commands.hashes.*;
import com.codeazur.as3redis.commands.keys.*;
import com.codeazur.as3redis.commands.lists.*;
import com.codeazur.as3redis.commands.pubsub.*;
import com.codeazur.as3redis.commands.server.*;
import com.codeazur.as3redis.commands.sets.*;
import com.codeazur.as3redis.commands.sorted_sets.*;
import com.codeazur.as3redis.commands.strings.*;

import com.codeazur.as3redis.commands.transactions.DISCARD;

import com.codeazur.as3redis.commands.transactions.EXEC;

import com.codeazur.as3redis.commands.transactions.MULTI;

import com.codeazur.as3redis.commands.transactions.UNWATCH;

import com.codeazur.as3redis.commands.transactions.WATCH;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.getTimer;

public class Redis extends EventDispatcher {
    protected var socket:Socket;
    protected var idleQueue:Vector.<RedisCommand>;
    protected var activeQueue:Vector.<RedisCommand>;
    protected var buffer:ByteArray;
    protected var active:Boolean = false;
    protected var connecting:Boolean = false;
    protected var connectResultHandler:Function;
    protected var enterFrameProvider:Sprite;

    protected var _host:String;
    protected var _port:int;
    protected var _password:String;
    protected var _immediateSend:Boolean = true;

    protected var _subscribers : Object = {};

    public function Redis(host:String = "127.0.0.1", port:int = 6379) {
        _host = host;
        _port = port;

        idleQueue = new Vector.<RedisCommand>();
        activeQueue = new Vector.<RedisCommand>();
        buffer = new ByteArray();
        enterFrameProvider = new Sprite();

        socket = new Socket();
        socket.addEventListener(Event.CONNECT, connectHandler);
        socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
        socket.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
    }

    public function get password():String {
        return _password;
    }

    public function set password(value:String):void {
        _password = value;
    }

    public function get immediateSend():Boolean {
        return _immediateSend;
    }

    public function set immediateSend(value:Boolean):void {
        _immediateSend = value;
    }

    public function get connected():Boolean {
        return socket.connected;
    }

    public function connect(host:String = null, port:int = 0):void {
        connectInternal(host || _host, port != 0 ? port : _port);
    }

    public function flush():void {
        executeIdleCommands();
    }


    // Connection handling

    public function sendAUTH(password:String):RedisCommand {
        return addCommand(new AUTH(password));
    }

    public function sendECHO(text:String):RedisCommand {
        return addCommand(new ECHO(text));
    }

    public function sendPING():RedisCommand {
        return addCommand(new PING());
    }

    public function sendQUIT():RedisCommand {
        return addCommand(new QUIT());
    }

    public function sendSELECT(dbIndex:uint):RedisCommand {
        return addCommand(new SELECT(dbIndex));
    }


    // Commands operating on string values

    public function sendAPPEND(key:String, value:*):RedisCommand {
        return addCommand(new APPEND(key, value));
    }

    public function sendDECR(key:String):RedisCommand {
        return addCommand(new DECR(key));
    }

    public function sendDECRBY(key:String, value:uint):RedisCommand {
        return addCommand(new DECRBY(key, value));
    }

    public function sendGET(key:String):RedisCommand {
        return addCommand(new GET(key));
    }

    public function sendGETBIT(key:String, offset : int):RedisCommand {
        return addCommand(new GETBIT(key, offset));
    }

    public function sendGETRANGE(key:String, start : int, end : int):RedisCommand {
        return addCommand(new GETRANGE(key, start, end));
    }

    public function sendGETSET(key:String, value:*):RedisCommand {
        return addCommand(new GETSET(key, value));
    }

    public function sendINCR(key:String):RedisCommand {
        return addCommand(new INCR(key));
    }

    public function sendINCRBY(key:String, value:uint):RedisCommand {
        return addCommand(new INCRBY(key, value));
    }

    public function sendMGET(... keys):RedisCommand {
        return addCommand(new MGET(keys));
    }

    public function sendMSET(... keysAndValues):RedisCommand {
        return addCommand(new MSET(keysAndValues));
    }

    public function sendMSETNX(... keysAndValues):RedisCommand {
        return addCommand(new MSETNX(keysAndValues));
    }

    public function sendSET(key:String, value:*):RedisCommand {
        return addCommand(new SET(key, value));
    }

    public function sendSETBIT(key : String, offset : int, value : int) : RedisCommand {
        return addCommand(new SETBIT(key, offset, value));
    }

    public function sendSETEX(key : String, seconds : int, value : int) : RedisCommand {
        return addCommand(new SETEX(key, seconds, value));
    }

    public function sendSETNX(key:String, value:*):RedisCommand {
        return addCommand(new SETNX(key, value));
    }

    public function sendSETRANGE(key : String, offset : int, value : String) : RedisCommand {
        return addCommand(new SETRANGE(key, offset, value));
    }

    public function sendSTRLEN(key:String):RedisCommand {
        return addCommand(new STRLEN(key));
    }


    // Commands of transaction family

    public function sendDISCARD():RedisCommand {
        return addCommand(new DISCARD());
    }

    public function sendEXEC():RedisCommand {
        return addCommand(new EXEC());
    }

    public function sendMULTI():RedisCommand {
        return addCommand(new MULTI());
    }

    public function sendUNWATCH():RedisCommand {
        return addCommand(new UNWATCH());
    }

    public function sendWATCH(keys : Array):RedisCommand {
        return addCommand(new WATCH(keys));
    }

    // Commands operating on hashes

    public function sendHDEL(key:String, field:String):RedisCommand {
        return addCommand(new HDEL(key, field));
    }

    public function sendHEXISTS(key:String, field:String):RedisCommand {
        return addCommand(new HEXISTS(key, field));
    }

    public function sendHGET(key:String, field:String):RedisCommand {
        return addCommand(new HGET(key, field));
    }

    public function sendHGETALL(key:String):RedisCommand {
        return addCommand(new HGETALL(key));
    }

    public function sendHINCRBY(key:String, field:String, incr:int):RedisCommand {
        return addCommand(new HINCRBY(key, field, incr));
    }

    public function sendHKEYS(key:String):RedisCommand {
        return addCommand(new HKEYS(key));
    }

    public function sendHLEN(key:String):RedisCommand {
        return addCommand(new HLEN(key));
    }

    public function sendHMGET(key:String, ... fields):RedisCommand {
        return addCommand(new HMGET(key, fields));
    }

    public function sendHMSET(key:String, ... fieldsAndValues):RedisCommand {
        return addCommand(new HMSET(key, fieldsAndValues));
    }

    public function sendHSET(key:String, field:String, value:*):RedisCommand {
        return addCommand(new HSET(key, field, value));
    }

    public function sendHSETNX(key:String, field:String, value:*):RedisCommand {
        return addCommand(new HSETNX(key, field, value));
    }

    public function sendHVALS(key:String):RedisCommand {
        return addCommand(new HVALS(key));
    }

    // Commands operating on the key space

    public function sendDEL(keys:Array):RedisCommand {
        return addCommand(new DEL(keys));
    }

    public function sendEXISTS(key:String):RedisCommand {
        return addCommand(new EXISTS(key));
    }

    public function sendEXPIRE(key:String, seconds:uint):RedisCommand {
        return addCommand(new EXPIRE(key, seconds));
    }

    public function sendEXPIREAT(key:String, timestamp:uint):RedisCommand {
        return addCommand(new EXPIREAT(key, timestamp));
    }

    public function sendKEYS(pattern:String):RedisCommand {
        return addCommand(new KEYS(pattern));
    }

    public function sendMOVE(key:String, dbIndex:uint):RedisCommand {
        return addCommand(new MOVE(key, dbIndex));
    }

    public function sendPERSIST(key:String):RedisCommand {
        return addCommand(new PERSIST(key));
    }

    public function sendRANDOMKEY():RedisCommand {
        return addCommand(new RANDOMKEY());
    }

    public function sendRENAME(oldKey:String, newKey:String):RedisCommand {
        return addCommand(new RENAME(oldKey, newKey));
    }

    public function sendRENAMENX(oldKey:String, newKey:String):RedisCommand {
        return addCommand(new RENAMENX(oldKey, newKey));
    }

    public function sendSORT(key:String, limitMin:int = -1, limitMax:int = -1, desc:Boolean = false, alpha:Boolean = false, byPattern:String = null, getPatterns:Array = null):RedisCommand {
        return addCommand(new SORT(key, limitMin, limitMax, desc, alpha, byPattern, getPatterns));
    }

    public function sendTTL(key:String):RedisCommand {
        return addCommand(new TTL(key));
    }

    public function sendTYPE(key:String):RedisCommand {
        return addCommand(new TYPE(key));
    }


    // Commands operating on lists

    public function sendBLPOP(keys:Array, timeout:uint):RedisCommand {
        return addCommand(new BLPOP(keys, timeout));
    }

    public function sendBRPOP(keys:Array, timeout:uint):RedisCommand {
        return addCommand(new BRPOP(keys, timeout));
    }

    public function sendBRPOPLPUSH(source : String, destination : String, timeout : uint):RedisCommand {
        return addCommand(new BRPOPLPUSH(source, destination, timeout));
    }

    public function sendLINDEX(key:String, index:int):RedisCommand {
        return addCommand(new LINDEX(key, index));
    }

    public function sendLINSERT(key : String, beforeOrAfter : String, pivot : *, value : *):RedisCommand {
        return addCommand(new LINSERT(key, beforeOrAfter, pivot, value));
    }

    public function sendLLEN(key:String):RedisCommand {
        return addCommand(new LLEN(key));
    }

    public function sendLPOP(key:String):RedisCommand {
        return addCommand(new LPOP(key));
    }

    public function sendLPUSH(key:String, value:*):RedisCommand {
        return addCommand(new LPUSH(key, value));
    }

    public function sendLPUSHX(key:String, value:*):RedisCommand {
        return addCommand(new LPUSHX(key, value));
    }

    public function sendLRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
        return addCommand(new LRANGE(key, startIndex, endIndex));
    }

    public function sendLREM(key:String, count:int, value:*):RedisCommand {
        return addCommand(new LREM(key, count, value));
    }

    public function sendLSET(key:String, index:int, value:*):RedisCommand {
        return addCommand(new LSET(key, index, value));
    }

    public function sendLTRIM(key:String, startIndex:int, endIndex:int):RedisCommand {
        return addCommand(new LTRIM(key, startIndex, endIndex));
    }

    public function sendRPOP(key:String):RedisCommand {
        return addCommand(new RPOP(key));
    }

    public function sendRPOPLPUSH(sourceKey:String, destinationKey:String):RedisCommand {
        return addCommand(new RPOPLPUSH(sourceKey, destinationKey));
    }

    public function sendRPUSH(key:String, value:*):RedisCommand {
        return addCommand(new RPUSH(key, value));
    }

    public function sendRPUSHX(key:String, value:*):RedisCommand {
        return addCommand(new RPUSHX(key, value));
    }

    // Commands operating on sets

    public function sendSADD(key:String, value:*):RedisCommand {
        return addCommand(new SADD(key, value));
    }

    public function sendSCARD(key:String):RedisCommand {
        return addCommand(new SCARD(key));
    }

    public function sendSDIFF(keys:Array):RedisCommand {
        return addCommand(new SDIFF(keys));
    }

    public function sendSDIFFSTORE(destinationKey:String, keys:Array):RedisCommand {
        return addCommand(new SDIFFSTORE(destinationKey, keys));
    }

    public function sendSINTER(keys:Array):RedisCommand {
        return addCommand(new SINTER(keys));
    }

    public function sendSINTERSTORE(destinationKey:String, keys:Array):RedisCommand {
        return addCommand(new SINTERSTORE(destinationKey, keys));
    }

    public function sendSISMEMBER(key:String, value:*):RedisCommand {
        return addCommand(new SISMEMBER(key, value));
    }

    public function sendSMEMBERS(key:String):RedisCommand {
        return addCommand(new SMEMBERS(key));
    }

    public function sendSMOVE(sourceKey:String, destinationKey:String, value:*):RedisCommand {
        return addCommand(new SMOVE(sourceKey, destinationKey, value));
    }

    public function sendSPOP(key:String):RedisCommand {
        return addCommand(new SPOP(key));
    }

    public function sendSRANDMEMBER(key:String):RedisCommand {
        return addCommand(new SRANDMEMBER(key));
    }

    public function sendSREM(key:String, value:*):RedisCommand {
        return addCommand(new SREM(key, value));
    }

    public function sendSUNION(keys:Array):RedisCommand {
        return addCommand(new SUNION(keys));
    }

    public function sendSUNIONSTORE(destinationKey:String, keys:Array):RedisCommand {
        return addCommand(new SUNIONSTORE(destinationKey, keys));
    }


    // Commands operating on sorted sets (zsets)

    public function sendZADD(key:String, score:Number, value:*):RedisCommand {
        return addCommand(new ZADD(key, score, value));
    }

    public function sendZCARD(key:String):RedisCommand {
        return addCommand(new ZCARD(key));
    }

    public function sendZCOUNT(key:String, minScore : String, maxScore : String):RedisCommand {
        return addCommand(new ZCOUNT(key, minScore, maxScore));
    }

    public function sendZINCRBY(key:String, increment : Number, member : String):RedisCommand {
        return addCommand(new ZINCRBY(key, increment, member));
    }

    public function sendZINTERSTORE(destination : String,
            numKeys : int,
            keys : Array,
            weights : Array = null,
            aggregate : String = null) : RedisCommand {
        return addCommand(new ZINTERSTORE(destination, numKeys, keys, weights, aggregate));
    }

    public function sendZRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
        return addCommand(new ZRANGE(key, startIndex, endIndex));
    }

    public function sendZRANGEBYSCORE(key : String, minScore : String, maxScore : String, withScores : Boolean = false, offset : int = NaN, count : int = NaN) : RedisCommand {
        return addCommand(new ZRANGEBYSCORE(key, minScore, maxScore, withScores, offset, count));
    }

    public function sendZRANK(key:String, member:String):RedisCommand {
        return addCommand(new ZRANK(key, member));
    }

    public function sendZREM(key:String, value:*):RedisCommand {
        return addCommand(new ZREM(key, value));
    }

    public function sendZREMRANGEBYRANK(key : String, startIndex : int, endIndex : int) : RedisCommand {
        return addCommand(new ZREMRANGEBYRANK(key, startIndex, endIndex));
    }

    public function sendZREMRANGEBYSCORE(key : String, minScore : int, maxScore : int) : RedisCommand {
        return addCommand(new ZREMRANGEBYSCORE(key, minScore, maxScore));
    }

    public function sendZREVRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
        return addCommand(new ZREVRANGE(key, startIndex, endIndex));
    }

    public function sendZREVRANGEBYSCORE(key : String, minScore : String, maxScore : String, withScores : Boolean = false, offset : int = NaN, count : int = NaN) : RedisCommand {
        return addCommand(new ZREVRANGEBYSCORE(key, minScore, maxScore, withScores, offset, count));
    }

    public function sendZREVRANK(key:String, member:String):RedisCommand {
        return addCommand(new ZREVRANK(key, member));
    }

    public function sendZSCORE(key:String, value:*):RedisCommand {
        return addCommand(new ZSCORE(key, value));
    }


    public function sendZUNIONSTORE(destination : String,
            numKeys : int,
            keys : Array,
            weights : Array = null,
            aggregate : String = null) : RedisCommand {
        return addCommand(new ZUNIONSTORE(destination, numKeys, keys, weights, aggregate));
    }


    // Server control commands

    public function sendBGREWRITEAOF():RedisCommand {
        return addCommand(new BGREWRITEAOF());
    }

    public function sendBGSAVE():RedisCommand {
        return addCommand(new BGSAVE());
    }

    public function sendCONFIG(subcommand : String, ... parameters):RedisCommand {
        return addCommand(new CONFIG(subcommand, parameters));
    }

    public function sendDBSIZE():RedisCommand {
        return addCommand(new DBSIZE());
    }

    public function sendFLUSHALL():RedisCommand {
        return addCommand(new FLUSHALL());
    }

    public function sendFLUSHDB():RedisCommand {
        return addCommand(new FLUSHDB());
    }

    public function sendINFO():RedisCommand {
        return addCommand(new INFO());
    }

    public function sendLASTSAVE():RedisCommand {
        return addCommand(new LASTSAVE());
    }

    public function sendOBJECT(subcommand : String, ... parameters):RedisCommand {
        return addCommand(new OBJECT(subcommand, parameters));
    }

    public function sendSAVE():RedisCommand {
        return addCommand(new SAVE());
    }

    public function sendSHUTDOWN():RedisCommand {
        return addCommand(new SHUTDOWN());
    }

    public function sendSLAVEOF(host:String = null, port:int = -1):RedisCommand {
        return addCommand(new SLAVEOF(host, port));
    }

    // Commands of pub/sub family

    public function sendPSUBSCRIBE(patterns:Array):RedisCommand {
        var cmd:PSUBSCRIBE = new PSUBSCRIBE(patterns);
        for each(var pat : String in patterns) {
            _subscribers[pat] = cmd;
        }

        return addCommand(cmd);
    }

    public function sendPUBLISH(channel:String, message:String):RedisCommand {
        return addCommand(new PUBLISH(channel, message));
    }

    public function sendPUNSUBSCRIBE(patterns:Array):RedisCommand {
        return addCommand(new PUNSUBSCRIBE(patterns));
    }

    public function sendSUBSCRIBE(channels:Array):RedisCommand {
        var cmd:SUBSCRIBE = new SUBSCRIBE(channels);
        for each(var chan : String in channels) {
            _subscribers[chan] = cmd;
        }


        return addCommand(cmd);
    }

    public function sendUNSUBSCRIBE(channels:Array):RedisCommand {
        return addCommand(new UNSUBSCRIBE(channels));
    }



    // Internal commands

    protected function addCommand(command:RedisCommand):RedisCommand {
        idleQueue.push(command);
        executeIdleCommands();
        return command;
    }

    protected function executeIdleCommands():void {
        if (!active) {
            if (!connected) {
                if (!connecting) {
                    connectInternal(_host, _port, executeIdleCommands);
                }
            } else {
                enterFrameProvider.addEventListener(Event.ENTER_FRAME, executeIdleCommandsRunner);
                active = true;
            }
        }
    }

    protected function executeIdleCommandsRunner(event:Event):void {
        var startTime:Number = getTimer();
        var command:RedisCommand;
        while (idleQueue.length > 0) {
            if (getTimer() - startTime < 20) {
                command = idleQueue.shift();
                command.send(socket);
                if(!isPubsubCommand(command)) {
                    activeQueue.push(command);
                }
            } else {
                break;
            }
        }
        socket.flush();
        if (idleQueue.length == 0) {
            enterFrameProvider.removeEventListener(Event.ENTER_FRAME, executeIdleCommandsRunner);
            active = false;
        }
    }

    private function isPubsubCommand(command:RedisCommand):Boolean {
        return command is SUBSCRIBE || command is PSUBSCRIBE
                || command is UNSUBSCRIBE || command is PUNSUBSCRIBE;
    }

    protected function connectInternal(host:String, port:int, resultHandler:Function = null):void {
        _host = host;
        _port = port;
        connecting = true;
        connectResultHandler = resultHandler;
        socket.connect(host, port);
    }

    protected function connectHandler(e:Event):void {
        connecting = false;
        // Redispatch the event
        dispatchEvent(e.clone());
        // Authentication
        if (_password) {
            // A password is set, so we have to send the AUTH command first
            idleQueue.splice(0, 0, new AUTH(_password));
        }
        if (connectResultHandler != null) {
            connectResultHandler();
        }
    }

    protected function errorHandler(e:Event):void {
        // Redispatch the event
        dispatchEvent(e.clone());
    }

    protected function dataHandler(e:ProgressEvent):void {
        // Read all available bytes from the socket and append them to the buffer
        socket.readBytes(buffer, buffer.length, socket.bytesAvailable);
        // Parse buffer from the start

//        buffer.position = 0;
//        var dump : String = buffer.readUTFBytes(buffer.length);
//        trace('buffer: ' + dump);

        buffer.position = 0;
        var commandProcessed:Boolean = true;
        while (commandProcessed && buffer.length - buffer.position >= 3) {
            var beginningPosOfCurrentResponse:uint = buffer.position;
            // Find the next CR/LF pair starting from the current position
            var i:int = findCRLF(buffer, buffer.position);
            if (i > 0) {
                var responseType:String;
                var responseMessage:String;
                var bulkResponses:Array;

                // We found a CR/LF, and there is data available to parse
                // Find the first active command in the queue

                var len:int;
                // The first byte of a redis response is always the type indicator
                var type:String = String.fromCharCode(buffer.readUnsignedByte());
                // Followed by the rest, which is interpreted as a string
                var head:String = buffer.readUTFBytes(i - buffer.position);
                // Followed by the CR/LF we found above
                buffer.position += 2; // skip crlf
                // So let's see what we're dealing with:
                switch (type) {
                    case "-":
                        // This is an error message
                        responseType = RedisCommand.RESPONSE_TYPE_ERROR;
                        responseMessage = head;
                        break;
                    case "+":
                        // This is a single line reply
                        responseType = RedisCommand.RESPONSE_TYPE_STRING;
                        responseMessage = head;
                        break;
                    case ":":
                        // This is an integer number
                        responseType = RedisCommand.RESPONSE_TYPE_INTEGER;
                        responseMessage = head;
                        break;
                    case "$":
                        // This is bulk data
                        // Get the size of the data block
                        bulkResponses = null;
                        len = parseInt(head);
                        if (len >= 0) {
                            // Check if the entire data block is loaded already
                            if (buffer.length - buffer.position - len - 2 >= 0) {
                                // Yes it is, so parse and save it
                                responseType = RedisCommand.RESPONSE_TYPE_BULK;
                                if (!bulkResponses) bulkResponses = [];
                                bulkResponses.push(parseBulk(len));
                            } else {
                                // No, we need to wait for more data
                                // Set the position back to the beginning of the current response
                                buffer.position = beginningPosOfCurrentResponse;
                                commandProcessed = false;
                            }
                        } else {
                            // Length can be -1 (no data available, non-existant key etc)
                            responseType = RedisCommand.RESPONSE_TYPE_BULK;
                            responseMessage = head;
                        }
                        break;
                    case "*":
                        // This is multi bulk data
                        bulkResponses = null;
                        var count:int = parseInt(head);
                        if (count > 0) {
                            for (var j:uint = 0; j < count; j++) {
                                var nextcrlf:int = findCRLF(buffer, buffer.position);
                                if (nextcrlf >= 0) {
                                    if (nextcrlf - buffer.position > 1) {
                                        // The first byte of a redis response is always the type indicator
                                        type = String.fromCharCode(buffer.readUnsignedByte());
                                        // Followed by the rest, which is interpreted as a string
                                        head = buffer.readUTFBytes(nextcrlf - buffer.position);
                                        // Followed the CR/LF we found above
                                        buffer.position += 2; // skip crlf
                                        // Response type must be bulk data
                                        if (type == "$") {
                                            len = parseInt(head);
                                            if (len >= 0) {
                                                // Check if the entire data block is loaded already
                                                if (buffer.length - buffer.position - len - 2 >= 0) {
                                                    // Yes it is, so parse and save it
                                                    if (!bulkResponses) bulkResponses = [];
                                                    bulkResponses.push(parseBulk(len));
                                                } else {
                                                    // No, we need to wait for more data
                                                    // Set the position back to the beginning of the current response
                                                    buffer.position = beginningPosOfCurrentResponse;
                                                    commandProcessed = false;
                                                    break;
                                                }
                                            } else {
                                                // Length can be -1 (no data available, non-existant key etc)
                                                if (!bulkResponses) bulkResponses = [];
                                                bulkResponses.push(null);
                                            }
                                        } else if(type == ':') {
                                            bulkResponses.push(parseInt(head));
                                        } else {
                                            throw(new Error("Illegal header type '" + type + "'."));
                                        }
                                    } else {
                                        throw(new Error("Empty header."));
                                    }
                                } else {
                                    buffer.position = beginningPosOfCurrentResponse;
                                    commandProcessed = false;
                                    break;
                                }
                            }
                        }
                        if (commandProcessed) {
                            responseType = RedisCommand.RESPONSE_TYPE_BULK_MULTI;
                        }
                        break;
                }

                if (commandProcessed) {
                    var handled : Boolean = handleSubscriptionOutput(bulkResponses)

                    if(!handled) {
                        var command:RedisCommand = activeQueue.shift();
                        if (command != null) {
                            command.setResponseType(responseType);
                            command.setResponseMessage(responseMessage);
                            if(bulkResponses) {
                                for each(var b : * in bulkResponses) {
                                    command.addBulkResponse(b);
                                }
                            }
                            command.finishResponse();
                        } else {
                            throw(new Error("No active commands found."));
                        }
                    }

                }
            } else if (i == 0) {
                throw(new Error("Empty header."));
            }
        }
        // Truncate the buffer, cut off the bytes we processed
        if (buffer.position < buffer.length) {
            var ba:ByteArray = new ByteArray();
            ba.writeBytes(buffer, buffer.position, buffer.length - buffer.position);
            buffer = ba;
        } else {
            // The whole buffer has been processed
            buffer.length = 0;
        }
    }

    private function handleSubscriptionOutput(bulkResponses : Array) : Boolean {
        var sublen : Number = countMembers(_subscribers);
        if (sublen == 0) {
            return false;
        }

        var strings : Array = responseBulkAsStrings(bulkResponses);

        if (strings && (strings.length == 3 || strings.length == 4)) {
            var msgType : String = strings[0];
            var channel : String = strings[1];

            if (msgType == 'subscribe') {
                return true;
            }
            if (msgType == 'unsubscribe') {
                delete _subscribers[channel];
                return true;
            }

            if (msgType == 'message') {
                dispatchMessage(channel, strings[2]);
                return true;
            }
            if (msgType == 'pmessage') {
                dispatchMessage(channel, strings[3]);
                return true;
            }
        }
        return false;

    }

    private function dispatchMessage(channel:String, message:String):void {
        var cmd : RedisCommand = _subscribers[channel];
        if(cmd) {
            cmd.setResponseType(RedisCommand.RESPONSE_TYPE_STRING);
            cmd.setResponseMessage(message);
            cmd.finishResponse();
        } else {
            throw new Error("no listener for '" + channel + "'");
        }
    }

    private function countMembers(obj : Object) : int {
        var result : int = 0;
        for each(var i : * in obj) {
            result += 1;
        }
        return result;
    }

    private function responseBulkAsStrings(bulks:Array):Array {
        var result:Array;
        if (bulks != null && bulks.length > 0) {
            result = [];
            var val:String;
            for (var i:uint = 0; i < bulks.length; i++) {
                val = null;
                if(bulks[i] is ByteArray) {
                    var ba:ByteArray = bulks[i];
                    if (ba != null) {
                        if (ba.length > 0) {
                            ba.position = 0;
                            val = ba.readUTFBytes(ba.length);
                        } else {
                            val = "";
                        }
                    }
                    result.push(val);
                } else {
                    result.push(String(bulks[i]));
                }
            }
        }
        return result;
    }


    protected function parseBulk(len:int):ByteArray {
        // Process the bulk data body
        var ba:ByteArray = new ByteArray();
        // Copy [len] bytes
        if (len > 0) {
            buffer.readBytes(ba, 0, len);
            ba.position = 0;
        }
        // The data should be immediately followed by CR/LF
        var idx:int = findCRLF(buffer, buffer.position);
        if (idx >= 0) {
            if (idx > buffer.position) {
                // There's extra data, [len] bytes are not immediately followed by CR/LF
                trace("Warning: skipped " + (idx - buffer.position) + " bytes after bulk data");
            }
            // Skip to after CR/LF (start of next reply)
            buffer.position = idx + 2;
        }
        return ba;
    }

    protected function findCRLF(ba:ByteArray, startAtIndex:uint = 0):int {
        for (var i:uint = startAtIndex; i < ba.length - 1; i++) {
            if (ba[i] == 0x0d && ba[i + 1] == 0x0a) {
                return i;
            }
        }
        return -1;
    }
}
}
