
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.OpenLockerRoomMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ExitLockerRoomMessageComposer;

    public class LidoHandler extends BaseHandler 
    {

        public function LidoHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new OpenLockerRoomMessageEvent(this.onOpenLockerRoom));
        }
        private function onOpenLockerRoom(_arg_1:OpenLockerRoomMessageEvent):void
        {
            if ((((_arg_1 == null)) || ((connection == null)))){
                return;
            };
            connection.send(new ExitLockerRoomMessageComposer());
        }

    }
}//package com.sulake.habbo.session.handler

// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// LidoHandler = "_-23B" (String#6108, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// ExitLockerRoomMessageComposer = "_-2Rr" (String#20112, DoABC#2)
// OpenLockerRoomMessageEvent = "_-2yd" (String#21415, DoABC#2)
// onOpenLockerRoom = "_-1iV" (String#18227, DoABC#2)


