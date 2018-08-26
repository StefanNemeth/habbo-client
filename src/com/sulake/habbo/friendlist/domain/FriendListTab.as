
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.ITabView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTab 
    {

        public static const _SafeStr_11144:int = 1;
        public static const _SafeStr_11145:int = 2;
        public static const _view:int = 3;

        private var _id:int;
        private var _name:String;
        private var _footerName:String;
        private var _headerPicName:String;
        private var _tabView:ITabView;
        private var _newMessageArrived:Boolean;
        private var _selected:Boolean;
        private var _view:IWindowContainer;

        public function FriendListTab(_arg_1:HabboFriendList, _arg_2:int, _arg_3:ITabView, _arg_4:String, _arg_5:String, _arg_6:String)
        {
            this._id = _arg_2;
            this._name = _arg_4;
            this._tabView = _arg_3;
            this._footerName = _arg_5;
            this._headerPicName = _arg_6;
            this._tabView.init(_arg_1);
        }
        public function setSelected(_arg_1:Boolean):void
        {
            if (_arg_1){
                this._newMessageArrived = false;
            };
            this._selected = _arg_1;
        }
        public function setNewMessageArrived(_arg_1:Boolean):void
        {
            if (this.selected){
                this._newMessageArrived = false;
            }
            else {
                this._newMessageArrived = _arg_1;
            };
        }
        public function get newMessageArrived():Boolean
        {
            return (this._newMessageArrived);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get footerName():String
        {
            return (this._footerName);
        }
        public function get headerPicName():String
        {
            return (this._headerPicName);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function get tabView():ITabView
        {
            return (this._tabView);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            this._view = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// _view = "_-01Y" (String#14113, DoABC#2)
// _headerPicName = "_-3Hf" (String#22187, DoABC#2)
// _tabView = "_-ty" (String#24447, DoABC#2)
// footerName = "_-2Uy" (String#20236, DoABC#2)
// headerPicName = "_-02r" (String#14153, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// ITabView = "_-0HV" (String#3907, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// _newMessageArrived = "_-3F9" (String#7615, DoABC#2)


