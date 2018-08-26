
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailRenderer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RoomPopupCtrl extends PopupCtrl 
    {

        private var _SafeStr_12043:IWindowContainer;
        private var _room:GuestRoomData;
        private var _thumbRenderer:RoomThumbnailRenderer;
        private var _SafeStr_4206:TagRenderer;

        public function RoomPopupCtrl(_arg_1:HabboNavigator, _arg_2:int, _arg_3:int)
        {
            super(_arg_1, _arg_2, _arg_3, "grs_guest_room_details_long");
            this._thumbRenderer = new RoomThumbnailRenderer(_arg_1);
            this._SafeStr_4206 = new TagRenderer(_arg_1, PopupCtrl);
        }
        public function set room(_arg_1:GuestRoomData):void
        {
            this._room = _arg_1;
        }
        override public function refreshContent(_arg_1:IWindowContainer):void
        {
            if (this._SafeStr_12043 == null){
                this._SafeStr_12043 = IWindowContainer(_arg_1.findChildByName("details_container"));
            };
            this._SafeStr_12043.visible = true;
            Util.InfostandWidget(this._SafeStr_12043);
            this.refreshRoomName(this._SafeStr_12043, this._room);
            if (((!((this._room.ownerName == ""))) && (!((this._room.ownerName == "-"))))){
            };
            this.refreshOwnerName();
            this.refreshTextWithCaption("roomctg", this._SafeStr_12043, ((this._room.event) ? this.getEventCtg(this._room.categoryId) : this.getRoomCtg(this._room.categoryId)));
            this.refreshRoomDesc(this._SafeStr_12043, this._room);
            this.refreshExtraCont();
            this.refreshInfo(this._SafeStr_12043, "trading_allowed", this._room.allowTrading);
            this.refreshInfo(this._SafeStr_12043, "doormode_doorbell", (this._room.doorMode == 1));
            this.refreshInfo(this._SafeStr_12043, "doormode_password", (this._room.doorMode == 2));
            Util.moveChildrenToColumn(this._SafeStr_12043, ["roomname", "roomctg_cont", "roomowner_cont", "roomdesc", "extra_cont", "doormode_doorbell", "doormode_password", "trading_allowed"], 0, 0);
            this._SafeStr_12043.height = Util.getLowestPoint(this._SafeStr_12043);
        }
        private function refreshOwnerName():void
        {
            this.refreshTextWithCaption("roomowner", this._SafeStr_12043, this._room.ownerName);
            var _local_1:ITextWindow = ITextWindow(this._SafeStr_12043.findChildByName("roomowner"));
            if (((!((this._room.ownerName == ""))) && (!((this._room.ownerName == "-"))))){
                _local_1.procedure = this.onOwnerName;
                _local_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
                _local_1.underline = true;
            }
            else {
                _local_1.procedure = null;
                _local_1.setParamFlag(HabboWindowParam._SafeStr_3731, false);
                _local_1.underline = false;
            };
        }
        private function refreshExtraCont():void
        {
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_12043.findChildByName("extra_cont"));
            Util.InfostandWidget(_local_1);
            this._SafeStr_4206.refreshTags(_local_1, this._room.tags);
            this.refreshTextWithCaption("rating", _local_1, ("" + this._room.score));
            if (this._room.event){
                this.refreshTextWithCaption("startedat", _local_1, ("" + this._room.eventCreationTime));
            };
            this._thumbRenderer.refreshThumbnail(_local_1, this._room.thumbnail, false);
            _local_1.findChildByName("bitmap").visible = true;
            _local_1.visible = true;
        }
        private function refreshRoomName(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            var _local_3:ITextWindow = ITextWindow(_arg_1.getChildByName("roomname"));
            _local_3.visible = true;
            _local_3.text = _arg_2.roomName;
            _local_3.height = (_local_3.textHeight + 3);
        }
        private function refreshRoomDesc(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            if (_arg_2.description == ""){
                return;
            };
            var _local_3:String = "roomdesc";
            var _local_4:ITextWindow = ITextWindow(_arg_1.getChildByName(_local_3));
            _local_4.text = _arg_2.description;
            _local_4.height = (_local_4.textHeight + 10);
            _local_4.y = Util.getLowestPoint(_arg_1);
            _local_4.visible = true;
        }
        private function refreshTextWithCaption(_arg_1:String, _arg_2:IWindowContainer, _arg_3:String):void
        {
            var _local_4:IWindowContainer = IWindowContainer(_arg_2.findChildByName((_arg_1 + "_cont")));
            _local_4.visible = true;
            var _local_5:ITextWindow = ITextWindow(_local_4.getChildByName(_arg_1));
            var _local_6:ITextWindow = ITextWindow(_local_4.getChildByName((_arg_1 + ".caption")));
            _local_5.text = _arg_3;
            Util.moveChildrenToRow(_local_4, [(_arg_1 + ".caption"), _arg_1], _local_6.x, 0, 2);
        }
        private function refreshInfo(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            if (!_arg_3){
                return;
            };
            var _local_4:IWindowContainer = IWindowContainer(_arg_1.findChildByName(_arg_2));
            _local_4.visible = true;
            navigator.refreshButton(_local_4, _arg_2, true, null, 0);
        }
        private function getEventCtg(_arg_1:int):String
        {
            var _local_2:String = ("roomevent_type_" + _arg_1);
            var _local_3:String = navigator.getText(_local_2);
            return ((((_local_3 == null)) ? "" : _local_3));
        }
        private function getRoomCtg(_arg_1:int):String
        {
            var _local_2:FlatCategory;
            for each (_local_2 in navigator.data.allCategories) {
                if (_local_2.nodeId == _arg_1){
                    return (_local_2.nodeName);
                };
            };
            return ("");
        }
        private function onOwnerName(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:ITextWindow = ITextWindow(_arg_2);
            if (_local_3 != null){
                navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4151, Tabs._SafeStr_4306, _local_3.text);
                this.PopupCtrl();
            };
        }

    }
}//package com.sulake.habbo.navigator

