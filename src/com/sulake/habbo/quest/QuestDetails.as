
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class QuestDetails implements IDisposable 
    {

        private static const _SafeStr_12202:int = 56;
        private static const _SafeStr_12065:int = 5;
        private static const _SafeStr_12277:int = 5;
        private static const _SafeStr_12369:Point = new Point(8, 8);
        private static const _SafeStr_12370:Array = ["PLACE_ITEM", "PLACE_FLOOR", "PLACE_WALLPAPER", "PET_DRINK", "PET_EAT"];

        private var _SafeStr_8017:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _openForNextQuest:Boolean;
        private var _quest:QuestMessageData;
        private var _SafeStr_12260:int;

        public function QuestDetails(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            this._quest = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function QuestTracker(_arg_1:QuestMessageData):void
        {
            if (this._openForNextQuest){
                this._openForNextQuest = false;
                this.QuestDetails(_arg_1);
            }
            else {
                if ((((this._quest == null)) || (!((this._quest.id == _arg_1.id))))){
                    this.close();
                };
            };
        }
        public function QuestTracker(_arg_1:QuestMessageData):void
        {
            this.close();
        }
        public function QuestTracker():void
        {
            this.close();
        }
        public function HabboGroupInfoManager():void
        {
            this.close();
        }
        private function close():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        public function QuestDetails(_arg_1:QuestMessageData):void
        {
            if (((this._window) && (this._window.visible))){
                this._window.visible = false;
                return;
            };
            this.QuestDetails(_arg_1);
        }
        private function QuestDetails(_arg_1:QuestMessageData):void
        {
            var _local_8:IWindowContainer;
            this._quest = _arg_1;
            if (_arg_1 == null){
                return;
            };
            if (this._window == null){
                this._window = IFrameWindow(this._SafeStr_8017.getXmlWindow("QuestDetails"));
                this._window.findChildByTag("close").procedure = this.QuestDetails;
                this._window.center();
                _local_8 = this._SafeStr_8017.questController.questsList.QuestsList();
                _local_8.x = _SafeStr_12369.x;
                _local_8.y = _SafeStr_12369.y;
                this._window.content.addChild(_local_8);
                this._window.findChildByName("link_region").procedure = this.onLinkProc;
            };
            _local_8 = IWindowContainer(this._window.findChildByName("entry_container"));
            this._SafeStr_8017.questController.questsList.refreshEntryDetails(_local_8, _arg_1);
            var _local_2 = (this._quest.waitPeriodSeconds > 0);
            var _local_3:ITextWindow = ITextWindow(_local_8.findChildByName("hint_txt"));
            var _local_4:int = this.QuestDetails(_local_3);
            if (!_local_2){
                _local_3.caption = this._SafeStr_8017.getQuestHint(_arg_1);
                _local_3.height = (_local_3.textHeight + _SafeStr_12277);
            };
            _local_3.visible = !(_local_2);
            var _local_5:int = (this.QuestDetails(_local_3) - _local_4);
            var _local_6:int = this.QuestDetails("link_region", ((_local_3.y + _local_3.height) + _SafeStr_12065));
            var _local_7:IWindowContainer = IWindowContainer(_local_8.findChildByName("quest_container"));
            _local_7.height = (_local_7.height + (_local_5 + _local_6));
            this._SafeStr_8017.questController.questsList.QuestsList(_local_8);
            this._window.height = (_local_8.height + _SafeStr_12202);
            this._window.visible = true;
            this._window.activate();
        }
        private function QuestDetails(_arg_1:String, _arg_2:int):int
        {
            var _local_3:Boolean = this.QuestDetails();
            var _local_4:Boolean = this.QuestDetails();
            var _local_5:Boolean = ((_local_3) || (_local_4));
            var _local_6:IRegionWindow = IRegionWindow(this._window.findChildByName(_arg_1));
            _local_6.y = _arg_2;
            var _local_7:int;
            if (((_local_5) && (!(_local_6.visible)))){
                _local_7 = (_SafeStr_12065 + _local_6.height);
            };
            if (((!(_local_5)) && (_local_6.visible))){
                _local_7 = (-(_SafeStr_12065) - _local_6.height);
            };
            _local_6.visible = _local_5;
            _local_6.findChildByName("link_catalog").visible = _local_3;
            _local_6.findChildByName("link_navigator").visible = _local_4;
            return (_local_7);
        }
        private function QuestDetails():Boolean
        {
            return ((((this._quest.waitPeriodSeconds < 1)) && ((_SafeStr_12370.indexOf(this._quest.type) > -1))));
        }
        private function QuestDetails():Boolean
        {
            var _local_1:Boolean = this._SafeStr_8017.localization.hasKey((this._quest.QuestMessageData() + ".searchtag"));
            var _local_2:Boolean = this._SafeStr_8017.localization.hasKey((this._quest.QuestMessageData() + ".searchtag"));
            return ((((this._quest.waitPeriodSeconds < 1)) && (((_local_1) || (_local_2)))));
        }
        private function QuestDetails(_arg_1:ITextWindow):int
        {
            return (((_arg_1.visible) ? _arg_1.height : 0));
        }
        private function QuestDetails(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._window.visible = false;
            };
        }
        public function set openForNextQuest(_arg_1:Boolean):void
        {
            this._openForNextQuest = _arg_1;
        }
        private function onLinkProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (this.QuestDetails()){
                    this._SafeStr_8017.openCatalog(this._quest);
                }
                else {
                    if (this.QuestDetails()){
                        this._SafeStr_8017.openNavigator(this._quest);
                    };
                };
            };
        }
        public function update(_arg_1:uint):void
        {
            if ((((this._window == null)) || (!(this._window.visible)))){
                return;
            };
            this._SafeStr_12260 = (this._SafeStr_12260 - _arg_1);
            if (this._SafeStr_12260 > 0){
                return;
            };
            this._SafeStr_12260 = NextQuestTimer._SafeStr_12275;
            var _local_2:Boolean = this._SafeStr_8017.questController.questsList.QuestsList(this._window, this._quest);
            if (_local_2){
                this.QuestDetails(this._quest);
            };
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12065 = "_-6v" (String#7804, DoABC#2)
// QuestTracker = "_-2Ht" (String#6400, DoABC#2)
// QuestTracker = "_-0wk" (String#4785, DoABC#2)
// QuestTracker = "_-kW" (String#8614, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// questsList = "_-0W6" (String#15282, DoABC#2)
// _SafeStr_12202 = "_-3Gc" (String#7639, DoABC#2)
// _SafeStr_12260 = "_-0Pq" (String#1467, DoABC#2)
// QuestsList = "_-0F6" (String#14648, DoABC#2)
// QuestsList = "_-0uc" (String#16225, DoABC#2)
// QuestsList = "_-2zx" (String#21458, DoABC#2)
// _SafeStr_12275 = "_-3Kr" (String#22317, DoABC#2)
// _SafeStr_12277 = "_-0zs" (String#4845, DoABC#2)
// openForNextQuest = "_-UH" (String#23420, DoABC#2)
// openNavigator = "_-2pV" (String#21057, DoABC#2)
// getQuestHint = "_-0EI" (String#14620, DoABC#2)
// _SafeStr_12369 = "_-2Wt" (String#20317, DoABC#2)
// _SafeStr_12370 = "_-2y-" (String#21393, DoABC#2)
// _openForNextQuest = "_-tC" (String#24413, DoABC#2)
// QuestDetails = "_-2lz" (String#20917, DoABC#2)
// QuestDetails = "_-1NS" (String#17416, DoABC#2)
// onLinkProc = "_-1nE" (String#18434, DoABC#2)
// QuestDetails = "_-m-" (String#24111, DoABC#2)
// QuestDetails = "_-vg" (String#24516, DoABC#2)
// QuestDetails = "_-1MD" (String#17368, DoABC#2)
// QuestDetails = "_-090" (String#14409, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// QuestDetails = "_-3H6" (String#7649, DoABC#2)
// refreshEntryDetails = "_-xU" (String#24589, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// QuestMessageData = "_-02z" (String#14161, DoABC#2)
// _quest = "_-26O" (String#876, DoABC#2)
// HabboGroupInfoManager = "_-0Na" (String#356, DoABC#2)
// hasKey = "_-0LB" (String#3985, DoABC#2)


