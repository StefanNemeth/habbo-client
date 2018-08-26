
package com.sulake.habbo.session.handler
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEffectsHandler extends BaseHandler 
    {

        public function AvatarEffectsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
        }
        private function onAvatarEffects(_arg_1:IMessageEvent):void
        {
            var _local_2:AvatarEffectsMessageEvent = (_arg_1 as AvatarEffectsMessageEvent);
            var _local_3:AvatarEffectsMessageParser = (_local_2.getParser() as AvatarEffectsMessageParser);
            Logger.log(("Received active avatar effects: " + _local_3.effects));
            if (((listener) && (listener.events))){
            };
        }

    }
}//package com.sulake.habbo.session.handler

// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// AvatarEffectsMessageParser = "_-2m-" (String#20918, DoABC#2)
// AvatarEffectsMessageEvent = "_-2SA" (String#6610, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// onAvatarEffects = "_-33k" (String#7381, DoABC#2)


