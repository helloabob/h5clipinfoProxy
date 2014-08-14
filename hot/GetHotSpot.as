package hot
{
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetHotSpot extends RequestBase
    {
        private var vid:String;
        private var mainCallback:Function;
        private var sign:String;

        public function GetHotSpot(param1:String, param2:Function, param3:String)
        {
            this.vid = param1;
            this.sign = param3;
            this.mainCallback = param2;
            super("== GetHotSpot");
            return;
        }// end function

        override protected function buildReqDat() : RequestDat
        {
            var _loc_1:* = super.buildReqDat();
            _loc_1.url = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/vrshot.do" + "?vid=" + this.vid;
            return _loc_1;
        }// end function

        override protected function isSucc(param1:Object) : Boolean
        {
            return param1 && param1.status == 200 && Tools.objLen(param1.attachment);
        }// end function

        override protected function succ(param1:Object, param2:Object) : void
        {
            this.mainCallback(param1.attachment, this.sign);
            return;
        }// end function

        override protected function fail(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        override protected function exhaust(param1:Object, param2:Object) : void
        {
            this.mainCallback("热点信息失败", this.sign);
            return;
        }// end function

    }
}
