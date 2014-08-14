package vsin.dcw.support.net
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import vsin.dcw.support.*;

    public class Request extends Object
    {
        public var bindDat:Object;
        public var spendTime:Number = 0;
        private var _urlLd:URLLoader;
        private var _setTimeoutId:Number = 0;
        private var _promise:Promise;
        private var _isSucc:Function;
        private var _beforeParsing:Function;
        private var _datType:String;
        private var _avoidRetryType:Array;
        private var _shutdown:Boolean = false;
        private var _name:String = "?";
        public static const DAT_TYPE:RequestDatType = new RequestDatType();
        public static const RSP_TYPE:RequestResponseType = new RequestResponseType();

        public function Request()
        {
            return;
        }// end function

        public function load(param1:RequestDat) : Promise
        {
            this.bindDat = param1.bindDat;
            this._isSucc = param1.isSucc;
            this._beforeParsing = param1.beforeParsing;
            this._datType = param1.datType;
            this._avoidRetryType = param1.avoidRetryRspType;
            this._name = param1.name ? (param1.name) : (this._name);
            this._promise = param1.promise || new Promise();
            this._urlLd = new URLLoader();
            this._urlLd.dataFormat = URLLoaderDataFormat.TEXT;
            this.addEvent();
            var _loc_2:* = new URLRequest(param1.url);
            if (param1.vars != null)
            {
                _loc_2.method = URLRequestMethod.POST;
                _loc_2.data = param1.vars;
            }
            this.spendTime = getTimer();
            this._urlLd.load(_loc_2);
            this._setTimeoutId = setTimeout(this.timeoutHandler, param1.timeout * 1000);
            this._shutdown = false;
            return this._promise;
        }// end function

        private function completeHandler(event:Event) : void
        {
            var rootDat:Object;
            var e:* = event;
            var ori:* = e.target.data;
            if (this._beforeParsing is Function)
            {
                ori = this._beforeParsing(ori);
            }
            try
            {
                switch(this._datType)
                {
                    case DAT_TYPE.JSON:
                    {
                        Trace.log(ori);
                        rootDat = Json.parse(ori);
                        break;
                    }
                    case DAT_TYPE.STRING:
                    {
                        rootDat = ori;
                        break;
                    }
                    case DAT_TYPE.ARRAY:
                    {
                        rootDat = Json.parseObjInArr(ori);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                callbackShell({type:RSP_TYPE.DAT_PARSE_ERR, bind:bindDat});
                return;
            }
            if (this._isSucc(rootDat))
            {
                this.callbackShell({type:RSP_TYPE.SUCCESS, bind:this.bindDat, data:rootDat});
            }
            else
            {
                this.callbackShell({type:RSP_TYPE.DAT_ERR, bind:this.bindDat, data:rootDat});
            }
            return;
        }// end function

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            this.callbackShell({type:RSP_TYPE.SECURITY_ERR, bind:this.bindDat});
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            this.callbackShell({type:RSP_TYPE.IO_ERR, bind:this.bindDat});
            return;
        }// end function

        private function timeoutHandler() : void
        {
            this.callbackShell({type:RSP_TYPE.TIME_OUT, bind:this.bindDat});
            return;
        }// end function

        private function httpStatusHandler(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function callbackShell(param1:Object) : void
        {
            clearTimeout(this._setTimeoutId);
            this.spendTime = this.spendTime - getTimer();
            this._shutdown = true;
            this.close();
            switch(param1.type)
            {
                case RSP_TYPE.SUCCESS:
                {
                    this._promise.resolve(param1.type, param1.data, param1.bind);
                    break;
                }
                case RSP_TYPE.DAT_ERR:
                case RSP_TYPE.DAT_PARSE_ERR:
                case RSP_TYPE.SECURITY_ERR:
                case RSP_TYPE.IO_ERR:
                case RSP_TYPE.TIME_OUT:
                {
                    this._promise.reject(this._avoidRetryType.indexOf(param1.type) > -1, param1.type, param1.data, param1.bind);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._shutdown)
            {
                this._promise = null;
                Trace.log(this._name + " SHUT_DOWN");
            }
            return;
        }// end function

        private function close() : void
        {
            this.removeEvent();
            try
            {
                this._urlLd.close();
            }
            catch (evt:Error)
            {
            }
            this._urlLd = null;
            this._isSucc = null;
            this._beforeParsing = null;
            this.bindDat = null;
            return;
        }// end function

        private function removeEvent() : void
        {
            this._urlLd.removeEventListener(Event.COMPLETE, this.completeHandler);
            this._urlLd.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._urlLd.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            this._urlLd.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._urlLd.addEventListener(Event.COMPLETE, fakeHandler);
            this._urlLd.addEventListener(IOErrorEvent.IO_ERROR, fakeHandler);
            this._urlLd.addEventListener(HTTPStatusEvent.HTTP_STATUS, fakeHandler);
            this._urlLd.addEventListener(SecurityErrorEvent.SECURITY_ERROR, fakeHandler);
            return;
        }// end function

        private function addEvent() : void
        {
            this._urlLd.addEventListener(Event.COMPLETE, this.completeHandler);
            this._urlLd.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._urlLd.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            this._urlLd.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._urlLd.removeEventListener(Event.COMPLETE, fakeHandler);
            this._urlLd.removeEventListener(IOErrorEvent.IO_ERROR, fakeHandler);
            this._urlLd.removeEventListener(HTTPStatusEvent.HTTP_STATUS, fakeHandler);
            this._urlLd.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, fakeHandler);
            return;
        }// end function

        private static function fakeHandler(event:Event) : void
        {
            var _loc_2:int = 1;
            return;
        }// end function

    }
}
