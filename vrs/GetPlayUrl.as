package vrs
{
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetPlayUrl extends RequestBase
    {
        private var dat:Object;
        private var clipId:int;
        private var infoCallback:Function;

        public function GetPlayUrl(param1:int, param2:Object, param3:Function)
        {
            this.infoCallback = param3;
            this.clipId = param1;
            this.dat = param2;
            super("== GetPlayUrl");
            return;
        }// end function

        override protected function buildReqDat() : RequestDat
        {
            var _loc_1:* = super.buildReqDat();
            _loc_1.datType = Request.DAT_TYPE.STRING;
            _loc_1.avoidRetryRspType = [Request.RSP_TYPE.IO_ERR, Request.RSP_TYPE.DAT_PARSE_ERR, Request.RSP_TYPE.SECURITY_ERR];
            _loc_1.url = "http://" + this.dat.redirectIp + "/" + "?prot=2" + "&file=" + this.getUrlPath(this.dat.clipUrls[this.clipId]) + "&new=" + this.dat.syncUrls[this.clipId] || "" + "&key=" + this.dat.keys[this.clipId];
            Trace.log(this.clipId, _loc_1.url);
            return _loc_1;
        }// end function

        protected function getUrlPath(param1:String) : String
        {
            if (!param1 || param1 == null || param1 == "")
            {
                return "";
            }
            param1 = param1.replace("http://data.vod.itc.cn", "");
            return param1.split("?")[0];
        }// end function

        override protected function isSucc(param1:Object) : Boolean
        {
            return param1 && param1 !== "quick";
        }// end function

        override protected function succ(param1:Object, param2:Object) : void
        {
            new PlayUrlParser().parse(param1 as String, this.clipId, this.dat, this.infoCallback);
            return;
        }// end function

        override protected function fail(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        override protected function exhaust(param1:Object, param2:Object) : void
        {
            this.infoCallback(this.clipId, "视频信息错误[url]", true);
            return;
        }// end function

    }
}
