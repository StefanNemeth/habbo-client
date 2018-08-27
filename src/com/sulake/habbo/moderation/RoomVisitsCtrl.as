
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomVisitsCtrl implements IDisposable, TrackedWindow 
    {

        private static var _SafeStr_11860:Array = [];
        private static var _SafeStr_11861:int = 200;

        private var _help:ModerationManager;
        private var _frame:IFrameWindow;
        private var _content:IItemListWindow;
        private var _userId:int;
        private var _rooms:Array;
        private var _disposed:Boolean;
        private var _SafeStr_11862:IWindowContainer;
        private var _SafeStr_4247:Timer;
        private var _SafeStr_11863:Array;

        public function RoomVisitsCtrl(_arg_1:ModerationManager, _arg_2:int)
        {
            this._SafeStr_11863 = [];
            super();
            this._help = _arg_1;
            this._userId = _arg_2;
        }
        public static function getFormattedTime(_arg_1:int, _arg_2:int):String
        {
            return (((padToTwoDigits(_arg_1) + ":") + padToTwoDigits(_arg_2)));
        }
        public static function padToTwoDigits(_arg_1:int):String
        {
            return ((((_arg_1 < 10)) ? ("0" + _arg_1) : ("" + _arg_1)));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._SafeStr_11862 = IWindowContainer(this._help.getXmlWindow("roomvisits_row"));
            this._SafeStr_4247 = new Timer(300, 1);
            this._SafeStr_4247.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
            this._help.messageHandler.addRoomVisitsListener(this);
            this._help.connection.send(new GetRoomVisitsMessageComposer(this._userId));
            this._frame = IFrameWindow(this._help.getXmlWindow("roomvisits_frame"));
            this._content = IItemListWindow(this._frame.findChildByName("visits_list"));
            this._frame.procedure = this.onWindow;
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.onClose;
        }
        public function onRoomVisits(_arg_1:RoomVisitsData):void
        {
            if (_arg_1.userId != this._userId){
                return;
            };
            if (this._disposed){
                return;
            };
            this._rooms = _arg_1.rooms;
            this._frame.caption = ("Room visits: " + _arg_1.userName);
            this.populate();
            this.onResizeTimer(null);
            this._frame.visible = true;
            this._help.messageHandler.removeRoomVisitsListener(this);
        }
        public function getType():int
        {
            return (WindowTracker._SafeStr_11795);
        }
        public function getId():String
        {
            return (("" + this._userId));
        }
        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }
        private function populate():void
        {
            var _local_2:RoomVisitData;
            var _local_1:Boolean = true;
            for each (_local_2 in this._rooms) {
                this.populateRoomRow(_local_2, _local_1);
                _local_1 = !(_local_1);
            };
        }
        private function populateRoomRow(_arg_1:RoomVisitData, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = this.getRoomRowWindow();
            var _local_4:uint = ((_arg_2) ? 4288861930 : 0xFFFFFFFF);
            _local_3.color = _local_4;
            var _local_5:IWindow = _local_3.findChildByName("room_name_txt");
            _local_5.caption = _arg_1.roomName;
            new OpenRoomTool(this._frame, this._help, _local_5, _arg_1.isPublic, _arg_1.roomId);
            _local_5.color = _local_4;
            var _local_6:ITextWindow = ITextWindow(_local_3.findChildByName("time_txt"));
            _local_6.text = getFormattedTime(_arg_1.enterHour, _arg_1.enterMinute);
            var _local_7:ITextWindow = ITextWindow(_local_3.findChildByName("view_room_txt"));
            new OpenRoomInSpectatorMode(this._help, _local_7, _arg_1.isPublic, _arg_1.roomId);
            _local_7.color = _local_4;
            this.addRoomRowToList(_local_3, this._content);
        }
        private function addRoomRowToList(_arg_1:IWindowContainer, _arg_2:IItemListWindow):void
        {
            _arg_2.addListItem(_arg_1);
            this._SafeStr_11863.push(_arg_1);
        }
        private function getRoomRowWindow():IWindowContainer
        {
            if (_SafeStr_11860.length > 0){
                return ((_SafeStr_11860.pop() as IWindowContainer));
            };
            return (IWindowContainer(this._SafeStr_11862.clone()));
        }
        private function storeRoomRowWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            var _local_3:IWindow;
            if (_SafeStr_11860.length < _SafeStr_11861){
                _local_2 = _arg_1.findChildByName("room_name_txt");
                _local_2.procedure = null;
                _local_3 = _arg_1.findChildByName("view_room_txt");
                _local_3.procedure = null;
                _arg_1.width = this._SafeStr_11862.width;
                _arg_1.height = this._SafeStr_11862.height;
                _SafeStr_11860.push(_arg_1);
            }
            else {
                _arg_1.dispose();
            };
        }
        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
        }
        private function onWindow(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!((_arg_1.type == WindowEvent.WE_RESIZED))) || (!((_arg_2 == this._frame))))){
                return;
            };
            if (!this._SafeStr_4247.running){
                this._SafeStr_4247.reset();
                this._SafeStr_4247.start();
            };
        }
        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            var _local_2:IWindowContainer = IWindowContainer(this._content.parent);
            var _local_3:IWindow = (_local_2.getChildByName("scroller") as IWindow);
            var _local_4 = (this._content.scrollableRegion.height > this._content.height);
            var _local_5:int = 17;
            if (_local_3.visible){
                if (!_local_4){
                    _local_3.visible = false;
                    this._content.width = (this._content.width + _local_5);
                };
            }
            else {
                if (_local_4){
                    _local_3.visible = true;
                    this._content.width = (this._content.width - _local_5);
                };
            };
        }
        public function dispose():void
        {
            var _local_1:IWindowContainer;
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._content != null){
                this._content.removeListItems();
                this._content.dispose();
                this._content = null;
            };
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            this._help = null;
            if (this._SafeStr_4247 != null){
                this._SafeStr_4247.stop();
                this._SafeStr_4247.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                this._SafeStr_4247 = null;
            };
            for each (_local_1 in this._SafeStr_11863) {
                this.storeRoomRowWindow(_local_1);
            };
            if (this._SafeStr_11862 != null){
                this._SafeStr_11862.dispose();
                this._SafeStr_11862 = null;
            };
            this._SafeStr_11863 = [];
        }

    }
}//package com.sulake.habbo.moderation

