
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;

    public class RoomVisualizationSettingsEvent extends MessageEvent 
    {

        public function RoomVisualizationSettingsEvent(_arg_1:Function)
        {
            super(_arg_1, RoomVisualizationSettingsParser);
        }
        public function getParser():RoomVisualizationSettingsParser
        {
            return ((_parser as RoomVisualizationSettingsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// RoomVisualizationSettingsEvent = "_-2ra" (String#21140, DoABC#2)
// RoomVisualizationSettingsParser = "_-1vY" (String#5952, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


