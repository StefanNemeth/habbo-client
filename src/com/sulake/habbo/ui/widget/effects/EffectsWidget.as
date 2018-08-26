
package com.sulake.habbo.ui.widget.effects
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.catalog.enum.CatalogPageName;

    public class EffectsWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_8057:int = 320;
        private static const _SafeStr_8058:int = 48;
        private static const _SafeStr_8059:int = 2;

        private var _view:IWindowContainer;
        private var _content:IScrollableListWindow;
        private var _SafeStr_8060:Map;

        public function EffectsWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.handler.widget = this;
            this._SafeStr_8060 = new Map();
        }
        public function get handler():EffectsWidgetHandler
        {
            return ((_handler as EffectsWidgetHandler));
        }
        override public function dispose():void
        {
            var _local_1:EffectView;
            if (disposed){
                return;
            };
            if (this._SafeStr_8060){
                for each (_local_1 in this._SafeStr_8060) {
                    _local_1.dispose();
                };
                this._SafeStr_8060.dispose();
                this._SafeStr_8060 = null;
            };
            this._content = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            super.dispose();
        }
        public function open():void
        {
            var _local_1:XmlAsset;
            var _local_2:Rectangle;
            var _local_3:IWindow;
            if (!this._view){
                _local_1 = (assets.getAssetByName("effects_widget") as XmlAsset);
                this._view = (windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
                _local_2 = this.handler.container.toolbar.getRect();
                this._view.x = (_local_2.right + _SafeStr_8059);
                this._view.y = (_local_2.bottom - this._view.height);
                this._content = (this._view.findChildByName("list") as IScrollableListWindow);
                _local_3 = this._view.findChildByName("close");
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
                _local_3 = this._view.findChildByName("get_more");
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.EffectsWidget);
            };
            this.update();
            this._view.visible = true;
        }
        public function update():void
        {
            var _local_1:EffectView;
            var _local_3:IWidgetAvatarEffect;
            var _local_4:int;
            var _local_2:Array = this.handler.container.inventory.HabboInventory();
            for each (_local_3 in _local_2) {
                _local_1 = (this._SafeStr_8060.getValue(_local_3.type) as EffectView);
                if (_local_1){
                    _local_1.update();
                }
                else {
                    _local_1 = new EffectView(this, _local_3);
                    this._SafeStr_8060.add(_local_3.type, _local_1);
                    this._content.addListItem(_local_1.window);
                };
            };
            _local_4 = (this._SafeStr_8060.length - 1);
            while (_local_4 >= 0) {
                _local_1 = this._SafeStr_8060.getWithIndex(_local_4);
                if (_local_2.indexOf(_local_1.effect) == -1){
                    this._content.removeListItem(_local_1.window);
                    this._SafeStr_8060.remove(this._SafeStr_8060.getKey(_local_4));
                    _local_1.dispose();
                };
                _local_4--;
            };
            var _local_5:int = this._content.scrollableRegion.height;
            this._content.height = Math.max(Math.min(_local_5, _SafeStr_8057), _SafeStr_8058);
            this._view.findChildByName("no_effects").visible = (_local_2.length == 0);
        }
        public function EffectsWidget(_arg_1:int, _arg_2:Boolean):void
        {
            if (_arg_2){
                this.handler.container.inventory.HabboInventory(_arg_1);
            }
            else {
                this.handler.container.inventory.HabboInventory(_arg_1);
            };
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this._view.visible = false;
        }
        private function EffectsWidget(_arg_1:WindowMouseEvent):void
        {
            this.handler.container.catalog.openCatalogPage(CatalogPageName._SafeStr_6005, true);
        }

    }
}//package com.sulake.habbo.ui.widget.effects

// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// EffectsWidget = "_-ds" (String#8482, DoABC#2)
// IScrollableListWindow = "_-337" (String#7369, DoABC#2)
// IWidgetAvatarEffect = "_-uw" (String#8782, DoABC#2)
// EffectsWidgetHandler = "_-0V2" (String#4206, DoABC#2)
// EffectView = "_-2Nv" (String#6520, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// _SafeStr_6005 = "_-25o" (String#19251, DoABC#2)
// HabboInventory = "_-aN" (String#2133, DoABC#2)
// HabboInventory = "_-1Ct" (String#1634, DoABC#2)
// HabboInventory = "_-2rY" (String#1952, DoABC#2)
// effect = "_-rk" (String#24350, DoABC#2)
// _SafeStr_8057 = "_-1Hg" (String#17177, DoABC#2)
// _SafeStr_8058 = "_-2Tj" (String#20189, DoABC#2)
// _SafeStr_8059 = "_-0wH" (String#16283, DoABC#2)
// _SafeStr_8060 = "_-0dl" (String#15574, DoABC#2)
// EffectsWidget = "_-0Wm" (String#15308, DoABC#2)
// EffectsWidget = "_-0yR" (String#16370, DoABC#2)


