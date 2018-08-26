
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerConfs implements ElementTypeHolder 
    {

        private var _confs:Array;

        public function TriggerConfs()
        {
            this._confs = new Array();
            super();
            this._confs.push(new AvatarSaysSomething());
            this._confs.push(new AvatarEntersStuff());
            this._confs.push(new AvatarExitsStuff());
            this._confs.push(new TriggerOnce());
            this._confs.push(new StuffIsUsed());
            this._confs.push(new TriggerPeriodically());
            this._confs.push(new AvatarEntersRoom());
            this._confs.push(new GameStarts());
            this._confs.push(new GameEnds());
            this._confs.push(new ScoreAchieved());
            this._confs.push(new AvatarCaught());
            this._confs.push(new StuffCaught());
        }
        public function get confs():Array
        {
            return (this._confs);
        }
        public function getByCode(_arg_1:int):TriggerConf
        {
            var _local_2:TriggerConf;
            for each (_local_2 in this._confs) {
                if (_local_2.code == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getElementByCode(_arg_1:int):Element
        {
            return (this.getByCode(_arg_1));
        }
        public function acceptTriggerable(_arg_1:Triggerable):Boolean
        {
            return (!(((_arg_1 as TriggerDefinition) == null)));
        }
        public function getKey():String
        {
            return ("trigger");
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerDefinition = "_-2ov" (String#7057, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// ElementTypeHolder = "_-0P4" (String#4071, DoABC#2)
// TriggerConfs = "_-0Qs" (String#4108, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// TriggerOnce = "_-31n" (String#7342, DoABC#2)
// AvatarCaught = "_-1N4" (String#5293, DoABC#2)
// AvatarSaysSomething = "_-295" (String#19370, DoABC#2)
// GameEnds = "_-0I-" (String#14757, DoABC#2)
// AvatarExitsStuff = "_-0Vf" (String#4220, DoABC#2)
// TriggerPeriodically = "_-nd" (String#8671, DoABC#2)
// AvatarEntersStuff = "_-1j6" (String#5738, DoABC#2)
// StuffIsUsed = "_-2RT" (String#20097, DoABC#2)
// ScoreAchieved = "_-37n" (String#21797, DoABC#2)
// AvatarEntersRoom = "_-32a" (String#21599, DoABC#2)
// getByCode = "_-3KG" (String#22292, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// getElementByCode = "_-2v7" (String#7181, DoABC#2)
// acceptTriggerable = "_-29f" (String#6243, DoABC#2)
// _confs = "_-22p" (String#19125, DoABC#2)
// confs = "_-jE" (String#24009, DoABC#2)


