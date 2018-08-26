
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class OpenRoomTool 
    {

        private var _frame:IFrameWindow;
        private var _help:ModerationManager;
        private var _isPublic:Boolean;
        private var _roomId:int;

        public function OpenRoomTool(_arg_1:IFrameWindow, _arg_2:ModerationManager, _arg_3:IWindow, _arg_4:Boolean, _arg_5:int)
        {
            this._frame = _arg_1;
            this._help = _arg_2;
            this._isPublic = _arg_4;
            this._roomId = _arg_5;
            _arg_3.procedure = this.onClick;
        }
        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            if (this._isPublic){
                this._help.windowManager.alert("Alert", "Room tool is not available for public spaces. Public spaces can be moderated using in-room chat moderation commands.", 0, this.SessionDataManager);
            }
            else {
                this._help.windowTracker.show(new RoomToolCtrl(this._help, this._roomId), this._frame, false, false, true);
            };
        }
        private function SessionDataManager(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// SessionDataManager = "_-34G" (String#309, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// RoomToolCtrl = "_-0Tu" (String#4178, DoABC#2)
// OpenRoomTool = "_-2Kg" (String#6457, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// _isPublic = "_-2nD" (String#898, DoABC#2)


