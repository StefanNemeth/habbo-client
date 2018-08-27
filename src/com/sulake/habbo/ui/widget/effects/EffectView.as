
package com.sulake.habbo.ui.widget.effects
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class EffectView 
    {

        private const _SafeStr_8063:int = 1000;

        private var _widget:EffectsWidget;
        private var _window:IWindowContainer;
        private var _effect:IWidgetAvatarEffect;
        private var _SafeStr_8065:IWindow;
        private var _maxWidth:Number;
        private var _SafeStr_8067:ITextWindow;
        private var _SafeStr_5297:Timer;
        private var _SafeStr_8068:IWindow;

        public function EffectView(_arg_1:EffectsWidget, _arg_2:IWidgetAvatarEffect)
        {
            this._effect = _arg_2;
            this._widget = _arg_1;
            this._SafeStr_5297 = new Timer(this._SafeStr_8063);
            this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.onUpdate);
            this.update();
        }
        public function get effect():IWidgetAvatarEffect
        {
            return (this._effect);
        }
        public function dispose():void
        {
            if (this._SafeStr_5297 != null){
                this._SafeStr_5297.stop();
                this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this._SafeStr_5297 = null;
            };
            this._widget = null;
            this._effect = null;
            this._SafeStr_8065 = null;
            this._SafeStr_8067 = null;
            this._SafeStr_8068 = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        private function onUpdate(_arg_1:Event=null):void
        {
            var _local_2:Number;
            if (this._SafeStr_8065 == null){
                this._SafeStr_5297.stop();
                return;
            };
            if (this._effect.isActive){
                _local_2 = (this._effect.secondsLeft / Number(this._effect.duration));
                this._SafeStr_8065.width = (_local_2 * this._maxWidth);
            }
            else {
                this._SafeStr_8065.width = 0;
                this._SafeStr_5297.stop();
            };
            this.setTimeLeft();
        }
        private function setTimeLeft():void
        {
            var _local_1:String;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            if (this._SafeStr_8067 == null){
                this._SafeStr_8067 = (this._window.findChildByName("time_left") as ITextWindow);
                if (this._SafeStr_8067 == null){
                    return;
                };
            };
            if (!this._effect.isActive){
                this._SafeStr_8067.caption = "${widgets.memenu.effects.activate}";
                return;
            };
            if (this._effect.secondsLeft > ((60 * 60) * 24)){
                this._SafeStr_8067.caption = "${widgets.memenu.effects.active.daysleft}";
                _local_1 = this._SafeStr_8067.text;
                _local_2 = Math.floor((this._effect.secondsLeft / ((60 * 60) * 24)));
                _local_1 = _local_1.replace("%days_left%", _local_2);
            }
            else {
                this._SafeStr_8067.caption = "${widgets.memenu.effects.active.timeleft}";
                _local_1 = this._SafeStr_8067.text;
                _local_3 = this._effect.secondsLeft;
                _local_4 = Math.floor((_local_3 / (60 * 60)));
                _local_5 = (Math.floor((_local_3 / 60)) % 60);
                _local_6 = (_local_3 % 60);
                _local_7 = (((_local_4)<10) ? "0" : "");
                _local_8 = (((_local_5)<10) ? "0" : "");
                _local_9 = (((_local_6)<10) ? "0" : "");
                if (_local_4 > 0){
                    _local_1 = _local_1.replace("%time_left%", (((((((_local_7 + _local_4) + ":") + _local_8) + _local_5) + ":") + _local_9) + _local_6));
                }
                else {
                    _local_1 = _local_1.replace("%time_left%", ((((_local_8 + _local_5) + ":") + _local_9) + _local_6));
                };
            };
            this._SafeStr_8067.text = _local_1;
        }
        public function update():void
        {
            var _local_1:XmlAsset;
            var _local_7:IWindow;
            var _local_8:IButtonWindow;
            if (!this._window){
                this._window = (this._widget.windowManager.createWindow("", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_6023) as IWindowContainer);
            };
            while (this._window.numChildren > 0) {
                _local_7 = this._window.removeChildAt(0);
                _local_7.dispose();
            };
            this._SafeStr_8065 = null;
            this._SafeStr_8068 = null;
            this._SafeStr_8067 = null;
            var _local_2:String = "";
            if (this._effect.isInUse){
                _local_2 = "memenu_effect_selected";
            }
            else {
                if (this._effect.isActive){
                    _local_2 = "memenu_effect_unselected";
                }
                else {
                    _local_2 = "memenu_effect_inactive";
                };
            };
            _local_1 = (this._widget.assets.getAssetByName(_local_2) as XmlAsset);
            var _local_3:IWindowContainer = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            this._window.addChild(_local_3);
            var _local_4:ITextWindow = (this._window.findChildByName("effect_name") as ITextWindow);
            if (_local_4 != null){
                _local_4.caption = ((("$" + "{fx_") + this._effect.type) + "}");
            };
            var _local_5:ITextWindow = (this._window.findChildByName("effect_amount") as ITextWindow);
            if (_local_5 != null){
                _local_5.caption = (this._effect.effectsInInventory + "");
            };
            var _local_6:IWindowContainer = (this._window.findChildByName("effect_amount_bg1") as IWindowContainer);
            if (this._effect.effectsInInventory < 2){
                if (_local_6 != null){
                    _local_6.visible = false;
                };
            };
            if (_local_2 == "memenu_effect_inactive"){
                _local_8 = (this._window.findChildByName("activate_effect") as IButtonWindow);
                if (_local_8 != null){
                    _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                };
            }
            else {
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                if (this._effect.isActive){
                    _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseEvent);
                    _local_3.addEventListener(WindowMouseEvent.WME_OUT, this.onMouseEvent);
                };
                if (this._effect.isInUse){
                    this.setElementImage("effect_hilite", "memenu_fx_pause");
                }
                else {
                    this.setElementImage("effect_hilite", "memenu_fx_play");
                };
                this._SafeStr_8068 = this._window.findChildByName("effect_hilite");
                this._SafeStr_8068.visible = false;
            };
            this.setTimeLeft();
            this._SafeStr_8065 = this._window.findChildByName("loader_bar");
            if (this._SafeStr_8065 != null){
                this._maxWidth = this._SafeStr_8065.width;
                this._SafeStr_5297.start();
                this.onUpdate();
            };
            if (this._effect.icon){
                this.setElementBitmap("effect_icon", this._effect.icon);
            };
            this._window.rectangle = _local_3.rectangle;
        }
        private function setElementBitmap(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 != null){
                if (_local_3.bitmap){
                    _local_3.bitmap.dispose();
                };
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            }
            else {
                Logger.log(("Could not find element: " + _arg_1));
            };
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    if (this._SafeStr_8068 != null){
                        this._SafeStr_8068.visible = true;
                    };
                    return;
                case WindowMouseEvent.WME_OUT:
                    if (this._SafeStr_8068 != null){
                        this._SafeStr_8068.visible = false;
                    };
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    this._widget.selectEffect(this._effect.type, this._effect.isInUse);
                    return;
            };
        }
        private function setElementImage(_arg_1:String, _arg_2:String):void
        {
            var _local_3:BitmapDataAsset = (this._widget.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            this.setElementBitmap(_arg_1, _local_4);
        }

    }
}//package com.sulake.habbo.ui.widget.effects

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// EffectsWidget = "_-ds" (String#8482, DoABC#2)
// IWidgetAvatarEffect = "_-uw" (String#8782, DoABC#2)
// EffectView = "_-2Nv" (String#6520, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// effectsInInventory = "_-0U0" (String#4183, DoABC#2)
// secondsLeft = "_-I-" (String#8040, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// effect = "_-rk" (String#24350, DoABC#2)
// selectEffect = "_-0yR" (String#16370, DoABC#2)
// _SafeStr_8063 = "_-7v" (String#22540, DoABC#2)
// _effect = "_-22d" (String#6099, DoABC#2)
// _SafeStr_8065 = "_-27f" (String#19317, DoABC#2)
// _maxWidth = "_-0vf" (String#1578, DoABC#2)
// _SafeStr_8067 = "_-3I-" (String#22202, DoABC#2)
// _SafeStr_8068 = "_-2KV" (String#19822, DoABC#2)
// onUpdate = "_-Ck" (String#2075, DoABC#2)
// setTimeLeft = "_-0iH" (String#15763, DoABC#2)
// setElementBitmap = "_-TW" (String#23386, DoABC#2)


