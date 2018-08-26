
package com.sulake.habbo.sound.object
{
    import com.sulake.habbo.sound.IHabboSound;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.events.Event;
    import flash.media.SoundTransform;

    public class HabboSound implements IHabboSound 
    {

        private var _soundObject:Sound = null;
        private var _SafeStr_4030:SoundChannel = null;
        private var _volume:Number;
        private var _complete:Boolean;

        public function HabboSound(_arg_1:Sound)
        {
            this._soundObject = _arg_1;
            this._soundObject.addEventListener(Event.COMPLETE, this.SocketConnection);
            this._volume = 1;
            this._complete = false;
        }
        public function play(_arg_1:Number=0):Boolean
        {
            this._complete = false;
            this._SafeStr_4030 = this._soundObject.play(0);
            this.volume = this._volume;
            return (true);
        }
        public function stop():Boolean
        {
            this._SafeStr_4030.stop();
            return (true);
        }
        public function get volume():Number
        {
            return (this._volume);
        }
        public function set volume(_arg_1:Number):void
        {
            this._volume = _arg_1;
            if (this._SafeStr_4030 != null){
                this._SafeStr_4030.soundTransform = new SoundTransform(this._volume);
            };
        }
        public function get position():Number
        {
            return (this._SafeStr_4030.position);
        }
        public function set position(_arg_1:Number):void
        {
        }
        public function get length():Number
        {
            return (this._soundObject.length);
        }
        public function get ready():Boolean
        {
            return (!(this._soundObject.isBuffering));
        }
        public function get finished():Boolean
        {
            return (!(this._complete));
        }
        public function get fadeOutSeconds():Number
        {
            return (0);
        }
        public function set fadeOutSeconds(_arg_1:Number):void
        {
        }
        public function get fadeInSeconds():Number
        {
            return (0);
        }
        public function set fadeInSeconds(_arg_1:Number):void
        {
        }
        private function SocketConnection(_arg_1:Event):void
        {
            this._complete = true;
        }

    }
}//package com.sulake.habbo.sound.object

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// HabboSound = "_-1YJ" (String#5525, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// _soundObject = "_-kf" (String#8618, DoABC#2)
// _SafeStr_4030 = "_-FQ" (String#7980, DoABC#2)
// SocketConnection = "_-2qX" (String#7085, DoABC#2)
// finished = "_-28w" (String#6223, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// fadeInSeconds = "_-2FB" (String#6346, DoABC#2)


