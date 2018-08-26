
package com.sulake.habbo.navigator.mainview
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;

    public class PublicRoomThumbs 
    {

        private var _SafeStr_4310:Dictionary;

        public function PublicRoomThumbs()
        {
            this._SafeStr_4310 = new Dictionary();
            super();
            this.add("hh_room_bar");
            this.add("hh_room_bar_ING2");
            this.add("hh_room_beauty_salon_general");
            this.add("hh_room_cafe");
            this.add("hh_room_chill");
            this.add("hh_room_cinema");
            this.add("hh_room_clubmammoth");
            this.add("hh_room_disco");
            this.add("hh_room_emperors");
            this.add("hh_room_erics");
            this.add("hh_room_floorlobbies");
            this.add("hh_room_gate_park");
            this.add("hh_room_gold");
            this.add("hh_room_habburger");
            this.add("hh_room_hallway");
            this.add("hh_room_kitchen");
            this.add("hh_room_library");
            this.add("hh_room_lobby");
            this.add("hh_room_lobby_bb");
            this.add("hh_room_lobby_sw");
            this.add("hh_room_netcafe");
            this.add("hh_room_nlobby");
            this.add("hh_room_orient");
            this.add("hh_room_park");
            this.add("hh_room_picnic");
            this.add("hh_room_pizza");
            this.add("hh_room_pool");
            this.add("hh_room_pub");
            this.add("hh_room_rooftop");
            this.add("hh_room_schoolyard");
            this.add("hh_room_space_cafe");
            this.add("hh_room_sport");
            this.add("hh_room_starlounge");
            this.add("hh_room_sun_terrace");
            this.add("hh_room_tearoom");
            this.add("hh_room_terrace");
            this.add("hh_room_tv_studio");
            this.add("hh_room_tv_studio_nikejoga");
            this.add("hh_room_tv_studio_viva");
            this.add("hh_room_floatinggarden");
            this.add("hh_room_theater_halloween");
            this.add("hh_room_den");
            this.add("hh_room_ballroom");
            this.add("hh_room_dustylounge");
            this.add("hh_room_theater_xmas");
            this.add("hh_room_old_skool");
            this.add("hh_room_theater");
            this.add("hh_room_theater_easter");
            this.add("hh_room_sunsetcafe");
            this.add("hh_room_theater_valentine");
            this.add("hh_room_library_halloween");
            this.add("hh_room_theater_carneval");
            this.add("hh_room_icecafe");
            this.add("hh_room_park_general");
            this.add("hh_room_floorlobbies_skylight");
            this.add("hh_room_floorlobbies_basement");
            this.add("hh_room_park_fi");
            this.add("hh_room_floorlobbies_median");
            this.add("hh_room_nlobby_static_cn");
            this.add("hh_room_tv_studio_general");
        }
        public function resolveRoomImageName(_arg_1:OfficialRoomEntryData):String
        {
            var _local_3:String;
            var _local_2:Array = _arg_1.publicRoomData.castLibs.split(",");
            for each (_local_3 in _local_2) {
                if (this.hasPic(_local_3)){
                    return (_local_3);
                };
            };
            return (_local_2[0]);
        }
        private function hasPic(_arg_1:String):Boolean
        {
            return (!((this._SafeStr_4310[_arg_1] == null)));
        }
        private function add(_arg_1:String):void
        {
            this._SafeStr_4310[_arg_1] = _arg_1;
        }

    }
}//package com.sulake.habbo.navigator.mainview

// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// resolveRoomImageName = "_-117" (String#16503, DoABC#2)
// castLibs = "_-0m9" (String#15901, DoABC#2)
// _SafeStr_4310 = "_-3Ae" (String#21906, DoABC#2)
// hasPic = "_-0nB" (String#15944, DoABC#2)


