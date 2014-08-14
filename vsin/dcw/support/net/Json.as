package vsin.dcw.support.net
{
    import flash.utils.*;

    public class Json extends Object
    {
        public static var JSON_CLS:Class = getDefinitionByName("JSON") as Class;

        public function Json()
        {
            return;
        }// end function

        public static function parse(param1:String) : Object
        {
            var _loc_2:* = JSON_CLS;
            return _loc_2.JSON_CLS["parse"](param1);
        }// end function

        public static function stringify(param1:Object) : String
        {
            var _loc_2:* = JSON_CLS;
            return _loc_2.JSON_CLS["stringify"](param1);
        }// end function

        public static function parseObjInArr(param1:String) : Array
        {
            var obj:Object;
            var tmp:String;
            var stupidString:* = param1;
            var reg:* = new RegExp("({.+?})", "g");
            var arr:* = stupidString.match(reg);
            var result:Array;
            var fakeJsonKeyReg:* = new RegExp("([{,])(.+?)([:])", "g");
            var _loc_3:int = 0;
            var _loc_4:* = arr;
            while (_loc_4 in _loc_3)
            {
                
                tmp = _loc_4[_loc_3];
                tmp = tmp.replace(fakeJsonKeyReg, function (param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : String
            {
                if (param3.match(/[""'']""["']/))
                {
                    return param2 + "" + param3 + "" + param4;
                }
                return param2 + "\"" + param3 + "\"" + param4;
            }// end function
            );
                obj = parse(tmp);
                result.push(obj);
            }
            return result;
        }// end function

    }
}
