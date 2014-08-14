package vsin.dcw.support.net
{
    import flash.net.*;

    public class RequestDat extends Object
    {
        public var url:String;
        public var isSucc:Function;
        public var bindDat:Object;
        public var promise:Promise;
        public var name:String;
        public var beforeParsing:Function;
        public var timeout:int = 5;
        public var datType:String = "JSON";
        public var avoidRetryRspType:Array;
        public var vars:URLVariables;

        public function RequestDat()
        {
            this.avoidRetryRspType = [Request.RSP_TYPE.IO_ERR, Request.RSP_TYPE.DAT_ERR, Request.RSP_TYPE.DAT_PARSE_ERR, Request.RSP_TYPE.SECURITY_ERR];
            return;
        }// end function

    }
}
