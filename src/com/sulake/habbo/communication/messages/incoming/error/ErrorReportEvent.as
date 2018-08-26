
package com.sulake.habbo.communication.messages.incoming.error
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;

    public class ErrorReportEvent extends MessageEvent implements IMessageEvent 
    {

        public function ErrorReportEvent(_arg_1:Function)
        {
            super(_arg_1, ErrorReportMessageParser);
        }
        public function getParser():ErrorReportMessageParser
        {
            return ((this._parser as ErrorReportMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.error

// ErrorReportMessageParser = "_-2xv" (String#7238, DoABC#2)
// ErrorReportEvent = "_-0WW" (String#4237, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