// refreshContent = "_-2Ec" (String#19590, DoABC#2)
// onOwnerName = "_-tN" (String#8757, DoABC#2)
// _thumbRenderer = "_-PV" (String#8194, DoABC#2)
// _SafeStr_12043 = "_-1Nj" (String#17426, DoABC#2)
// refreshOwnerName = "_-Oc" (String#23191, DoABC#2)
// refreshTextWithCaption = "_-19M" (String#16830, DoABC#2)
// getEventCtg = "_-08M" (String#14378, DoABC#2)
// getRoomCtg = "_-1jY" (String#18268, DoABC#2)
// refreshRoomDesc = "_-oX" (String#24215, DoABC#2)
// refreshExtraCont = "_-33U" (String#21641, DoABC#2)
// refreshInfo = "_-3JG" (String#22253, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// RoomThumbnailRenderer = "_-3Kq" (String#7719, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// TagRenderer = "_-35E" (String#7412, DoABC#2)
// PopupCtrl = "_-0f4" (String#818, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// thumbnail = "_-02n" (String#14150, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// refreshRoomName = "_-gr" (String#8530, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// PopupCtrl = "_-DX" (String#22750, DoABC#2)
// _SafeStr_4206 = "_-2ux" (String#901, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// _SafeStr_4306 = "_-1Y7" (String#17819, DoABC#2)
// refreshThumbnail = "_-04K" (String#14216, DoABC#2)
// allowTrading = "_-0ZL" (String#15416, DoABC#2)
// _room = "_-1eJ" (String#1732, DoABC#2)
// eventCreationTime = "_-0mp" (String#15932, DoABC#2)
// nodeName = "_-2F3" (String#19606, DoABC#2)
// refreshTags = "_-0s5" (String#16127, DoABC#2)
// moveChildrenToRow = "_-0xS" (String#16331, DoABC#2)


