package vrs
{

    public class PlayInfoParser extends Object
    {
        private var pDat:Object;
        private var succCount:int = 0;
        private var mainCallback:Function;
        private var sign:String;

        public function PlayInfoParser()
        {
            this.pDat = {};
            return;
        }// end function

        public function parse(param1:Object, param2:Function, param3:String) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            this.mainCallback = param2;
            this.sign = param3;
            this.pDat.allPlayUrl = [];
            this.succCount = 0;
            if (param1.data)
            {
                if (!param1.prot || param1.prot == 2)
                {
                    this.pDat.redirectIp = param1.allot;
                    this.pDat.playInfo = param1.data;
                    this.pDat.keys = param1.data.ck;
                    this.pDat.hashIds = param1.data.hc;
                    this.pDat.syncUrls = param1.data.su || [];
                    this.pDat.clipUrls = param1.data.clipsURL;
                    this.pDat.totBytes = param1.data.totalBytes;
                    this.pDat.clipByteArr = param1.data.clipsBytes;
                    this.pDat.totDuration = param1.data.totalDuration;
                    this.pDat.clipDurArr = param1.data.clipsDuration;
                    this.pDat.keyFrameInfo = param1.data.kft;
                    this.pDat.tvName = param1.data.tvName;
                    this.pDat.clipSeekMark = [];
                    _loc_4 = this.pDat.clipUrls.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        new GetPlayUrl(_loc_5, this.pDat, this.getPlayUrlCallback);
                        _loc_5++;
                    }
                }
                else
                {
                    this.mainCallback("播放信息错误(#2)", param3, true);
                }
            }
            else
            {
                this.mainCallback("播放信息错误(#1)", param3, true);
            }
            return;
        }// end function

        private function getPlayUrlCallback(param1:int, param2:String, param3:Boolean = false) : void
        {
            if (param3)
            {
                this.mainCallback(param2, this.sign, true);
            }
            else
            {
                var _loc_4:String = this;
                var _loc_5:* = this.succCount + 1;
                _loc_4.succCount = _loc_5;
                this.pDat.allPlayUrl[param1] = param2;
                this.mainCallback(this.succCount, this.sign);
                if (this.succCount >= this.pDat.clipUrls.length)
                {
                    this.mainCallback(this.pDat, this.sign);
                }
            }
            return;
        }// end function

    }
}
