
package com.sulake.habbo.help.tutorial
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class TutorialMainView implements ITutorialUIView 
    {

        private var _help:TutorialUI;

        public function TutorialMainView(_arg_1:IItemListWindow, _arg_2:TutorialUI):void
        {
            var _local_6:IWindow;
            super();
            this._help = _arg_2;
            var _local_3:IWindowContainer = (_arg_2.buildXmlWindow("tutorial_front_page") as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            _local_3.procedure = this.TutorialMainView;
            var _local_4:IItemListWindow = (_local_3.findChildByName("button_list") as IItemListWindow);
            var _local_5:int;
            _local_6 = _local_3.findChildByName("container_name");
            if (this._help.hasChangedName){
                _local_4.removeListItem(_local_6);
            }
            else {
                this.TutorialMainView(_local_3.findChildByName("button_name"));
                _local_5 = (_local_5 + _local_6.width);
            };
            _local_6 = _local_3.findChildByName("container_looks");
            if (this._help.hasChangedLooks){
                _local_4.removeListItem(_local_6);
            }
            else {
                this.TutorialMainView(_local_3.findChildByName("button_looks"));
                _local_5 = (_local_5 + _local_6.width);
            };
            _local_6 = _local_3.findChildByName("container_guidebot");
            if (((this._help.hasCalledGuideBot) || (!(((this._help.hasChangedName) || (this._help.hasChangedLooks)))))){
                _local_4.removeListItem(_local_6);
            }
            else {
                this.TutorialMainView(_local_3.findChildByName("button_guidebot"));
                _local_5 = (_local_5 + _local_6.width);
            };
            _local_4.width = _local_5;
            _local_6 = _local_3.findChildByName("name_field");
            _local_6.caption = this._help.myName;
            _arg_1.addListItem((_local_3 as IWindow));
        }
        public function get view():IWindowContainer
        {
            return (null);
        }
        public function get id():String
        {
            return (TutorialUI.TUI_MAIN_VIEW);
        }
        public function dispose():void
        {
        }
        private function TutorialMainView(_arg_1:IWindow):void
        {
            var _local_3:BitmapDataAsset;
            var _local_2:IBitmapWrapperWindow = (_arg_1 as IBitmapWrapperWindow);
            switch (_arg_1.name){
                case "button_name":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_changename"));
                    break;
                case "button_looks":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_changelooks"));
                    break;
                case "button_guidebot":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_guidebot"));
                    break;
            };
            if (((((!((_local_2 == null))) && (!((_local_3 == null))))) && (!((_local_3.content == null))))){
                _local_2.bitmap = (_local_3.content as BitmapData).clone();
            };
        }
        private function TutorialMainView(_arg_1:IWindow):void
        {
            var _local_3:BitmapDataAsset;
            var _local_2:IBitmapWrapperWindow = (_arg_1 as IBitmapWrapperWindow);
            switch (_arg_1.name){
                case "button_name":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_changename_over"));
                    break;
                case "button_looks":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_changelooks_over"));
                    break;
                case "button_guidebot":
                    _local_3 = BitmapDataAsset(this._help.assets.getAssetByName("tutorial_button_guidebot_over"));
                    break;
            };
            if (((((!((_local_2 == null))) && (!((_local_3 == null))))) && (!((_local_3.content == null))))){
                _local_2.bitmap = (_local_3.content as BitmapData).clone();
            };
        }
        private function TutorialMainView(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_2.name){
                case "button_looks":
                    switch (_arg_1.type){
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this._help.HabboInventory(TutorialUI.TUI_CLOTHES_VIEW);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.TutorialMainView(_arg_2);
                            break;
                        case WindowMouseEvent.WME_OUT:
                            this.TutorialMainView(_arg_2);
                            break;
                    };
                    return;
                case "button_name":
                    switch (_arg_1.type){
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this._help.HabboInventory(TutorialUI.TUI_NAME_VIEW);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.TutorialMainView(_arg_2);
                            break;
                        case WindowMouseEvent.WME_OUT:
                            this.TutorialMainView(_arg_2);
                            break;
                    };
                    return;
                case "button_guidebot":
                    switch (_arg_1.type){
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this._help.HabboInventory(TutorialUI.TUI_GUIDEBOT_VIEW);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.TutorialMainView(_arg_2);
                            break;
                        case WindowMouseEvent.WME_OUT:
                            this.TutorialMainView(_arg_2);
                            break;
                    };
                    return;
            };
        }

    }
}//package com.sulake.habbo.help.tutorial

// _help = "_-3HG" (String#114, DoABC#2)
// myName = "_-0Kp" (String#3971, DoABC#2)
// TUI_NAME_VIEW = "_-146" (String#16621, DoABC#2)
// TUI_MAIN_VIEW = "_-0CO" (String#14545, DoABC#2)
// TUI_CLOTHES_VIEW = "_-2a" (String#20440, DoABC#2)
// TUI_GUIDEBOT_VIEW = "_-0n" (String#15938, DoABC#2)
// TutorialMainView = "_-1tK" (String#869, DoABC#2)
// TutorialMainView = "_-7" (String#22499, DoABC#2)
// TutorialMainView = "_-Yr" (String#23594, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// TutorialUI = "_-38o" (String#7488, DoABC#2)
// ITutorialUIView = "_-2tN" (String#7145, DoABC#2)
// TutorialMainView = "_-yd" (String#8850, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// hasChangedLooks = "_-32V" (String#21597, DoABC#2)
// hasCalledGuideBot = "_-l6" (String#24074, DoABC#2)
// HabboInventory = "_-1gE" (String#860, DoABC#2)


