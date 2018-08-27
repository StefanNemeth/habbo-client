
package com.sulake.habbo.utils
{
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    public class HabboWebTools 
    {

        public static const _SafeStr_4572:String = "advertisement";

        public static function logEventLog(_arg_1:String):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.logEventLog", _arg_1);
            };
        }
        public static function openWebPage(_arg_1:String, _arg_2:String=""):void
        {
            var _local_4:String;
            if ((((_arg_2 == null)) || ((_arg_2 == "")))){
                _arg_2 = _SafeStr_4572;
            };
            var _local_3:URLRequest = new URLRequest(_arg_1);
            if (!ExternalInterface.available){
                navigateToURL(_local_3, _arg_2);
            }
            else {
                _local_4 = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
                if (_local_4.indexOf("firefox") >= 0){
                    ExternalInterface.call("window.open", _local_3.url, _arg_2);
                }
                else {
                    if (_local_4.indexOf("msie") >= 0){
                        ExternalInterface.call((((("function setWMWindow() {window.open('" + _local_3.url) + "', '") + _arg_2) + "');}"));
                    }
                    else {
                        navigateToURL(_local_3, _arg_2);
                    };
                };
            };
        }
        public static function navigateToURL(_arg_1:String, _arg_2:String=null):void
        {
            var _local_3:URLRequest = new URLRequest(_arg_1);
            navigateToURL(_local_3, _arg_2);
        }
        public static function openExternalLinkWarning(_arg_1:String):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.openExternalLink", escape(_arg_1));
            }
            else {
                Logger.log(("External interface not available. Could not request to open: " + _arg_1));
            };
        }
        public static function facebookLike(_arg_1:int):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.fbLike", _arg_1);
            }
            else {
                Logger.log("External interface not available. Could not request Facebook like view.");
            };
        }
        public static function facebookAchievementPost(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.postAchievementShareBonus", _arg_1, _arg_2, _arg_3, _arg_4);
            }
            else {
                Logger.log("External interface not available. Could not request Facebook achievement post view.");
            };
        }
        public static function facebookViralGiftPost(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.postXmasViral", _arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            }
            else {
                Logger.log("External interface not available. Could not request Facebook viral post view.");
            };
        }
        public static function roomVisited(_arg_1:int):void
        {
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.roomVisited", _arg_1);
            }
            else {
                Logger.log("External interface not available. Could not store last room visit.");
            };
        }

    }
}//package com.sulake.habbo.utils

// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// openWebPage = "_-27c" (String#6194, DoABC#2)
// _SafeStr_4572 = "_-1Ii" (String#17223, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// openExternalLinkWarning = "_-9C" (String#22588, DoABC#2)
// facebookLike = "_-2nq" (String#20993, DoABC#2)
// facebookAchievementPost = "_-I1" (String#22930, DoABC#2)
// facebookViralGiftPost = "_-0s0" (String#16123, DoABC#2)
// roomVisited = "_-1bz" (String#17970, DoABC#2)


