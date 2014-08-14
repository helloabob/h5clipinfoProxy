package vsin.dcw.support
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.globalization.*;

    public class Tools extends Object
    {

        public function Tools()
        {
            return;
        }// end function

        public static function random(param1:int) : int
        {
            return Math.random() * param1 >> 0;
        }// end function

        public static function objLen(param1:Object) : int
        {
            var _loc_3:String = null;
            var _loc_2:int = 0;
            for (_loc_3 in param1)
            {
                
                _loc_2++;
            }
            return _loc_2;
        }// end function

        public static function getRelativeUrl(param1:Stage) : String
        {
            var _loc_2:* = param1.loaderInfo.loaderURL;
            var _loc_3:* = _loc_2.split("/");
            _loc_3.pop();
            _loc_2 = _loc_3.join("/");
            return _loc_2;
        }// end function

        public static function simpleEvtSendOut(param1:Sprite, param2:String) : void
        {
            var _loc_3:* = new Event(param2, true);
            param1.dispatchEvent(_loc_3);
            return;
        }// end function

        public static function trim(param1:String) : String
        {
            var _loc_2:* = /^(　|\s|\	t)*""^(　|\s|\t)*/gi;
            var _loc_3:* = /(　|\s|\	t)*$""(　|\s|\t)*$/gi;
            param1 = param1.replace(_loc_2, "");
            param1 = param1.replace(_loc_3, "");
            return param1;
        }// end function

        public static function shorten(param1:String, param2:int, param3:String) : String
        {
            if (byteLength(param1) <= param2)
            {
                return param1;
            }
            if (param3 != "")
            {
                param3 = param3 || "...";
            }
            else
            {
                param3 = "";
            }
            return leftB(param1, param2 - byteLength(param3)) + param3;
        }// end function

        public static function formatTime(param1:Number) : String
        {
            var _loc_2:* = new DateTimeFormatter("zh_CN");
            if (param1 > 3600)
            {
                param1 = param1 - 3600 * 8;
                _loc_2.setDateTimePattern("kk:mm:ss");
            }
            else
            {
                _loc_2.setDateTimePattern("mm:ss");
            }
            return _loc_2.format(new Date(param1 * 1000));
        }// end function

        public static function formatInt(param1:int) : String
        {
            var _loc_2:* = new NumberFormatter(LocaleID.DEFAULT);
            _loc_2.trailingZeros = false;
            return _loc_2.formatNumber(param1);
        }// end function

        public static function scaleImg(param1:DisplayObject, param2:Number, param3:Number) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            if (param1 is Loader)
            {
                _loc_4 = (param1 as Loader).contentLoaderInfo.width;
                _loc_5 = (param1 as Loader).contentLoaderInfo.height;
            }
            else if (param1 is DisplayObject)
            {
                _loc_4 = param1.width;
                _loc_5 = param1.height;
            }
            var _loc_6:* = Math.max(param2 / _loc_4, param3 / _loc_5);
            param1.width = param1.width * _loc_6;
            param1.height = param1.height * _loc_6;
            return;
        }// end function

        public static function getDisplayObjSnap(param1:DisplayObject) : BitmapData
        {
            var _loc_2:BitmapData = null;
            var _loc_3:* = new Sprite();
            _loc_3.addChild(param1);
            var _loc_4:* = param1.getBounds(_loc_3);
            var _loc_5:* = new Point(param1.x, param1.y);
            param1.x = _loc_5.x - _loc_4.x;
            param1.y = _loc_5.y - _loc_4.y;
            _loc_2 = new BitmapData(_loc_4.width, _loc_4.height, true, 16777215);
            _loc_2.draw(_loc_3);
            param1.x = _loc_5.x;
            param1.y = _loc_5.y;
            _loc_3 = null;
            return _loc_2;
        }// end function

        public static function isFullScr(param1:Stage) : Boolean
        {
            return param1.displayState === StageDisplayState.FULL_SCREEN;
        }// end function

        private static function byteLength(param1:String) : int
        {
            if ("string" == "undefined")
            {
                return 0;
            }
            var _loc_2:* = param1.match(/[^\;
            return param1.length + (!_loc_2 ? (0) : (_loc_2.length));
        }// end function

        private static function leftB(param1:String, param2:int) : String
        {
            var _loc_3:* = param1.replace(/\*""\*/g, " ").replace(/[^\;
            param1 = param1.slice(0, _loc_3.slice(0, param2).replace(/\*\*""\*\*/g, " ").replace(/\*""\*/g, "").length);
            if (byteLength(param1) > param2)
            {
                param1 = param1.slice(0, (param1.length - 1));
            }
            return param1;
        }// end function

    }
}
