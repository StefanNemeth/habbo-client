
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;

    public class OfficialRoomEntryManager implements IDisposable 
    {

        private static const _SafeStr_4101:int = 267;
        private static const _SafeStr_4102:int = 65;
        private static const _SafeStr_4103:int = -70;

        private var _disposed:Boolean;
        private var _navigator:HabboNavigator;
        private var _SafeStr_4104:UserCountRenderer;
        private var _SafeStr_4105:PublicRoomThumbs;

        public function OfficialRoomEntryManager(_arg_1:HabboNavigator):void
        {
            this._SafeStr_4105 = new PublicRoomThumbs();
            super();
            this._navigator = _arg_1;
            this._SafeStr_4104 = new UserCountRenderer(this._navigator);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._SafeStr_4104){
                this._SafeStr_4104.dispose();
                this._SafeStr_4104 = null;
            };
            this._disposed = true;
        }
        public function OfficialRoomEntryManager(_arg_1:IWindowContainer):void
        {
            if (this._navigator.data.adRoom == null){
                return;
            };
            var _local_2:String = "ad_footer";
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.getChildByName("ad_footer"));
            var _local_4:IWindowContainer = IWindowContainer(_local_3.getChildByName("ad_cont"));
            if (_local_4.numChildren < 1){
                _local_4.addChild(this.OfficialRoomEntryManager(1));
            };
            var _local_5:IWindowContainer = IWindowContainer(_local_4.getChildAt(0));
            this.refreshEntry(_local_5, true, 1, this._navigator.data.adRoom);
            _local_3.visible = true;
            this._navigator.data.adIndex++;
        }
        public function OfficialRoomEntryManager(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("grs_official_room_row"));
            var _local_3:IWindowContainer = IWindowContainer(_local_2.findChildByName("image_cont"));
            var _local_4:String = ((((_arg_1 % 2) == 0)) ? "_b" : "");
            this._navigator.refreshButton(_local_3, ("rico_rnd_l" + _local_4), true, null, 0);
            this._navigator.refreshButton(_local_3, ("rico_rnd_r" + _local_4), true, null, 0);
            IBitmapWrapperWindow(_local_3.findChildByName("rico_rnd_m")).bitmap = this._navigator.getButtonImage("rico_rnd_m");
            var _local_5:IWindowContainer = IWindowContainer(_local_2.findChildByName("folder_cont"));
            this._navigator.refreshButton(_local_5, ("rico_rnd_l" + _local_4), true, null, 0);
            this._navigator.refreshButton(_local_5, ("rico_rnd_r" + _local_4), true, null, 0);
            IBitmapWrapperWindow(_local_5.findChildByName("rico_rnd_m")).bitmap = this._navigator.getButtonImage("rico_rnd_m");
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.OfficialRoomEntryManager);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.OfficialRoomEntryManager);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.OfficialRoomEntryManager);
            _local_2.color = this.getBgColor(_arg_1);
            return (_local_2);
        }
        public function refreshEntry(_arg_1:IWindowContainer, _arg_2:Boolean, _arg_3:int, _arg_4:OfficialRoomEntryData):void
        {
            Util.InfostandWidget(_arg_1);
            if (_arg_2){
                _arg_1.id = _arg_4.index;
                if (_arg_4.type == OfficialRoomEntryData._SafeStr_4116){
                    this.OfficialRoomEntryManager(_arg_1, _arg_4);
                }
                else {
                    this.OfficialRoomEntryManager(_arg_1, _arg_4);
                };
                _arg_1.visible = true;
            }
            else {
                _arg_1.height = 0;
                _arg_1.visible = false;
            };
        }
        private function getBgColor(_arg_1:int):uint
        {
            return (((((_arg_1 % 2))!=0) ? 0xFFFFFFFF : 4292797682));
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            this.OfficialRoomEntryManager(_arg_1, _arg_2);
            this.OfficialRoomEntryManager(_arg_1, _arg_2);
            this.refreshUserCount(_arg_1, _arg_2);
            _arg_1.height = 68;
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("folder_cont"));
            _local_3.visible = true;
            var _local_4:ITextWindow = ITextWindow(_local_3.findChildByName("folder_name_text"));
            _local_4.text = _arg_2.popupCaption;
            var _local_5:ITextWindow = ITextWindow(_local_3.findChildByName("arrow_label"));
            _local_5.text = ((_arg_2.open) ? "${navigator.folder.hide}" : "${navigator.folder.show}");
            this._navigator.refreshButton(_local_3, "arrow_down_white", _arg_2.open, null, 0);
            this._navigator.refreshButton(_local_3, "arrow_right_white", !(_arg_2.open), null, 0);
            this.OfficialRoomEntryManager(_local_3, _arg_2);
            _arg_1.height = 68;
            var _local_6:IWindowContainer = IWindowContainer(_arg_1.findChildByName("folderNameContainer"));
            if (_local_4.text == ""){
                _local_6.visible = false;
                return;
            };
            _local_6.visible = true;
            _local_6.width = (_local_4.textWidth + 20);
        }
        private function refreshUserCount(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (((_arg_2.QuestDetails) && ((((_arg_2.type == OfficialRoomEntryData._SafeStr_4125)) || ((_arg_2.type == OfficialRoomEntryData._SafeStr_4124)))))){
                _local_3 = 3;
                _local_4 = 34;
                _local_5 = 13;
                this._SafeStr_4104.refreshUserCount(_arg_2.maxUsers, _arg_1, _arg_2.userCount, "${navigator.usercounttooltip.users}", ((_arg_1.width - _local_3) - _local_4), ((_arg_1.height - _local_3) - _local_5));
            };
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("image_cont"));
            _local_3.visible = true;
            _local_3.width = ((_arg_2.QuestDetails) ? _SafeStr_4102 : _SafeStr_4101);
            this.OfficialRoomEntryManager(_local_3, _arg_2);
            this.OfficialRoomEntryManager(_local_3, _arg_2);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("picTextContainer"));
            if ((((_arg_2.picText == "")) || (_arg_2.QuestDetails))){
                _local_3.visible = false;
                return;
            };
            var _local_4:int = 5;
            _local_3.visible = true;
            var _local_5:ITextWindow = ITextWindow(_local_3.findChildByName("picText"));
            _local_5.width = (_arg_1.width - 30);
            _local_5.text = _arg_2.picText;
            _local_5.height = (_local_5.textHeight + 10);
            var _local_6 = (_local_5.textHeight > 10);
            _local_3.width = ((_local_6) ? _local_3.width = (_arg_1.width - (2 * _local_4)) : (_local_5.textWidth + 20));
            _local_3.height = (_local_5.height + 4);
            _local_3.x = ((_arg_1.width - _local_3.width) - _local_4);
            _local_3.y = ((_arg_1.height - _local_3.height) - _local_4);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("folder_image"));
            _local_3.visible = false;
            if (_arg_2.picRef != ""){
                this.OfficialRoomEntryManager(_arg_2, _local_3);
            };
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("room_image"));
            _local_3.visible = false;
            if (_arg_2.picRef != ""){
                this.OfficialRoomEntryManager(_arg_2, _local_3);
            }
            else {
                if (_arg_2.publicRoomData != null){
                    this.OfficialRoomEntryManager(_arg_1, _arg_2, _local_3);
                }
                else {
                    if (_arg_2.guestRoomData != null){
                        this.OfficialRoomEntryManager(_arg_1, _arg_2, _local_3);
                    }
                    else {
                        this.OfficialRoomEntryManager(_arg_1, _arg_2, _local_3);
                    };
                };
            };
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData, _arg_3:IBitmapWrapperWindow):void
        {
            var _local_4:String = this._SafeStr_4105.resolveRoomImageName(_arg_2);
            var _local_5:String = ((("publicSpace." + _local_4) + ".") + _arg_2.QuestDetails);
            if (_arg_3.tags[0] == _local_5){
                _arg_3.visible = true;
                return;
            };
            var _local_6 = (("officialrooms_defaults/" + _local_4) + ".png");
            Logger.log(((("Loading public room image: " + _local_6) + ", ") + _arg_2.publicRoomData.castLibs));
            _arg_3.x = ((_arg_2.QuestDetails) ? _SafeStr_4103 : 0);
            _arg_3.visible = false;
            var _local_7:OfficialRoomImageLoader = new OfficialRoomImageLoader(this._navigator, _local_6, _arg_3);
            _local_7.startLoad();
            _arg_3.tags.splice(0, _arg_3.tags.length);
            _arg_3.tags.push(_local_5);
        }
        private function OfficialRoomEntryManager(_arg_1:OfficialRoomEntryData, _arg_2:IBitmapWrapperWindow):void
        {
            var _local_3:String = ("customImage." + _arg_1.picRef);
            if (_arg_2.tags[0] == _local_3){
                _arg_2.visible = true;
                return;
            };
            Logger.log(("Loading custom image: " + _arg_1.picRef));
            _arg_2.x = 0;
            _arg_2.visible = false;
            var _local_4:OfficialRoomImageLoader = new OfficialRoomImageLoader(this._navigator, _arg_1.picRef, _arg_2);
            _local_4.startLoad();
            _arg_2.tags.splice(0, _arg_2.tags.length);
            _arg_2.tags.push(_local_3);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData, _arg_3:IBitmapWrapperWindow):void
        {
            var _local_4:String = ("guestRoom." + _arg_2.guestRoomData.thumbnail.getAsString());
            if (_arg_3.tags[0] == _local_4){
                _arg_3.visible = true;
                return;
            };
            Logger.log("Redrawing guest room image");
            _arg_3.x = 0;
            _arg_3.width = 64;
            _arg_3.bitmap = new BitmapData(64, 64);
            this._navigator.thumbRenderer.refreshBitmapContent(_arg_3.bitmap, _arg_2.guestRoomData.thumbnail);
            _arg_3.tags.splice(0, _arg_3.tags.length);
            _arg_3.tags.push(_local_4);
            _arg_3.visible = true;
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData, _arg_3:IBitmapWrapperWindow):void
        {
            var _local_4:String = "empty";
            if (_arg_3.tags[0] == _local_4){
                _arg_3.visible = true;
                return;
            };
            Logger.log("Redrawing empty image");
            _arg_3.x = 0;
            _arg_3.width = 64;
            _arg_3.bitmap = new BitmapData(64, 64, false, 4291611852);
            _arg_3.tags.splice(0, _arg_3.tags.length);
            _arg_3.tags.push(_local_4);
            _arg_3.visible = true;
        }
        private function OfficialRoomEntryManager(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            this.OfficialRoomEntryManager(_local_2, true);
        }
        private function OfficialRoomEntryManager(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            this.OfficialRoomEntryManager(_local_2, false);
        }
        private function OfficialRoomEntryManager(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            this.OfficialRoomEntryManager(_local_2);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindow, _arg_2:Boolean):void
        {
            var _local_5:IBitmapWrapperWindow;
            var _local_3:IWindowContainer = IWindowContainer(_arg_1);
            if (_local_3 == null){
                return;
            };
            var _local_4:IWindowContainer = IWindowContainer(_local_3.findChildByName("enter_room"));
            if (_local_4 == null){
                return;
            };
            if (_arg_2){
                this._navigator.refreshButton(_local_4, "enter_room_l", true, null, 0);
                this._navigator.refreshButton(_local_4, "enter_room_r", true, null, 0);
                _local_5 = IBitmapWrapperWindow(_local_4.findChildByName("enter_room_m"));
                if (_local_5.bitmap == null){
                    _local_5.bitmap = this._navigator.getButtonImage("enter_room_m");
                };
                this._navigator.refreshButton(_local_4, "enter_room_a", true, null, 0);
            };
            _local_4.visible = _arg_2;
        }
        private function OfficialRoomEntryManager(_arg_1:IWindow):void
        {
            var _local_2:OfficialRoomEntryData = this.IPlayListController(_arg_1);
            if (_local_2 == null){
                return;
            };
            Logger.log(((((((("ENTRY CLICKED: " + _local_2.picText) + ", ") + _local_2.guestRoomData) + ", ") + _local_2.publicRoomData) + ", ") + _local_2.tag));
            if (_local_2.guestRoomData != null){
                Logger.log(("ENTERING ROOM: " + _local_2.guestRoomData.flatId));
                if (_local_2.guestRoomData.doorMode == RoomSettingsFlatInfo._SafeStr_4148){
                    this._navigator.passwordInput.show(_local_2.guestRoomData);
                }
                else {
                    this._navigator.goToRoom(_local_2.guestRoomData.flatId, true);
                };
            }
            else {
                if (_local_2.tag != null){
                    Logger.log(("MAKING TAG SEARCH: " + _local_2.tag));
                    this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4151, Tabs._SafeStr_4152, _local_2.tag);
                }
                else {
                    if (_local_2.publicRoomData != null){
                        Logger.log(("ENTERING PUBLIC SPACE: " + _local_2.publicRoomData.nodeId));
                        this._navigator.send(new GetPublicSpaceCastLibsMessageComposer(_local_2.publicRoomData.nodeId));
                        this._navigator.mainViewCtrl.close();
                    }
                    else {
                        Logger.log(("FOLDER CLICKD: " + _local_2.index));
                        _local_2.OfficialRoomEntryData();
                        this._navigator.mainViewCtrl.refresh();
                    };
                };
            };
        }
        private function IPlayListController(_arg_1:IWindow):OfficialRoomEntryData
        {
            var _local_2:IWindowContainer = (_arg_1 as IWindowContainer);
            if ((((_local_2 == null)) || (!((_local_2.name == "cont"))))){
                Logger.log("Target not cont");
                return (null);
            };
            Logger.log(("PARENT NAME: " + _arg_1.parent.name));
            return ((((_local_2.parent.name == "ad_cont")) ? this.OfficialRoomEntryManager() : this.OfficialRoomEntryManager(_local_2)));
        }
        private function OfficialRoomEntryManager():OfficialRoomEntryData
        {
            return (this._navigator.data.adRoom);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer):OfficialRoomEntryData
        {
            var _local_3:OfficialRoomEntryData;
            if (this._navigator.data.officialRooms == null){
                Logger.log("No official rooms data click");
                return (null);
            };
            var _local_2:int = _arg_1.id;
            Logger.log(("Got index: " + _local_2));
            for each (_local_3 in this._navigator.data.officialRooms.entries) {
                if (_local_3.index == _local_2){
                    return (_local_3);
                };
            };
            Logger.log(((("No room found " + _local_2) + ", ") + this._navigator.data.officialRooms.entries.length));
            return (null);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("details_container"));
            _local_3.visible = _arg_2.QuestDetails;
            Logger.log(("Refreshing details: " + _local_3.visible));
            if (!_arg_2.QuestDetails){
                return;
            };
            Util.InfostandWidget(_local_3);
            this.OfficialRoomEntryManager(_local_3, _arg_2);
            this.OfficialRoomEntryManager(_local_3, _arg_2);
            Logger.log(((("Refreshed: " + _local_3.visible) + ", ") + _local_3.rectangle));
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:ITextWindow = ITextWindow(_arg_1.getChildByName("entry_caption"));
            _local_3.visible = true;
            _local_3.text = this.OfficialRoomEntryManager(_arg_2);
        }
        private function OfficialRoomEntryManager(_arg_1:IWindowContainer, _arg_2:OfficialRoomEntryData):void
        {
            var _local_3:String = this.OfficialRoomEntryManager(_arg_2);
            if (_local_3 == ""){
                return;
            };
            var _local_4:String = "entry_desc";
            var _local_5:ITextWindow = ITextWindow(_arg_1.getChildByName(_local_4));
            _local_5.text = _local_3;
            _local_5.visible = true;
        }
        public function OfficialRoomEntryManager(_arg_1:OfficialRoomEntryData):String
        {
            if (((!((_arg_1.popupCaption == null))) && (!((_arg_1.popupCaption == ""))))){
                return (_arg_1.popupCaption);
            };
            if (_arg_1.guestRoomData != null){
                return (_arg_1.guestRoomData.roomName);
            };
            if (_arg_1.publicRoomData != null){
                return (this._navigator.getPublicSpaceName(_arg_1.publicRoomData.unitPropertySet, _arg_1.publicRoomData.worldId));
            };
            if (((!((_arg_1.tag == null))) && (!((_arg_1.tag == ""))))){
                return (_arg_1.tag);
            };
            return ("NA");
        }
        public function OfficialRoomEntryManager(_arg_1:OfficialRoomEntryData):String
        {
            if (((!((_arg_1.popupCaption == null))) && (!((_arg_1.popupCaption == ""))))){
                return (_arg_1.popupDesc);
            };
            if (_arg_1.guestRoomData != null){
                return (_arg_1.guestRoomData.description);
            };
            if (_arg_1.publicRoomData != null){
                return (this._navigator.getPublicSpaceDesc(_arg_1.publicRoomData.unitPropertySet, _arg_1.publicRoomData.worldId));
            };
            return ("");
        }

    }
}//package com.sulake.habbo.navigator.mainview

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// OfficialRoomEntryManager = "_-2OM" (String#6526, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// GetPublicSpaceCastLibsMessageComposer = "_-38Z" (String#21824, DoABC#2)
// UserCountRenderer = "_-LP" (String#8111, DoABC#2)
// RoomSettingsFlatInfo = "_-0K6" (String#14847, DoABC#2)
// OfficialRoomImageLoader = "_-2Zw" (String#6758, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4101 = "_-2oM" (String#21018, DoABC#2)
// _SafeStr_4102 = "_-2dJ" (String#20576, DoABC#2)
// _SafeStr_4103 = "_-1J4" (String#17239, DoABC#2)
// _SafeStr_4104 = "_-2dY" (String#6821, DoABC#2)
// _SafeStr_4105 = "_-1Ji" (String#17265, DoABC#2)
// OfficialRoomEntryManager = "_-2qK" (String#21094, DoABC#2)
// adRoom = "_-m" (String#24110, DoABC#2)
// OfficialRoomEntryManager = "_-1v" (String#18754, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// adIndex = "_-0RB" (String#15110, DoABC#2)
// OfficialRoomEntryManager = "_-c4" (String#23716, DoABC#2)
// OfficialRoomEntryManager = "_-0qr" (String#16081, DoABC#2)
// OfficialRoomEntryManager = "_-1By" (String#16939, DoABC#2)
// getBgColor = "_-1GR" (String#600, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// _SafeStr_4116 = "_-0nP" (String#15953, DoABC#2)
// OfficialRoomEntryManager = "_-04z" (String#14240, DoABC#2)
// OfficialRoomEntryManager = "_-2AH" (String#19415, DoABC#2)
// OfficialRoomEntryManager = "_-22Y" (String#19112, DoABC#2)
// OfficialRoomEntryManager = "_-39i" (String#21872, DoABC#2)
// refreshUserCount = "_-2dF" (String#6816, DoABC#2)
// popupCaption = "_-041" (String#14202, DoABC#2)
// OfficialRoomEntryManager = "_-0rm" (String#16112, DoABC#2)
// _SafeStr_4124 = "_-2JO" (String#19784, DoABC#2)
// _SafeStr_4125 = "_-0Hh" (String#14744, DoABC#2)
// QuestDetails = "_-3H6" (String#7649, DoABC#2)
// maxUsers = "_-Rs" (String#23320, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// OfficialRoomEntryManager = "_-1lY" (String#18355, DoABC#2)
// OfficialRoomEntryManager = "_-3LA" (String#22331, DoABC#2)
// OfficialRoomEntryManager = "_-D6" (String#22733, DoABC#2)
// OfficialRoomEntryManager = "_-16J" (String#16710, DoABC#2)
// guestRoomData = "_-ab" (String#23656, DoABC#2)
// OfficialRoomEntryManager = "_-0HJ" (String#14732, DoABC#2)
// OfficialRoomEntryManager = "_-Pj" (String#23235, DoABC#2)
// resolveRoomImageName = "_-117" (String#16503, DoABC#2)
// castLibs = "_-0m9" (String#15901, DoABC#2)
// startLoad = "_-1TH" (String#17636, DoABC#2)
// getAsString = "_-3JH" (String#22254, DoABC#2)
// thumbnail = "_-02n" (String#14150, DoABC#2)
// refreshBitmapContent = "_-3Ky" (String#22320, DoABC#2)
// thumbRenderer = "_-2Ac" (String#19431, DoABC#2)
// OfficialRoomEntryManager = "_-2HZ" (String#19708, DoABC#2)
// OfficialRoomEntryManager = "_-00I" (String#14066, DoABC#2)
// IPlayListController = "_-ig" (String#2166, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4148 = "_-1IG" (String#17204, DoABC#2)
// passwordInput = "_-2kR" (String#20861, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// _SafeStr_4152 = "_-2NE" (String#19932, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// OfficialRoomEntryData = "_-1d6" (String#18017, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// OfficialRoomEntryManager = "_-0x4" (String#16315, DoABC#2)
// OfficialRoomEntryManager = "_-ac" (String#23657, DoABC#2)
// officialRooms = "_-f3" (String#23847, DoABC#2)
// entries = "_-1eU" (String#18076, DoABC#2)
// OfficialRoomEntryManager = "_-1E7" (String#17033, DoABC#2)
// OfficialRoomEntryManager = "_-0G2" (String#14685, DoABC#2)
// OfficialRoomEntryManager = "_-1r8" (String#18587, DoABC#2)
// OfficialRoomEntryManager = "_-SS" (String#23344, DoABC#2)
// getPublicSpaceName = "_-Zw" (String#23629, DoABC#2)
// unitPropertySet = "_-ix" (String#23996, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// popupDesc = "_-204" (String#19013, DoABC#2)
// getPublicSpaceDesc = "_-0-e" (String#14038, DoABC#2)


