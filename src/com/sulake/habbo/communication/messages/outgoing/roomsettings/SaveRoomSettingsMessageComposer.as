
package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class SaveRoomSettingsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function SaveRoomSettingsMessageComposer(_arg_1:SaveableRoomSettingsData)
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:String;
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1.roomId);
            this._SafeStr_3708.push(_arg_1.name);
            this._SafeStr_3708.push(_arg_1.description);
            this._SafeStr_3708.push(_arg_1.doorMode);
            this._SafeStr_3708.push((((_arg_1.password)!==null) ? _arg_1.password : ""));
            this._SafeStr_3708.push(_arg_1.maximumVisitors);
            this._SafeStr_3708.push(_arg_1.categoryId);
            if (_arg_1.tags){
                _local_2 = [];
                for each (_local_3 in _arg_1.tags) {
                    if (((_local_3) && (!((_local_3 === ""))))){
                        _local_2.push(_local_3);
                    };
                };
                this._SafeStr_3708.push(_local_2.length);
                for each (_local_4 in _local_2) {
                    this._SafeStr_3708.push(_local_4);
                };
            }
            else {
                this._SafeStr_3708.push(0);
            };
            this._SafeStr_3708.push(_arg_1.allowPets);
            this._SafeStr_3708.push(_arg_1.allowFoodConsume);
            this._SafeStr_3708.push(_arg_1.allowWalkThrough);
            this._SafeStr_3708.push(_arg_1.hideWalls);
            this._SafeStr_3708.push(_arg_1.wallThickness);
            this._SafeStr_3708.push(_arg_1.floorThickness);
        }
        public function getMessageArray():Array
        {
            return (this._SafeStr_3708);
        }
        public function dispose():void
        {
            this._SafeStr_3708 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.roomsettings

// SaveRoomSettingsMessageComposer = "_-0Od" (String#15013, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// SaveableRoomSettingsData = "_-Yk" (String#8388, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// allowFoodConsume = "_-18w" (String#16812, DoABC#2)
// allowWalkThrough = "_-1aX" (String#17916, DoABC#2)
// hideWalls = "_-2O7" (String#19970, DoABC#2)
// wallThickness = "_-bn" (String#23705, DoABC#2)
// maximumVisitors = "_-1Ex" (String#17069, DoABC#2)


