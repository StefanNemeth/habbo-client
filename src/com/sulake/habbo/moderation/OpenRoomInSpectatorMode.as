
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class OpenRoomInSpectatorMode 
    {

        private var _help:ModerationManager;
        private var _isPublic:Boolean;
        private var _roomId:int;

        public function OpenRoomInSpectatorMode(_arg_1:ModerationManager, _arg_2:IWindow, _arg_3:Boolean, _arg_4:int)
        {
            this._help = _arg_1;
            this._isPublic = _arg_3;
            this._roomId = _arg_4;
            _arg_2.procedure = this.onClick;
        }
        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            if (this._isPublic){
                this._help.connection.send(new GetPublicSpaceCastLibsMessageComposer(this._roomId));
            }
            else {
                this._help.goToRoom(this._roomId);
            };
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// GetPublicSpaceCastLibsMessageComposer = "_-38Z" (String#21824, DoABC#2)
// OpenRoomInSpectatorMode = "_-1EF" (String#5146, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// _isPublic = "_-2nD" (String#898, DoABC#2)


