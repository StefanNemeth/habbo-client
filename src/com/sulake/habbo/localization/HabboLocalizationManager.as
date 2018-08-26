
package com.sulake.habbo.localization
{
    import com.sulake.core.localization.CoreLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Dictionary;
    import com.sulake.habbo.localization.enum.HabboLocalizationFlags;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.assets.TextAsset;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.localization.enum.LocalizationEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.iid.*;

    public class HabboLocalizationManager extends CoreLocalizationManager implements IHabboLocalizationManager 
    {

        private static var _SafeStr_10847:String = "%";

        private var _configuration:IHabboConfigurationManager;
        private var _SafeStr_11690:Boolean = false;
        private var _SafeStr_11691:Dictionary;
        private var _SafeStr_11692:Array;

        public function HabboLocalizationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._SafeStr_11691 = new Dictionary();
            this._SafeStr_11692 = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX"];
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_11690 = ((_arg_2 & HabboLocalizationFlags._SafeStr_7918) > 0);
            if (!this._SafeStr_11690){
                lock();
            };
            queueInterface(new IIDHabboConfigurationManager(), this.HabboSoundManagerFlash10);
            var _local_4:TextAsset = (_arg_3.getAssetByName("default_localization") as TextAsset);
            parseLocalizationData(_local_4.content.toString());
        }
        override public function dispose():void
        {
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            super.dispose();
        }
        public function getKeyWithParams(_arg_1:String, _arg_2:Dictionary=null, _arg_3:String=""):String
        {
            var _local_4:String = getKey(_arg_1);
            if (_arg_2 != null){
                _local_4 = this.fillParams(_local_4, _arg_2);
            };
            return (_local_4);
        }
        private function fillParams(_arg_1:String, _arg_2:Dictionary):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_3:int;
            while (_local_3 < 10) {
                _local_4 = _arg_1.indexOf(_SafeStr_10847);
                if (_local_4 < 0) break;
                _local_5 = _arg_1.indexOf(_SafeStr_10847, (_local_4 + 1));
                if (_local_5 < 0) break;
                _local_6 = _arg_1.substring((_local_4 + 1), _local_5);
                _local_7 = _arg_2[_local_6];
                _arg_1 = _arg_1.replace((("%" + _local_6) + "%"), _local_7);
                _local_3++;
            };
            return (_arg_1);
        }
        private function showKeys(_arg_1:IAlertDialog, _arg_2:*):void
        {
            _arg_1.dispose();
            printNonExistingKeys();
        }
        private function HabboSoundManagerFlash10(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:String;
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            if (_arg_2 != null){
                this._configuration = (_arg_2 as IHabboConfigurationManager);
                _local_3 = "";
                _local_3 = this._configuration.getKey("url.prefix", _local_3);
                _local_3 = _local_3.replace("http://", "");
                _local_3 = _local_3.replace("https://", "");
                super.setPredefinedUrl(_local_3);
                if (!this._SafeStr_11690){
                    if ("false" == this._configuration.getKey("use.default.localizations", "false")){
                        _local_5 = this._configuration.getKey("external.texts.txt", "external_texts.txt");
                        events.addEventListener(LocalizationEvent.LOCALIZATION_EVENT_LOCALIZATION_LOADED, this.onLocalizationLoaded);
                        super.loadLocalizationFromURL(_local_5);
                    };
                };
                _local_4 = 1;
                while (this._configuration.keyExists(("localization." + _local_4))) {
                    _local_6 = this._configuration.getKey(("localization." + _local_4), "");
                    _local_7 = this._configuration.getKey((("localization." + _local_4) + ".name"), "");
                    _local_8 = this._configuration.getKey((("localization." + _local_4) + ".url"), "");
                    super.registerLocalizationDefinition(_local_6, _local_7, _local_8);
                    _local_4++;
                };
            };
        }
        public function onLocalizationLoaded(_arg_1:Event):void
        {
            var _local_2:String;
            events.removeEventListener(LocalizationEvent.LOCALIZATION_EVENT_LOCALIZATION_LOADED, this.onLocalizationLoaded);
            if (this._configuration.keyExists("external.override.texts.txt")){
                _local_2 = this._configuration.getKey("external.override.texts.txt");
                events.addEventListener(LocalizationEvent.LOCALIZATION_EVENT_LOCALIZATION_LOADED, this.onLocalizationOverrideLoaded);
                super.loadLocalizationFromURL(_local_2);
            }
            else {
                unlock();
            };
        }
        public function onLocalizationOverrideLoaded(_arg_1:Event):void
        {
            events.removeEventListener(LocalizationEvent.LOCALIZATION_EVENT_LOCALIZATION_LOADED, this.onLocalizationOverrideLoaded);
            unlock();
        }
        private function checkDefaultKeys():void
        {
            var _local_6:String;
            var _local_1:TextAsset = (assets.getAssetByName("keys_in_use") as TextAsset);
            var _local_2:String = _local_1.content.toString();
            var _local_3:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _local_4:RegExp = /^\s+|\s+$/g;
            var _local_5:Array = _local_2.split(_local_3);
            for each (_local_6 in _local_5) {
                if (_local_6.substr(0, 1) != "#"){
                    if (_local_6.length != 0){
                        if (getLocalization(_local_6) == null){
                            Logger.log(_local_6);
                        };
                    };
                };
            };
        }
        public function getAchievementDescForFacebook(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int):String
        {
            return (this.getAchievementTextForFacebook("badge_desc_fb_", _arg_1, _arg_2, _arg_3, _arg_4));
        }
        public function getAchievementNameForFacebook(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int):String
        {
            return (this.getAchievementTextForFacebook("badge_name_fb_", _arg_1, _arg_2, _arg_3, _arg_4));
        }
        private function getAchievementTextForFacebook(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int):String
        {
            var _local_6:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_2);
            var _local_7:String = this.getExistingKey([(_arg_1 + _arg_2), (_arg_1 + _local_6.base)]);
            registerParameter(_local_7, "roman", this.getRomanNumeral(_local_6.level));
            registerParameter(_local_7, "level", _arg_5.toString());
            registerParameter(_local_7, "name", _arg_3);
            registerParameter(_local_7, "limit", ("" + this.getBadgePointLimit(_arg_2)));
            return (registerParameter(_local_7, "realname", _arg_4));
        }
        public function getAchievementName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_3:String = this.getExistingKey([("badge_name_al_" + _arg_1), ("badge_name_al_" + _local_2.base), ("badge_name_" + _arg_1), ("badge_name_" + _local_2.base)]);
            this.registerParameter(_local_3, "roman", this.getRomanNumeral(_local_2.level));
            return (this.getKey(_local_3));
        }
        public function getAchievementDesc(_arg_1:String, _arg_2:int):String
        {
            var _local_3:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_4:String = this.getExistingKey([("badge_desc_al_" + _arg_1), ("badge_desc_al_" + _local_3.base), ("badge_desc_" + _arg_1), ("badge_desc_" + _local_3.base)]);
            this.registerParameter(_local_4, "limit", ("" + _arg_2));
            return (this.getKey(_local_4));
        }
        public function getBadgeBaseName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            return (_local_2.base);
        }
        public function getBadgeName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_3:String = this.getExistingKey([("badge_name_" + _arg_1), ("badge_name_" + _local_2.base)]);
            this.registerParameter(_local_3, "roman", this.getRomanNumeral(_local_2.level));
            return (this.getKey(_local_3));
        }
        public function getBadgeDesc(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_3:String = this.getExistingKey([("badge_desc_" + _arg_1), ("badge_desc_" + _local_2.base)]);
            this.registerParameter(_local_3, "limit", ("" + this.getBadgePointLimit(_arg_1)));
            return (this.getKey(_local_3));
        }
        public function getPreviousLevelBadgeId(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            _local_2.level--;
            return (_local_2.badgeId);
        }
        public function setBadgePointLimit(_arg_1:String, _arg_2:int):void
        {
            this._SafeStr_11691[_arg_1] = _arg_2;
        }
        private function getBadgePointLimit(_arg_1:String):int
        {
            return (this._SafeStr_11691[_arg_1]);
        }
        private function getExistingKey(_arg_1:Array):String
        {
            var _local_2:String;
            var _local_3:String;
            for each (_local_2 in _arg_1) {
                _local_3 = this.getKey(_local_2);
                if (_local_3 != ""){
                    return (_local_2);
                };
            };
            return (_arg_1[0]);
        }
        private function getRomanNumeral(_arg_1:int):String
        {
            return (this._SafeStr_11692[Math.max(0, (_arg_1 - 1))]);
        }
        override protected function onLocalizationFailed(_arg_1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("external_texts download error " + _arg_1.status));
            super.onLocalizationFailed(_arg_1);
        }

    }
}//package com.sulake.habbo.localization

