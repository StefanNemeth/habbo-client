
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.SessionParamsMessageParser;

    public class SessionParamsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SessionParamsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SessionParamsMessageParser);
        }
        public function get coppa():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).coppa);
        }
        public function get voucher():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).voucher);
        }
        public function get parentEmailRequired():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).parentEmailRequired);
        }
        public function get parentEmailRequiredInReRegistration():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).parentEmailRequiredInReRegistration);
        }
        public function get allowDirectEmail():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).allowDirectEmail);
        }
        public function get date():String
        {
            return ((this._parser as SessionParamsMessageParser).date);
        }
        public function get confPartnerIntegration():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).confPartnerIntegration);
        }
        public function get allowProfileEditing():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).allowProfileEditing);
        }
        public function get tracking_header():String
        {
            return ((this._parser as SessionParamsMessageParser).tracking_header);
        }
        public function get tutorialEnabled():Boolean
        {
            return ((this._parser as SessionParamsMessageParser).tutorialEnabled);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// SessionParamsMessageEvent = "_-J4" (String#8062, DoABC#2)
// SessionParamsMessageParser = "_-1bP" (String#5584, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// coppa = "_-3F4" (String#22080, DoABC#2)
// parentEmailRequired = "_-351" (String#21696, DoABC#2)
// parentEmailRequiredInReRegistration = "_-0Ab" (String#14473, DoABC#2)
// allowDirectEmail = "_-0oo" (String#16003, DoABC#2)
// confPartnerIntegration = "_-1ZF" (String#17863, DoABC#2)
// allowProfileEditing = "_-3Ir" (String#22232, DoABC#2)
// tracking_header = "_-0vC" (String#16245, DoABC#2)
// tutorialEnabled = "_-lq" (String#24103, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


