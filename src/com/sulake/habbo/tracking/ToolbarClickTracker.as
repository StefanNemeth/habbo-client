
package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class ToolbarClickTracker 
    {

        private var _SafeStr_13789:IHabboTracking;
        private var _enabled:Boolean = false;
        private var _SafeStr_13790:int = 0;
        private var _SafeStr_13791:int = 0;

        public function ToolbarClickTracker(_arg_1:IHabboTracking)
        {
            this._SafeStr_13789 = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_13789 = null;
        }
        public function FramerateTracker(_arg_1:IHabboConfigurationManager):void
        {
            this._enabled = Boolean(parseInt(_arg_1.getKey("toolbar.tracking.enabled", "1")));
            this._SafeStr_13790 = parseInt(_arg_1.getKey("toolbar.tracking.max.events", "100"));
        }
        public function track(_arg_1:String):void
        {
            if (!this._enabled){
                return;
            };
            this._SafeStr_13791++;
            if (this._SafeStr_13791 <= this._SafeStr_13790){
                this._SafeStr_13789.trackGoogle("toolbar", _arg_1);
            };
        }

    }
}//package com.sulake.habbo.tracking

// _SafeStr_13789 = "_-2HY" (String#6395, DoABC#2)
// _SafeStr_13790 = "_-3-B" (String#21468, DoABC#2)
// _SafeStr_13791 = "_-1Mo" (String#17392, DoABC#2)
// FramerateTracker = "_-2eD" (String#20612, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// _enabled = "_-38q" (String#2010, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// ToolbarClickTracker = "_-0ke" (String#15854, DoABC#2)
// track = "_-0H4" (String#3897, DoABC#2)


