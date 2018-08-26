
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SessionParamsMessageParser implements IMessageParser 
    {

        protected var _coppa:Boolean;
        protected var _voucher:Boolean;
        protected var _date:String;
        protected var _parentEmailRequired:Boolean;
        protected var _parentEmailRequiredInReRegistration:Boolean;
        protected var _allowDirectEmail:Boolean;
        protected var _confPartnerIntegration:Boolean;
        protected var _allowProfileEditing:Boolean;
        protected var _tracking_header:String;
        protected var _tutorialEnabled:Boolean;

        public function flush():Boolean
        {
            this._coppa = false;
            this._voucher = false;
            this._date = "";
            this._parentEmailRequired = false;
            this._parentEmailRequiredInReRegistration = false;
            this._allowDirectEmail = false;
            this._confPartnerIntegration = false;
            this._allowProfileEditing = false;
            this._tracking_header = "";
            this._tutorialEnabled = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_2:int = _arg_1.readInteger();
            Logger.log((("[Parser.SessionParams] Got " + _local_2) + " pairs"));
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                Logger.log(("[Parser.SessionParams] Got id: " + _local_4));
                switch (_local_4){
                    case 0:
                        _local_5 = _arg_1.readInteger();
                        this._coppa = (_local_5 > 0);
                        break;
                    case 1:
                        _local_5 = _arg_1.readInteger();
                        this._voucher = (_local_5 > 0);
                        break;
                    case 2:
                        _local_5 = _arg_1.readInteger();
                        this._parentEmailRequired = (_local_5 > 0);
                        break;
                    case 3:
                        _local_5 = _arg_1.readInteger();
                        this._parentEmailRequiredInReRegistration = (_local_5 > 0);
                        break;
                    case 4:
                        _local_5 = _arg_1.readInteger();
                        this._allowDirectEmail = (_local_5 > 0);
                        break;
                    case 5:
                        _local_6 = _arg_1.readString();
                        break;
                    case 6:
                        _local_5 = _arg_1.readInteger();
                        break;
                    case 7:
                        _local_5 = _arg_1.readInteger();
                        break;
                    case 8:
                        _local_7 = _arg_1.readString();
                        break;
                    case 9:
                        _local_5 = _arg_1.readInteger();
                        break;
                    default:
                        Logger.log(("Unknown id: " + _local_4));
                };
                _local_3++;
            };
            return (true);
        }
        public function get coppa():Boolean
        {
            return (this._coppa);
        }
        public function get voucher():Boolean
        {
            return (this._voucher);
        }
        public function get parentEmailRequired():Boolean
        {
            return (this._parentEmailRequired);
        }
        public function get parentEmailRequiredInReRegistration():Boolean
        {
            return (this._parentEmailRequiredInReRegistration);
        }
        public function get allowDirectEmail():Boolean
        {
            return (this._allowDirectEmail);
        }
        public function get date():String
        {
            return (this._date);
        }
        public function get confPartnerIntegration():Boolean
        {
            return (this._confPartnerIntegration);
        }
        public function get allowProfileEditing():Boolean
        {
            return (this._allowProfileEditing);
        }
        public function get tracking_header():String
        {
            return (this._tracking_header);
        }
        public function get tutorialEnabled():Boolean
        {
            return (this._tutorialEnabled);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SessionParamsMessageParser = "_-1bP" (String#5584, DoABC#2)
// coppa = "_-3F4" (String#22080, DoABC#2)
// parentEmailRequired = "_-351" (String#21696, DoABC#2)
// parentEmailRequiredInReRegistration = "_-0Ab" (String#14473, DoABC#2)
// allowDirectEmail = "_-0oo" (String#16003, DoABC#2)
// confPartnerIntegration = "_-1ZF" (String#17863, DoABC#2)
// allowProfileEditing = "_-3Ir" (String#22232, DoABC#2)
// tracking_header = "_-0vC" (String#16245, DoABC#2)
// tutorialEnabled = "_-lq" (String#24103, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _coppa = "_-0hs" (String#15742, DoABC#2)
// _voucher = "_-1br" (String#17966, DoABC#2)
// _date = "_-1Dw" (String#1636, DoABC#2)
// _parentEmailRequired = "_-0rQ" (String#16101, DoABC#2)
// _parentEmailRequiredInReRegistration = "_-0zc" (String#16412, DoABC#2)
// _allowDirectEmail = "_-2dt" (String#20597, DoABC#2)
// _allowProfileEditing = "_-0Qx" (String#15100, DoABC#2)
// _tracking_header = "_-3JV" (String#22264, DoABC#2)
// _tutorialEnabled = "_-17W" (String#16755, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


