
package com.sulake.habbo.moderation
{
    public class IssueCategoryNames 
    {

        public static function getCategoryName(_arg_1:int):String
        {
            switch (_arg_1){
                case 0:
                    return ("Automatic");
                case 101:
                    return ("Sex");
                case 102:
                    return ("Ad");
                case 103:
                    return ("Scam");
                case 104:
                    return ("Bullying");
                case 105:
                    return ("Disruption");
                case 106:
                    return ("Other");
                default:
                    return ("Unknown");
            };
        }

    }
}//package com.sulake.habbo.moderation

// getCategoryName = "_-0mq" (String#15933, DoABC#2)
// IssueCategoryNames = "_-2eJ" (String#6840, DoABC#2)


