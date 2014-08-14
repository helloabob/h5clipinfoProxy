package 
{
    import flash.display.*;
    import flash.external.*;
    import flash.system.*;
    import hot.*;
    import ugc.*;
    import vrs.*;

    public class h5clipinfoProxy extends Sprite
    {
        private var jsInfoReturnPath:String;
        private var jsHotspotReturnPath:String;
        private var jsErrReturnPath:String;

        public function h5clipinfoProxy()
        {
            Security.allowDomain("*");
            ExternalInterface.addCallback("start", this.start);
            ExternalInterface.addCallback("getHotspot", this.getHotspot);
            ExternalInterface.addCallback("ver", this.getVer);
            ExternalInterface.call(stage.loaderInfo.parameters.readypath);
            return;
        }// end function

        private function start(param1:String, param2:String, param3:String, param4:int, param5:String) : void
        {
            this.jsErrReturnPath = param3;
            this.jsInfoReturnPath = param2;
            if (param4 == 1)
            {
                new GetPlayInfo(param1, this.getPlayInfoCallback, param5);
            }
            else if (param4 == 2)
            {
                new GetPlayInfoUgc(param1, this.getPlayInfoCallback, param5);
            }
            else
            {
                this.getPlayInfoCallback("视频类型错误", param5, true);
            }
            return;
        }// end function

        private function getHotspot(param1:String, param2:String, param3:String) : void
        {
            this.jsHotspotReturnPath = param2;
            new GetHotSpot(param1, this.getHotspotCallback, param3);
            return;
        }// end function

        private function getPlayInfoCallback(param1:Object, param2:String, param3:Boolean = false) : void
        {
            if (param3)
            {
                ExternalInterface.call(this.jsErrReturnPath, param1, param2);
            }
            else
            {
                ExternalInterface.call(this.jsInfoReturnPath, param1, param2);
            }
            return;
        }// end function

        private function getHotspotCallback(param1:Object, param2:String) : void
        {
            ExternalInterface.call(this.jsHotspotReturnPath, param1, param2);
            return;
        }// end function

        private function getVer() : String
        {
            return "1.7";
        }// end function

    }
}
