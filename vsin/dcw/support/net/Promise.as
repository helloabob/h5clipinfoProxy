package vsin.dcw.support.net
{

    public class Promise extends Object
    {
        private var _succ:Function;
        private var _fail:Function;
        private var _nextPromise:Promise;
        private var _reqFunc:Array;
        private var _resolved:Boolean = false;
        private var _rejected:Boolean = false;
        private var _imm:Boolean;
        private var _retryTimes:int = 2;
        private var tot:int;
        private var count:int;
        private var totCount:int;
        private var avoided:Boolean = false;
        protected var idx:int = -1;
        public static const PENDING:String = "PENDING";
        public static const RESOLVED:String = "RESOLVED";
        public static const REJECTED:String = "REJECTED";

        public function Promise(param1:Boolean = false)
        {
            this._imm = param1;
            return;
        }// end function

        public function state() : String
        {
            if (this._resolved)
            {
                return Promise.RESOLVED;
            }
            if (this._rejected)
            {
                return Promise.REJECTED;
            }
            return Promise.PENDING;
        }// end function

        public function setRetryTimes(param1:int) : Promise
        {
            this._retryTimes = param1;
            return this;
        }// end function

        public function then(... args) : Promise
        {
            args = null;
            var _loc_3:Function = null;
            switch(args.length)
            {
                case 2:
                {
                    args = args[0];
                    _loc_3 = args[1];
                    break;
                }
                case 3:
                {
                    this._reqFunc = args[0];
                    if (this._imm)
                    {
                        this.execReqFunc();
                        this._imm = false;
                    }
                    args = args[1];
                    _loc_3 = args[2];
                    break;
                }
                default:
                {
                    throw new Error("Promise : illegal params");
                    break;
                }
            }
            this._succ = args;
            this._fail = _loc_3;
            this._nextPromise = new Promise();
            return this._nextPromise;
        }// end function

        public function resolve(... args) : void
        {
            this._resolved = true;
            this._rejected = false;
            this._nextPromise.execReqFunc();
            if (args && args.length)
            {
                if (this.idx >= 0)
                {
                    args.unshift(this.idx);
                    this.idx = -1;
                }
                this._succ.apply(null, args);
            }
            return;
        }// end function

        public function reject(... args) : void
        {
            this._resolved = false;
            this._rejected = true;
            if (args && args.length)
            {
                if (this.idx >= 0)
                {
                    args.unshift(this.idx);
                    this.idx = -1;
                }
                this._fail.apply(null, args);
            }
            return;
        }// end function

        private function dispose() : void
        {
            this._succ = null;
            this._fail = null;
            this._nextPromise = null;
            this._reqFunc.length = 0;
            this.count = 0;
            return;
        }// end function

        protected function execReqFunc() : void
        {
            var _loc_2:Function = null;
            if (!(this._reqFunc && this._reqFunc.length))
            {
                return;
            }
            this.tot = this._reqFunc.length;
            trace();
            trace("execReqFunc tot", this.tot);
            this.count = 0;
            this.totCount = 0;
            this.avoided = false;
            var _loc_1:int = 0;
            for each (_loc_2 in this._reqFunc)
            {
                
                (this._loc_2() as Promise).setIdx(_loc_1).then(this.succCount, this.failCount);
                _loc_1++;
            }
            return;
        }// end function

        protected function setIdx(param1:int) : Promise
        {
            this.idx = param1;
            return this;
        }// end function

        private function succCount(... args) : void
        {
            args = this;
            var _loc_3:* = args.count + 1;
            args.count = _loc_3;
            var _loc_2:String = this;
            var _loc_3:* = this.totCount + 1;
            _loc_2.totCount = _loc_3;
            trace("succ idx", args[0]);
            this._reqFunc[args.shift()] = null;
            this._succ.apply(null, args);
            if (this.count === this.tot)
            {
                this.resolve();
                this.dispose();
            }
            else
            {
                this.tryEnd();
            }
            return;
        }// end function

        private function failCount(... args) : void
        {
            var _loc_3:String = this;
            var _loc_4:* = this.totCount + 1;
            _loc_3.totCount = _loc_4;
            trace("fail idx", args.shift(), args[0]);
            args = args.shift();
            this.avoided = this.avoided || args;
            args.push(args || this.isEnd());
            this._fail.apply(null, args);
            return;
        }// end function

        private function isEnd() : Boolean
        {
            this._reqFunc = this.trimArray(this._reqFunc);
            if (this._retryTimes > 0 && this._reqFunc && this._reqFunc.length)
            {
                return false;
            }
            return true;
        }// end function

        private function tryEnd() : Boolean
        {
            if (this.totCount === this.tot)
            {
                this._reqFunc = this.trimArray(this._reqFunc);
                if (!this.avoided && this._retryTimes > 0 && this._reqFunc && this._reqFunc.length)
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this._retryTimes - 1;
                    _loc_1._retryTimes = _loc_2;
                    trace("retry");
                    this.execReqFunc();
                }
                else
                {
                    trace("retry over");
                    this.reject();
                    return true;
                }
            }
            return false;
        }// end function

        private function trimArray(param1:Array) : Array
        {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
            }
            return _loc_2;
        }// end function

    }
}