// onWindow = "_-1zg" (String#873, DoABC#2)
// _help = "_-3HG" (String#114, DoABC#2)
// onRoomVisits = "_-hX" (String#8545, DoABC#2)
// addRoomVisitsListener = "_-2Zz" (String#20439, DoABC#2)
// removeRoomVisitsListener = "_-0DH" (String#14580, DoABC#2)
// _SafeStr_11795 = "_-1mM" (String#18393, DoABC#2)
// messageHandler = "_-2T6" (String#20168, DoABC#2)
// getFormattedTime = "_-1qM" (String#18557, DoABC#2)
// _SafeStr_11860 = "_-2Sh" (String#20145, DoABC#2)
// _SafeStr_11861 = "_-TZ" (String#23389, DoABC#2)
// _SafeStr_11862 = "_-2Lu" (String#19880, DoABC#2)
// _SafeStr_11863 = "_-2gp" (String#20722, DoABC#2)
// padToTwoDigits = "_-0Oo" (String#15018, DoABC#2)
// populateRoomRow = "_-HN" (String#22907, DoABC#2)
// getRoomRowWindow = "_-34i" (String#21685, DoABC#2)
// addRoomRowToList = "_-0d5" (String#15552, DoABC#2)
// storeRoomRowWindow = "_-3J3" (String#22242, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// GetRoomVisitsMessageComposer = "_-1AB" (String#16866, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// RoomVisitsCtrl = "_-2rD" (String#7106, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// OpenRoomTool = "_-2Kg" (String#6457, DoABC#2)
// OpenRoomInSpectatorMode = "_-1EF" (String#5146, DoABC#2)
// RoomVisitsData = "_-0EM" (String#3834, DoABC#2)
// RoomVisitData = "_-0MU" (String#4011, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// _SafeStr_4247 = "_-0RI" (String#586, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// isPublic = "_-2lD" (String#20891, DoABC#2)
// _rooms = "_-36o" (String#456, DoABC#2)
// enterHour = "_-0oR" (String#15992, DoABC#2)
// enterMinute = "_-0DZ" (String#14591, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)


