package ugc
{
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetPlayInfoUgc extends RequestBase
    {
        private var vid:String;
        private var sign:String;
        private var mainCallback:Function;

        public function GetPlayInfoUgc(param1:String, param2:Function, param3:String)
        {
            this.vid = param1;
            this.sign = param3;
            this.mainCallback = param2;
            super("== GetPlayInfoUgc");
            return;
        }// end function

        override protected function buildReqDat() : RequestDat
        {
            var _loc_1:* = super.buildReqDat();
            _loc_1.url = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/getKeyFrame.do" + "?vid=" + this.vid;
            return _loc_1;
        }// end function

        override protected function isSucc(param1:Object) : Boolean
        {
            return Tools.objLen(param1) > 0;
        }// end function

        override protected function succ(param1:Object, param2:Object) : void
        {
            new PlayInfoParserUgc().parse(param1, this.mainCallback, this.sign);
            return;
        }// end function

        override protected function fail(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        override protected function exhaust(param1:Object, param2:Object) : void
        {
            this.mainCallback("视频信息错误[ugc]", this.sign, true);
            return;
        }// end function

    }
}
