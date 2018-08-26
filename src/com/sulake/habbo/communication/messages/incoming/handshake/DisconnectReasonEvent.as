
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;

    public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_3651:int = 0;
        public static const _SafeStr_3652:int = 1;
        public static const _SafeStr_3653:int = 2;
        public static const _SafeStr_3654:int = 3;
        public static const _SafeStr_3655:int = 4;
        public static const _SafeStr_3656:int = 5;
        public static const _SafeStr_3657:int = 10;
        public static const _SafeStr_3658:int = 11;
        public static const _SafeStr_3659:int = 12;
        public static const _SafeStr_3660:int = 13;
        public static const _SafeStr_3661:int = 16;
        public static const _SafeStr_3662:int = 17;
        public static const _SafeStr_3663:int = 18;
        public static const _SafeStr_3664:int = 19;
        public static const _SafeStr_3665:int = 20;
        public static const _SafeStr_3666:int = 22;
        public static const _SafeStr_3667:int = 23;
        public static const _SafeStr_3668:int = 24;
        public static const _SafeStr_3669:int = 25;
        public static const _SafeStr_3670:int = 26;
        public static const _SafeStr_3671:int = 27;
        public static const _SafeStr_3672:int = 28;
        public static const _SafeStr_3673:int = 29;
        public static const _SafeStr_3674:int = 100;
        public static const _SafeStr_3675:int = 101;
        public static const _SafeStr_3676:int = 102;
        public static const _SafeStr_3677:int = 103;
        public static const _SafeStr_3678:int = 104;
        public static const _SafeStr_3679:int = 105;
        public static const _SafeStr_3680:int = 106;
        public static const _SafeStr_3681:int = 107;
        public static const _SafeStr_3682:int = 108;
        public static const _SafeStr_3683:int = 109;
        public static const _SafeStr_3684:int = 110;
        public static const _SafeStr_3685:int = 111;
        public static const _SafeStr_3686:int = 112;
        public static const _SafeStr_3687:int = 113;
        public static const _SafeStr_3688:int = 114;
        public static const _SafeStr_3689:int = 115;
        public static const _SafeStr_3690:int = 116;
        public static const _SafeStr_3691:int = 117;
        public static const _SafeStr_3692:int = 118;
        public static const _SafeStr_3693:int = 119;

        public function DisconnectReasonEvent(_arg_1:Function)
        {
            super(_arg_1, DisconnectReasonParser);
        }
        public function get reason():int
        {
            return ((this._parser as DisconnectReasonParser).reason);
        }
        public function get reasonString():String
        {
            switch (this.reason){
                case _SafeStr_3652:
                case _SafeStr_3657:
                    return ("banned");
                case _SafeStr_3653:
                    return ("concurrentlogin");
                default:
                    return ("logout");
            };
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// DisconnectReasonEvent = "_-1OP" (String#5321, DoABC#2)
// DisconnectReasonParser = "_-Ei" (String#7964, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// _SafeStr_3651 = "_-18m" (String#16803, DoABC#2)
// _SafeStr_3652 = "_-0Ca" (String#14552, DoABC#2)
// _SafeStr_3653 = "_-01l" (String#14119, DoABC#2)
// _SafeStr_3654 = "_-aw" (String#23667, DoABC#2)
// _SafeStr_3655 = "_-0CK" (String#14542, DoABC#2)
// _SafeStr_3656 = "_-066" (String#14286, DoABC#2)
// _SafeStr_3657 = "_-10t" (String#16493, DoABC#2)
// _SafeStr_3658 = "_-QH" (String#23261, DoABC#2)
// _SafeStr_3659 = "_-2cA" (String#20530, DoABC#2)
// _SafeStr_3660 = "_-2pQ" (String#21055, DoABC#2)
// _SafeStr_3661 = "_-1-m" (String#16458, DoABC#2)
// _SafeStr_3662 = "_-Xf" (String#23547, DoABC#2)
// _SafeStr_3663 = "_-1LS" (String#17331, DoABC#2)
// _SafeStr_3664 = "_-TM" (String#23380, DoABC#2)
// _SafeStr_3665 = "_-ww" (String#24567, DoABC#2)
// _SafeStr_3666 = "_-0Y4" (String#15360, DoABC#2)
// _SafeStr_3667 = "_-0nt" (String#15972, DoABC#2)
// _SafeStr_3668 = "_-NI" (String#23136, DoABC#2)
// _SafeStr_3669 = "_-26x" (String#19290, DoABC#2)
// _SafeStr_3670 = "_-0Kg" (String#14867, DoABC#2)
// _SafeStr_3671 = "_-0aj" (String#15464, DoABC#2)
// _SafeStr_3672 = "_-2oZ" (String#21027, DoABC#2)
// _SafeStr_3673 = "_-2FX" (String#19625, DoABC#2)
// _SafeStr_3674 = "_-3L9" (String#22330, DoABC#2)
// _SafeStr_3675 = "_-1IR" (String#17211, DoABC#2)
// _SafeStr_3676 = "_-28-" (String#19330, DoABC#2)
// _SafeStr_3677 = "_-14r" (String#16648, DoABC#2)
// _SafeStr_3678 = "_-1bZ" (String#17958, DoABC#2)
// _SafeStr_3679 = "_-4l" (String#22407, DoABC#2)
// _SafeStr_3680 = "_-2JB" (String#19775, DoABC#2)
// _SafeStr_3681 = "_-0Vi" (String#15267, DoABC#2)
// _SafeStr_3682 = "_-00n" (String#14085, DoABC#2)
// _SafeStr_3683 = "_-0m8" (String#15900, DoABC#2)
// _SafeStr_3684 = "_-261" (String#19260, DoABC#2)
// _SafeStr_3685 = "_-0PA" (String#15032, DoABC#2)
// _SafeStr_3686 = "_-HL" (String#22905, DoABC#2)
// _SafeStr_3687 = "_-yh" (String#24640, DoABC#2)
// _SafeStr_3688 = "_-1fG" (String#18107, DoABC#2)
// _SafeStr_3689 = "_-ZE" (String#23607, DoABC#2)
// _SafeStr_3690 = "_-2ee" (String#20632, DoABC#2)
// _SafeStr_3691 = "_-33N" (String#21637, DoABC#2)
// _SafeStr_3692 = "_-3C8" (String#21966, DoABC#2)
// _SafeStr_3693 = "_-Ro" (String#23316, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// reasonString = "_-Ln" (String#23073, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


