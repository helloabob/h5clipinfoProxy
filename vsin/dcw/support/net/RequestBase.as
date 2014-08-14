package vsin.dcw.support.net
{
    import vsin.dcw.support.*;

    public class RequestBase extends Object
    {
        protected var REQ_NAME:String;
        protected var req:Request;
        protected var reqDat:RequestDat;

        public function RequestBase(param1:String = "unknown")
        {
            this.REQ_NAME = param1;
            this.req = new Request();
            this.reqDat = this.buildReqDat();
            this.fire();
            return;
        }// end function

        protected function fire() : void
        {
            new Promise(true).then([this.load], this.onHttpSucc, this.onHttpErr);
            return;
        }// end function

        protected function load() : Promise
        {
            var _loc_1:* = this.reqDat.url.indexOf("?") == -1;
            this.reqDat.url = this.reqDat.url + ((_loc_1 ? ("?t=") : ("&t=")) + new Date().time);
            return this.req.load(this.reqDat);
        }// end function

        protected function onHttpSucc(param1:String, param2:Object, param3:Object) : void
        {
            Trace.log(this.REQ_NAME + " " + param1);
            this.req = null;
            this.succ(param2, param3);
            return;
        }// end function

        protected function onHttpErr(param1:String, param2:Object, param3:Object, param4:Boolean) : void
        {
            if (param4)
            {
                Trace.log(this.REQ_NAME + " totally " + param1);
                this.req = null;
                this.exhaust(param2, param3);
            }
            else
            {
                Trace.log(this.REQ_NAME + " " + param1);
                this.fail(param2, param3);
            }
            return;
        }// end function

        protected function buildReqDat() : RequestDat
        {
            var _loc_1:* = new RequestDat();
            _loc_1.isSucc = this.isSucc;
            _loc_1.beforeParsing = this.beforeParsing;
            _loc_1.name = this.REQ_NAME;
            return _loc_1;
        }// end function

        protected function beforeParsing(param1:String) : String
        {
            return param1;
        }// end function

        protected function isSucc(param1:Object) : Boolean
        {
            return false;
        }// end function

        protected function succ(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        protected function fail(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        protected function exhaust(param1:Object, param2:Object) : void
        {
            return;
        }// end function

    }
}
