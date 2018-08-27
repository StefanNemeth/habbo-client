
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.tracking.HabboTracking;

    public class MeMenuDanceView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;

        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            this._widget = _arg_1;
            this.createWindow(_arg_2);
        }
        public function dispose():void
        {
            this._widget = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        private function createWindow(_arg_1:String):void
        {
            var _local_4:IItemListWindow;
            var _local_5:XmlAsset;
            var _local_7:int;
            var _local_8:Boolean;
            var _local_9:IWindow;
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("memenu_dance") as XmlAsset);
            if (_local_2){
                this._window = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            };
            if (this._window == null){
                throw (new Error("Failed to construct dance view window from XML!"));
            };
            this._window.name = _arg_1;
            var _local_3:Array = [];
            _local_3.push(this._window.findChildByName("stop_dancing_button"));
            _local_3.push(this._window.findChildByName("back_btn"));
            for each (_local_9 in _local_3) {
                if (_local_9 != null){
                    _local_9.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                };
            };
            _local_4 = (this._window.findChildByName("buttonContainer") as IItemListWindow);
            _local_5 = (this._widget.assets.getAssetByName("memenu_dance_button") as XmlAsset);
            if (_local_4 != null){
                _local_7 = 1;
                while (_local_7 <= 4) {
                    _local_8 = false;
                    if (RoomWidgetDanceMessage._SafeStr_3578.indexOf(_local_7) >= 0){
                        _local_8 = this._widget.allowHabboClubDances;
                    }
                    else {
                        _local_8 = true;
                    };
                    if (_local_8){
                        _local_9 = (this._widget.windowManager.buildFromXML((_local_5.content as XML)) as IWindow);
                        _local_9.name = (("dance_" + _local_7) + "_button");
                        _local_9.caption = (("${widget.memenu.dance" + _local_7) + "}");
                        _local_9.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                        _local_4.addListItemAt(_local_9, (_local_4.numListItems - 1));
                        if (this._widget.hasEffectOn){
                            _local_9.disable();
                        }
                        else {
                            _local_9.enable();
                        };
                    };
                    _local_7++;
                };
            };
            var _local_6:IWindow = this._window.findChildByName("club_info");
            if (((!((_local_6 == null))) && (this._widget.isHabboClubActive))){
                _local_6.visible = false;
            };
        }
        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_3:String;
            var _local_4:Array;
            var _local_5:int;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            _local_3 = _local_2.name;
            switch (_local_3){
                case "dance_1_button":
                case "dance_2_button":
                case "dance_3_button":
                case "dance_4_button":
                    _local_4 = _local_3.split("_");
                    _local_5 = parseInt(_local_4[1]);
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(_local_5));
                    this._widget.isDancing = true;
                    this._widget.hide();
                    HabboTracking.getInstance().trackEventLog("MeMenu", "click", "dance_start");
                    return;
                case "stop_dancing_button":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage._SafeStr_3577));
                    this._widget.isDancing = false;
                    this._widget.hide();
                    HabboTracking.getInstance().trackEventLog("MeMenu", "click", "dance_stop");
                    return;
                case "back_btn":
                    this._widget.changeView(MeMenuWidget._SafeStr_3858);
                    return;
                default:
                    Logger.log(("Me Menu Dance View: unknown button: " + _local_3));
            };
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// IMeMenuView = "_-Y6" (String#8372, DoABC#2)
// MeMenuDanceView = "_-2OK" (String#6525, DoABC#2)
// RoomWidgetDanceMessage = "_-1CY" (String#5117, DoABC#2)
// _SafeStr_3577 = "_-Fb" (String#22834, DoABC#2)
// _SafeStr_3578 = "_-2CA" (String#19490, DoABC#2)
// _SafeStr_3858 = "_-1Lr" (String#17351, DoABC#2)
// changeView = "_-0hX" (String#15729, DoABC#2)
// allowHabboClubDances = "_-0HC" (String#14727, DoABC#2)
// isHabboClubActive = "_-0Ta" (String#15193, DoABC#2)
// onButtonClicked = "_-2k0" (String#247, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)


