package vrs
{

    public class PlayUrlParser extends Object
    {

        public function PlayUrlParser()
        {
            return;
        }// end function

        public function parse(param1:String, param2:int, param3:Object, param4:Function) : void
        {
            var _loc_14:Array = null;
            var _loc_5:* = /\?start=""\?start=/;
            var _loc_6:* = /http\:\/\/(.+?)\/\|([0-9]{1,4})\|(.+?)\|([^|]*)\|?([01]?)\|?([01]?)""http\:\/\/(.+?)\/\|([0-9]{1,4})\|(.+?)\|([^|]*)\|?([01]?)\|?([01]?)/;
            var _loc_7:* = _loc_5.test(param3.clipUrls[param2]);
            var _loc_8:* = param3.clipUrls[param2];
            var _loc_9:* = param3.syncUrls;
            var _loc_10:Boolean = false;
            var _loc_11:Boolean = false;
            var _loc_12:Boolean = false;
            var _loc_13:* = _loc_6.exec(param1);
            if (_loc_6.exec(param1) != null)
            {
                param1 = _loc_13[1];
            }
            if (_loc_13[5] && _loc_13[5] == "1" && _loc_9 != null && _loc_9.length > param2)
            {
                if (_loc_7)
                {
                    param1 = "http://" + param1 + _loc_9[param2] + "?" + _loc_8.split("?")[1];
                }
                else
                {
                    param1 = "http://" + param1 + _loc_9[param2];
                }
            }
            else if (_loc_13[5] && _loc_13[5] != "1" && _loc_12)
            {
                param1 = "http://" + _loc_8;
            }
            else if (_loc_13[5] && _loc_13[5] != "1" && _loc_10 && !_loc_11)
            {
                param1 = "http://" + param1;
            }
            else
            {
                _loc_14 = _loc_8.split("data.vod.itc.cn");
                if (_loc_14.length > 1 && param1 != "")
                {
                    param1 = _loc_8.replace("data.vod.itc.cn", param1);
                }
                else
                {
                    param1 = "http://" + param1 + _loc_8;
                }
            }
            if (_loc_13[4] && _loc_13[4] != "" && _loc_13[4] != "0")
            {
                if (_loc_7)
                {
                    param1 = param1 + ("&key=" + _loc_13[4]);
                }
                else
                {
                    param1 = param1 + ("?key=" + _loc_13[4]);
                }
            }
            this.param4(param2, param1);
            return;
        }// end function

    }
}
