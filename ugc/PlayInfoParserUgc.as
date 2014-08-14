package ugc
{

    public class PlayInfoParserUgc extends Object
    {
        private var pDat:Object;
        private var succCount:int = 0;
        private var mainCallback:Function;
        private var sign:String;

        public function PlayInfoParserUgc()
        {
            this.pDat = {};
            return;
        }// end function

        public function parse(param1:Object, param2:Function, param3:String) : void
        {
            var _loc_4:String = null;
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:Number = NaN;
            var _loc_8:int = 0;
            this.mainCallback = param2;
            this.sign = param3;
            this.pDat.allPlayUrl = [];
            this.succCount = 0;
            if (param1.data)
            {
                _loc_4 = param1.data.keyFrames;
                _loc_5 = _loc_4.split(",");
                if (_loc_4)
                {
                    _loc_5 = _loc_4.split(",");
                }
                this.pDat.playInfo = param1.data;
                this.pDat.clipUrls = param1.data.clipUrls.split(",");
                this.pDat.clipByteArr = param1.data.clipBytes.split(",");
                this.pDat.clipDurArr = param1.data.clipDurations.split(",");
                _loc_6 = 0;
                while (_loc_6 < this.pDat.clipByteArr.length)
                {
                    
                    _loc_7 = this.pDat.clipByteArr[_loc_6];
                    this.pDat.clipByteArr[_loc_6] = _loc_7;
                    _loc_7 = this.pDat.clipDurArr[_loc_6];
                    this.pDat.clipDurArr[_loc_6] = _loc_7;
                    _loc_6++;
                }
                this.pDat.totBytes = param1.data.totByte;
                this.pDat.totDuration = param1.data.totDuration;
                this.pDat.keyFrameInfo = _loc_5;
                this.pDat.tvName = param1.data.videoName;
                this.pDat.clipSeekMark = [];
                _loc_8 = this.pDat.clipUrls.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_8)
                {
                    
                    this.pDat.allPlayUrl[_loc_6] = decodeURI(this.pDat.clipUrls[_loc_6]);
                    _loc_6++;
                }
                this.mainCallback(this.pDat, param3);
            }
            else
            {
                this.mainCallback("播放信息错误(#1)", param3, true);
            }
            return;
        }// end function

    }
}