// IID = "_-3KV" (String#7712, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// HabboSoundManagerFlash10 = "_-1NP" (String#851, DoABC#2)
// _SafeStr_10847 = "_-1ja" (String#5746, DoABC#2)
// fillParams = "_-0Ij" (String#3929, DoABC#2)
// setBadgePointLimit = "_-0HA" (String#3898, DoABC#2)
// _SafeStr_11690 = "_-1zs" (String#18963, DoABC#2)
// _SafeStr_11691 = "_-sr" (String#24396, DoABC#2)
// _SafeStr_11692 = "_-16N" (String#16713, DoABC#2)
// getKeyWithParams = "_-2gI" (String#6875, DoABC#2)
// showKeys = "_-2ha" (String#20757, DoABC#2)
// onLocalizationLoaded = "_-1Rv" (String#17579, DoABC#2)
// onLocalizationOverrideLoaded = "_-Ek" (String#22803, DoABC#2)
// checkDefaultKeys = "_-1pS" (String#18522, DoABC#2)
// getAchievementDescForFacebook = "_-37y" (String#7469, DoABC#2)
// getAchievementTextForFacebook = "_-1Aw" (String#16898, DoABC#2)
// getAchievementNameForFacebook = "_-1o6" (String#5818, DoABC#2)
// getExistingKey = "_-oN" (String#24208, DoABC#2)
// getRomanNumeral = "_-31M" (String#21552, DoABC#2)
// getBadgePointLimit = "_-Pf" (String#23233, DoABC#2)
// getAchievementDesc = "_-2qD" (String#7083, DoABC#2)
// getBadgeBaseName = "_-25N" (String#6149, DoABC#2)
// getPreviousLevelBadgeId = "_-2Kq" (String#6459, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// LocalizationEvent = "_-01S" (String#1388, DoABC#2)
// HabboLocalizationFlags = "_-2ep" (String#6847, DoABC#2)
// BadgeBaseAndLevel = "_-0k5" (String#4502, DoABC#2)
// TextAsset = "_-0HX" (String#14738, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// CoreLocalizationManager = "_-19t" (String#5076, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// LOCALIZATION_EVENT_LOCALIZATION_LOADED = "_-0nu" (String#15973, DoABC#2)
// _SafeStr_7918 = "_-0Y7" (String#15362, DoABC#2)
// registerLocalizationDefinition = "_-00S" (String#3573, DoABC#2)
// loadLocalizationFromURL = "_-rj" (String#8731, DoABC#2)
// parseLocalizationData = "_-2Sn" (String#20151, DoABC#2)
// printNonExistingKeys = "_-0jT" (String#4489, DoABC#2)
// setPredefinedUrl = "_-0yr" (String#16385, DoABC#2)


