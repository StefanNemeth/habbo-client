
package com.sulake.habbo.communication.messages.incoming.room.camera
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.camera.CameraSnapshotMessageParser;

    public class CameraSnapshotMessageEvent extends MessageEvent 
    {

        public function CameraSnapshotMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CameraSnapshotMessageParser);
        }
        public function getParser():CameraSnapshotMessageParser
        {
            return ((_parser as CameraSnapshotMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.camera

// CameraSnapshotMessageEvent = "_-2fh" (String#20680, DoABC#2)
// CameraSnapshotMessageParser = "_-8v" (String#7840, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


