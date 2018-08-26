
package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.FriendListTab;

    public class FriendListLookAndFeel 
    {

        public function getSelectedEntryBgColor():uint
        {
            return (4282169599);
        }
        public function getFriendTextColor(_arg_1:Boolean):uint
        {
            return (((_arg_1) ? 0xFFFFFFFF : 0xFF000000));
        }
        public function getTabFooterTextColor(_arg_1:Boolean):uint
        {
            return (((_arg_1) ? 4293848814 : 4289900703));
        }
        public function getRowShadingColor(_arg_1:int, _arg_2:Boolean):uint
        {
            if (_arg_1 == FriendListTab._SafeStr_11144){
                return (((_arg_2) ? 0xFFFFFFFF : 4293848814));
            };
            if (_arg_1 == FriendListTab._SafeStr_11145){
                return (((_arg_2) ? 0xFFFFFFFF : 4293848814));
            };
            return (((_arg_2) ? 4290164406 : 4288651167));
        }
        public function getTabTextColor(_arg_1:Boolean, _arg_2:int):uint
        {
            if (_arg_1){
                return (0xFFFFFFFF);
            };
            if (_arg_2 == FriendListTab._SafeStr_11144){
                return (0xFF000000);
            };
            if (_arg_2 == FriendListTab._SafeStr_11145){
                return (4294375158);
            };
            return (4293914607);
        }
        public function getTabBgColor(_arg_1:int):uint
        {
            if (_arg_1 == FriendListTab._SafeStr_11144){
                return (0xFFFFFFFF);
            };
            if (_arg_1 == FriendListTab._SafeStr_11145){
                return (0xFFFFFFFF);
            };
            return (4290164406);
        }

    }
}//package com.sulake.habbo.friendlist

// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// getSelectedEntryBgColor = "_-2cG" (String#20534, DoABC#2)
// getFriendTextColor = "_-K" (String#23004, DoABC#2)
// getTabFooterTextColor = "_-1Cx" (String#16980, DoABC#2)
// getRowShadingColor = "_-33K" (String#21634, DoABC#2)
// getTabTextColor = "_-1EC" (String#17035, DoABC#2)
// getTabBgColor = "_-1iz" (String#18243, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// FriendListLookAndFeel = "_-Qu" (String#23281, DoABC#2)


