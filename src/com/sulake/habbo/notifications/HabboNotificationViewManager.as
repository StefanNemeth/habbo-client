
package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.toolbar.events.ExtensionViewEvent;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import flash.events.Event;

    public class HabboNotificationViewManager implements IUpdateReceiver 
    {

        private static const _SafeStr_12065:int = 4;

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_12066:Map;
        private var _SafeStr_12067:Map;
        private var _disposed:Boolean = false;
        private var _SafeStr_12068:Array;

        public function HabboNotificationViewManager(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager, _arg_3:IHabboConfigurationManager, _arg_4:IHabboToolbar, _arg_5:Map, _arg_6:Map)
        {
            this._assetLibrary = _arg_1;
            this._windowManager = _arg_2;
            this._toolbar = _arg_4;
            this._SafeStr_12066 = _arg_5;
            this._SafeStr_12067 = _arg_6;
            this._SafeStr_12068 = new Array();
            this._toolbar.events.addEventListener(ExtensionViewEvent.EVE_EXTENSION_VIEW_RESIZED, this.HabboNotificationViewManager);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function replaceIcon(_arg_1:BadgeImageReadyEvent):void
        {
            var _local_2:HabboNotificationItemView;
            for each (_local_2 in this._SafeStr_12068) {
                _local_2.replaceIcon(_arg_1);
            };
        }
        public function dispose():void
        {
            var _local_1:int = this._SafeStr_12068.length;
            var _local_2:int;
            while (_local_2 < _local_1) {
                (this._SafeStr_12068.pop() as HabboNotificationItemView).dispose();
                _local_2++;
            };
            this._assetLibrary = null;
            this._windowManager = null;
            if (this._SafeStr_12066){
                this._SafeStr_12066.dispose();
                this._SafeStr_12066 = null;
            };
            if (this._SafeStr_12067){
                this._SafeStr_12067.dispose();
                this._SafeStr_12067 = null;
            };
            this._disposed = true;
        }
        public function showItem(_arg_1:HabboNotificationItem):Boolean
        {
            if (!this.HabboNotificationViewManager()){
                return (false);
            };
            var _local_2:HabboNotificationItemView = new HabboNotificationItemView(this._assetLibrary.getAssetByName("layout_notification_xml"), this._windowManager, this._SafeStr_12066, this._SafeStr_12067, _arg_1);
            _local_2.reposition(this.HabboNotificationViewManager());
            this._SafeStr_12068.push(_local_2);
            this._SafeStr_12068.sortOn("verticalPosition", Array.NUMERIC);
            return (true);
        }
        public function HabboNotificationViewManager():Boolean
        {
            return (((this.HabboNotificationViewManager() + HabboNotificationItemView._SafeStr_12075) < this._windowManager.getDesktop(0).height));
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:HabboNotificationItemView;
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < this._SafeStr_12068.length) {
                (this._SafeStr_12068[_local_2] as HabboNotificationItemView).update(_arg_1);
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this._SafeStr_12068.length) {
                _local_3 = (this._SafeStr_12068[_local_2] as HabboNotificationItemView);
                if (_local_3.ready){
                    _local_3.dispose();
                    this._SafeStr_12068.splice(_local_2, 1);
                    _local_2--;
                };
                _local_2++;
            };
        }
        private function HabboNotificationViewManager():int
        {
            var _local_4:HabboNotificationItemView;
            var _local_1:int = (this._toolbar.extensionView.screenHeight + _SafeStr_12065);
            if (this._SafeStr_12068.length == 0){
                return (_local_1);
            };
            var _local_2:int = _local_1;
            var _local_3:int;
            while (_local_3 < this._SafeStr_12068.length) {
                _local_4 = (this._SafeStr_12068[_local_3] as HabboNotificationItemView);
                if ((_local_2 + HabboNotificationItemView._SafeStr_12075) < _local_4.verticalPosition){
                    return (_local_2);
                };
                _local_2 = ((_local_4.verticalPosition + HabboNotificationItemView._SafeStr_12075) + _SafeStr_12065);
                _local_3++;
            };
            return (_local_2);
        }
        public function HabboNotificationViewManager(_arg_1:Event):void
        {
            var _local_4:HabboNotificationItemView;
            var _local_2:int = (this._toolbar.extensionView.screenHeight + _SafeStr_12065);
            var _local_3:int;
            while (_local_3 < this._SafeStr_12068.length) {
                _local_4 = (this._SafeStr_12068[_local_3] as HabboNotificationItemView);
                _local_4.reposition(_local_2);
                _local_2 = ((_local_4.verticalPosition + HabboNotificationItemView._SafeStr_12075) + _SafeStr_12065);
                _local_3++;
            };
        }

    }
}//package com.sulake.habbo.notifications

// _SafeStr_12065 = "_-6v" (String#7804, DoABC#2)
// _SafeStr_12066 = "_-0JJ" (String#3939, DoABC#2)
// _SafeStr_12067 = "_-1F6" (String#5160, DoABC#2)
// _SafeStr_12068 = "_-1Qc" (String#17538, DoABC#2)
// HabboNotificationViewManager = "_-0KB" (String#14850, DoABC#2)
// replaceIcon = "_-1sg" (String#18663, DoABC#2)
// showItem = "_-1J5" (String#5224, DoABC#2)
// HabboNotificationViewManager = "_-0Qv" (String#15099, DoABC#2)
// reposition = "_-2Nm" (String#19956, DoABC#2)
// HabboNotificationViewManager = "_-1xF" (String#18857, DoABC#2)
// _SafeStr_12075 = "_-2sv" (String#21195, DoABC#2)
// screenHeight = "_-1sB" (String#5888, DoABC#2)
// HabboNotificationViewManager = "_-0C9" (String#3794, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// HabboNotificationItem = "_-0sR" (String#4694, DoABC#2)
// HabboNotificationItemView = "_-0Sb" (String#4151, DoABC#2)
// ExtensionViewEvent = "_-Cn" (String#22717, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// EVE_EXTENSION_VIEW_RESIZED = "_-tG" (String#24417, DoABC#2)


