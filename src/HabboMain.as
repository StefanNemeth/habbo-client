
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.AdManager;
    import com.sulake.iid.IIDHabboAdManager;
    import flash.utils.ByteArray;
    import flash.display.BitmapData;

    public class HabboAdManagerCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAdManagerCom_manifest;
        public static var requiredClasses:Array = new Array(AdManager, IIDHabboAdManager);
        private static var crcTable:Array;
        private static var crcTableComputed:Boolean = false;

        public static function encode(img:BitmapData):ByteArray
        {
            var i:int;
            var p:uint = null;
            var j:int;
            var png:ByteArray = new ByteArray();
            png.writeUnsignedInt(-1991225785);
            png.writeUnsignedInt(218765834);
            var IHDR:ByteArray = new ByteArray();
            IHDR.writeInt(img.width);
            IHDR.writeInt(img.height);
            IHDR.writeUnsignedInt(134610944);
            IHDR.writeByte(0);
            writeChunk(png, 1229472850, IHDR);
            var IDAT:ByteArray = new ByteArray();
            i = 0;
            while (i < img.height) {
                IDAT.writeByte(0);
                if (!(img.transparent)){
                    j = 0;
                    while (j < img.width) {
                        p = img.getPixel(j, i);
                        IDAT.writeUnsignedInt(uint((((p & 0xFFFFFF) << 8) | 0xFF)));
                        j++;
                    };
                }
                else {
                    j = 0;
                    while (j < img.width) {
                        p = img.getPixel32(j, i);
                        IDAT.writeUnsignedInt(uint((((p & 0xFFFFFF) << 8) | (p >>> 24))));
                        j++;
                    };
                };
                i++;
            };
            IDAT.compress();
            writeChunk(png, 1229209940, IDAT);
            writeChunk(png, 1229278788, null);
            return (png);
        }
        private static function writeChunk(png:ByteArray, _arg_2:uint, data:ByteArray):void
        {
            var c:uint = null;
            var n:uint = null;
            var k:uint = null;
            var i:int;
            if (!(crcTableComputed)){
                crcTableComputed = true;
                crcTable = [];
                n = 0;
                while (n < 0x0100) {
                    c = n;
                    k = 0;
                    while (k < 8) {
                        if ((c & 1)){
                            c = uint((uint(-306674912) ^ uint((c >>> 1))));
                        }
                        else {
                            c = uint((c >>> 1));
                        };
                        k++;
                    };
                    crcTable[n] = c;
                    n++;
                };
            };
            var len:uint;
            if (data != null){
                len = data.length;
            };
            png.writeUnsignedInt(len);
            var p:uint = png.position;
            png.writeUnsignedInt(_arg_2);
            if (data != null){
                png.writeBytes(data);
            };
            var e:uint = png.position;
            png.position = p;
            c = -1;
            i = 0;
            while (i < (e - p)) {
                c = uint((crcTable[((c ^ png.readUnsignedByte()) & uint(0xFF))] ^ uint((c >>> 8))));
                i++;
            };
            c = uint((c ^ uint(-1)));
            png.position = e;
            png.writeUnsignedInt(c);
        }

    }
}//package 

// HabboAdManagerCom_manifest = "_-2uf" (String#7172, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboAvatarEditorManager;
    import com.sulake.iid.IIDHabboAvatarEditor;

    public class HabboAvatarEditorCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAvatarEditorCom_manifest;
        public static var AvatarEditor:Class = HabboAvatarEditorCom_AvatarEditor;
        public static var AvatarEditorFrame:Class = HabboAvatarEditorCom_AvatarEditorFrame;
        public static var AvatarEditorContent:Class = HabboAvatarEditorCom_AvatarEditorContent;
        public static var AvatarEditorGrid:Class = HabboAvatarEditorCom_AvatarEditorGrid;
        public static var AvatarEditorImage:Class = HabboAvatarEditorCom_AvatarEditorImage;
        public static var AvatarEditorThumb:Class = HabboAvatarEditorCom_AvatarEditorThumb;
        public static var ViewConfiguration:Class = HabboAvatarEditorCom_ViewConfiguration;
        public static var StripClubItemsInfo:Class = HabboAvatarEditorCom_StripClubItemsInfo;
        public static var color_chooser_cell:Class = HabboAvatarEditorCom_color_chooser_cell;
        public static var avatareditor_generic_base:Class = HabboAvatarEditorCom_avatareditor_generic_base;
        public static var avatareditor_head_base:Class = HabboAvatarEditorCom_avatareditor_head_base;
        public static var avatareditor_legs_base:Class = HabboAvatarEditorCom_avatareditor_legs_base;
        public static var avatareditor_club_promo_try:Class = HabboAvatarEditorCom_avatareditor_club_promo_try;
        public static var avatareditor_club_promo_buy:Class = HabboAvatarEditorCom_avatareditor_club_promo_buy;
        public static var avatareditor_torso_base:Class = HabboAvatarEditorCom_avatareditor_torso_base;
        public static var Outfit:Class = HabboAvatarEditorCom_Outfit;
        public static var Selector:Class = HabboAvatarEditorCom_Selector;
        public static var avatareditor_wardrobe_base:Class = HabboAvatarEditorCom_avatareditor_wardrobe_base;
        public static var wardrobe_slot:Class = HabboAvatarEditorCom_wardrobe_slot;
        public static var avatareditor_hotlooks_base:Class = HabboAvatarEditorCom_avatareditor_hotlooks_base;
        public static var avatar_editor_download_icon:Class = HabboAvatarEditorCom_avatar_editor_download_icon;
        public static var editor_clr_40x32_1:Class = HabboAvatarEditorCom_editor_clr_40x32_1;
        public static var editor_clr_40x32_2:Class = HabboAvatarEditorCom_editor_clr_40x32_2;
        public static var editor_clr_40x32_3:Class = HabboAvatarEditorCom_editor_clr_40x32_3;
        public static var platform:Class = HabboAvatarEditorCom_platform;
        public static var removeSelection:Class = HabboAvatarEditorCom_removeSelection;
        public static var ae_tabs_generic:Class = HabboAvatarEditorCom_ae_tabs_generic;
        public static var ae_tabs_head:Class = HabboAvatarEditorCom_ae_tabs_head;
        public static var ae_tabs_legs:Class = HabboAvatarEditorCom_ae_tabs_legs;
        public static var ae_tabs_torso:Class = HabboAvatarEditorCom_ae_tabs_torso;
        public static var ae_tabs_hotlooks:Class = HabboAvatarEditorCom_ae_tabs_hotlooks;
        public static var ae_tabs_wardrobe:Class = HabboAvatarEditorCom_ae_tabs_wardrobe;
        public static var bottom_accessories:Class = HabboAvatarEditorCom_bottom_accessories;
        public static var bottom_accessories_on:Class = HabboAvatarEditorCom_bottom_accessories_on;
        public static var bottom_shoes:Class = HabboAvatarEditorCom_bottom_shoes;
        public static var bottom_shoes_on:Class = HabboAvatarEditorCom_bottom_shoes_on;
        public static var bottom_trousers:Class = HabboAvatarEditorCom_bottom_trousers;
        public static var bottom_trousers_on:Class = HabboAvatarEditorCom_bottom_trousers_on;
        public static var gender_female:Class = HabboAvatarEditorCom_gender_female;
        public static var gender_female_on:Class = HabboAvatarEditorCom_gender_female_on;
        public static var gender_male:Class = HabboAvatarEditorCom_gender_male;
        public static var gender_male_on:Class = HabboAvatarEditorCom_gender_male_on;
        public static var head_accessories:Class = HabboAvatarEditorCom_head_accessories;
        public static var head_accessories_on:Class = HabboAvatarEditorCom_head_accessories_on;
        public static var head_eyewear:Class = HabboAvatarEditorCom_head_eyewear;
        public static var head_eyewear_on:Class = HabboAvatarEditorCom_head_eyewear_on;
        public static var head_face_accessories:Class = HabboAvatarEditorCom_head_face_accessories;
        public static var head_face_accessories_on:Class = HabboAvatarEditorCom_head_face_accessories_on;
        public static var head_hair:Class = HabboAvatarEditorCom_head_hair;
        public static var head_hair_on:Class = HabboAvatarEditorCom_head_hair_on;
        public static var head_hats:Class = HabboAvatarEditorCom_head_hats;
        public static var head_hats_on:Class = HabboAvatarEditorCom_head_hats_on;
        public static var top_accessories:Class = HabboAvatarEditorCom_top_accessories;
        public static var top_accessories_on:Class = HabboAvatarEditorCom_top_accessories_on;
        public static var top_shirt:Class = HabboAvatarEditorCom_top_shirt;
        public static var top_jacket_on:Class = HabboAvatarEditorCom_top_jacket_on;
        public static var top_jacket:Class = HabboAvatarEditorCom_top_jacket;
        public static var top_prints_on:Class = HabboAvatarEditorCom_top_prints_on;
        public static var top_prints:Class = HabboAvatarEditorCom_top_prints;
        public static var top_shirt_on:Class = HabboAvatarEditorCom_top_shirt_on;
        public static var selectOutfit:Class = HabboAvatarEditorCom_selectOutfit;
        public static var selectOutfit_over:Class = HabboAvatarEditorCom_selectOutfit_over;
        public static var wardrobe_empty_slot:Class = HabboAvatarEditorCom_wardrobe_empty_slot;
        public static var requiredClasses:Array = new Array(HabboAvatarEditorManager, IIDHabboAvatarEditor);

    }
}//package 

// HabboAvatarEditorCom_platform = "_-ho" (String#8550, DoABC#2)
// HabboAvatarEditorCom_head_hair = "_-KA" (String#8086, DoABC#2)
// HabboAvatarEditorCom_gender_female = "_-ld" (String#8637, DoABC#2)
// HabboAvatarEditorCom_top_prints = "_-20M" (String#6052, DoABC#2)
// HabboAvatarEditorCom_wardrobe_slot = "_-D8" (String#7934, DoABC#2)
// HabboAvatarEditorCom_head_hats_on = "_-2tI" (String#7144, DoABC#2)
// HabboAvatarEditorCom_wardrobe_empty_slot = "_-00K" (String#3569, DoABC#2)
// HabboAvatarEditorCom_bottom_accessories = "_-1Rq" (String#5395, DoABC#2)
// HabboAvatarEditorCom_avatareditor_club_promo_try = "_-0-N" (String#3552, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorImage = "_-081" (String#3719, DoABC#2)
// HabboAvatarEditorCom_ViewConfiguration = "_-0F2" (String#3851, DoABC#2)
// HabboAvatarEditorCom_top_jacket = "_-1i0" (String#5709, DoABC#2)
// HabboAvatarEditorCom_avatareditor_club_promo_buy = "_-0j8" (String#4481, DoABC#2)
// HabboAvatarEditorCom_head_eyewear = "_-18T" (String#5048, DoABC#2)
// HabboAvatarEditorCom_gender_male_on = "_-1mb" (String#5791, DoABC#2)
// HabboAvatarEditorCom_head_accessories = "_-1nF" (String#5802, DoABC#2)
// HabboAvatarEditorCom_top_shirt = "_-Pg" (String#8196, DoABC#2)
// HabboAvatarEditorCom_bottom_trousers_on = "_-tf" (String#8761, DoABC#2)
// HabboAvatarEditorCom_avatareditor_legs_base = "_-0VC" (String#4208, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorGrid = "_-2-9" (String#6033, DoABC#2)
// HabboAvatarEditorCom_head_eyewear_on = "_-09u" (String#3756, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_1 = "_-2hz" (String#6907, DoABC#2)
// HabboAvatarEditorCom_head_hats = "_-0JD" (String#3938, DoABC#2)
// HabboAvatarEditorCom_top_shirt_on = "_-2g8" (String#6870, DoABC#2)
// HabboAvatarEditorCom_avatar_editor_download_icon = "_-2sF" (String#7126, DoABC#2)
// HabboAvatarEditorCom_color_chooser_cell = "_-28i" (String#6217, DoABC#2)
// HabboAvatarEditorCom_manifest = "_-24w" (String#6138, DoABC#2)
// HabboAvatarEditorCom_avatareditor_head_base = "_-QY" (String#8215, DoABC#2)
// HabboAvatarEditorCom_head_accessories_on = "_-2ks" (String#6974, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorContent = "_-3KD" (String#7709, DoABC#2)
// HabboAvatarEditorCom_AvatarEditor = "_-1e4" (String#5630, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_torso = "_-1Rl" (String#5393, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_head = "_-1Wy" (String#5494, DoABC#2)
// HabboAvatarEditorCom_gender_male = "_-0Tm" (String#4175, DoABC#2)
// HabboAvatarEditorCom_bottom_shoes = "_-41" (String#7746, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_2 = "_-05r" (String#3682, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_3 = "_-3Kx" (String#7722, DoABC#2)
// HabboAvatarEditorCom_StripClubItemsInfo = "_-0AT" (String#3767, DoABC#2)
// HabboAvatarEditorCom_head_face_accessories_on = "_-2NY" (String#6513, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorThumb = "_-25r" (String#6158, DoABC#2)
// HabboAvatarEditorCom_selectOutfit = "_-1g0" (String#5663, DoABC#2)
// HabboAvatarEditorCom_head_face_accessories = "_-2qf" (String#7090, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorFrame = "_-1zN" (String#6022, DoABC#2)
// HabboAvatarEditorCom_selectOutfit_over = "_-38S" (String#7480, DoABC#2)
// HabboAvatarEditorCom_avatareditor_generic_base = "_-7K" (String#7811, DoABC#2)
// HabboAvatarEditorCom_bottom_accessories_on = "_-0sw" (String#4704, DoABC#2)
// HabboAvatarEditorCom_gender_female_on = "_-QA" (String#8204, DoABC#2)
// HabboAvatarEditorCom_avatareditor_wardrobe_base = "_-0mc" (String#4561, DoABC#2)
// HabboAvatarEditorCom_Outfit = "_-vf" (String#8797, DoABC#2)
// HabboAvatarEditorCom_bottom_trousers = "_-2RR" (String#6595, DoABC#2)
// HabboAvatarEditorCom_Selector = "_-2N3" (String#6501, DoABC#2)
// HabboAvatarEditorCom_top_prints_on = "_-2Ji" (String#6433, DoABC#2)
// HabboAvatarEditorCom_top_accessories_on = "_-aV" (String#8429, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_legs = "_-1VN" (String#5465, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_generic = "_-2nu" (String#7038, DoABC#2)
// HabboAvatarEditorCom_top_jacket_on = "_-9h" (String#7856, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_hotlooks = "_-TV" (String#8276, DoABC#2)
// HabboAvatarEditorCom_removeSelection = "_-1Fh" (String#5166, DoABC#2)
// HabboAvatarEditorCom_avatareditor_torso_base = "_-1r-" (String#5874, DoABC#2)
// HabboAvatarEditorCom_bottom_shoes_on = "_-JJ" (String#8070, DoABC#2)
// HabboAvatarEditorCom_head_hair_on = "_-1OZ" (String#5325, DoABC#2)
// HabboAvatarEditorCom_top_accessories = "_-2L-" (String#6461, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_wardrobe = "_-1nS" (String#5808, DoABC#2)
// HabboAvatarEditorCom_avatareditor_hotlooks_base = "_-1FY" (String#5164, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.AvatarRenderManager;
    import com.sulake.iid.IIDAvatarRenderManager;

    public class HabboAvatarRenderLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboAvatarRenderLib_manifest;
        public static var requiredClasses:Array = new Array(AvatarRenderManager, IIDAvatarRenderManager);
        public static var user_typing_png:Class = HabboAvatarRenderLib_user_typing_png;
        public static var user_typing_small_png:Class = HabboAvatarRenderLib_user_typing_small_png;
        public static var number_1_png:Class = HabboAvatarRenderLib_number_1_png;
        public static var number_2_png:Class = HabboAvatarRenderLib_number_2_png;
        public static var number_3_png:Class = HabboAvatarRenderLib_number_3_png;
        public static var number_4_png:Class = HabboAvatarRenderLib_number_4_png;
        public static var number_5_png:Class = HabboAvatarRenderLib_number_5_png;
        public static var number_1_small_png:Class = HabboAvatarRenderLib_number_1_small_png;
        public static var number_2_small_png:Class = HabboAvatarRenderLib_number_2_small_png;
        public static var number_3_small_png:Class = HabboAvatarRenderLib_number_3_small_png;
        public static var number_4_small_png:Class = HabboAvatarRenderLib_number_4_small_png;
        public static var number_5_small_png:Class = HabboAvatarRenderLib_number_5_small_png;
        public static var pet_experience_bubble_png:Class = HabboAvatarRenderLib_pet_experience_bubble_png;
        public static var pet_placeholder_0_png:Class = HabboAvatarRenderLib_pet_placeholder_0_png;
        public static var pet_placeholder_1_png:Class = HabboAvatarRenderLib_pet_placeholder_1_png;
        public static var pet_placeholder_2_png:Class = HabboAvatarRenderLib_pet_placeholder_2_png;
        public static var pet_placeholder_3_png:Class = HabboAvatarRenderLib_pet_placeholder_3_png;
        public static var pet_placeholder_4_png:Class = HabboAvatarRenderLib_pet_placeholder_4_png;
        public static var pet_placeholder_5_png:Class = HabboAvatarRenderLib_pet_placeholder_5_png;
        public static var pet_placeholder_6_png:Class = HabboAvatarRenderLib_pet_placeholder_6_png;
        public static var pet_placeholder_7_png:Class = HabboAvatarRenderLib_pet_placeholder_7_png;
        public static var pet_placeholder_s0_png:Class = HabboAvatarRenderLib_pet_placeholder_s0_png;
        public static var pet_placeholder_s1_png:Class = HabboAvatarRenderLib_pet_placeholder_s1_png;
        public static var pet_placeholder_s2_png:Class = HabboAvatarRenderLib_pet_placeholder_s2_png;
        public static var pet_placeholder_s3_png:Class = HabboAvatarRenderLib_pet_placeholder_s3_png;
        public static var pet_placeholder_s4_png:Class = HabboAvatarRenderLib_pet_placeholder_s4_png;
        public static var pet_placeholder_s5_png:Class = HabboAvatarRenderLib_pet_placeholder_s5_png;
        public static var pet_placeholder_s6_png:Class = HabboAvatarRenderLib_pet_placeholder_s6_png;
        public static var pet_placeholder_s7_png:Class = HabboAvatarRenderLib_pet_placeholder_s7_png;
        public static var action_offset_lay:Class = HabboAvatarRenderLib_action_offset_lay;
        public static var action_offset_swim:Class = HabboAvatarRenderLib_action_offset_swim;
        public static var HabboAvatarActions:Class = HabboAvatarRenderLib_HabboAvatarActions;
        public static var HabboAvatarAnimation:Class = HabboAvatarRenderLib_HabboAvatarAnimation;
        public static var HabboAvatarFigure:Class = HabboAvatarRenderLib_HabboAvatarFigure;
        public static var HabboAvatarGeometry:Class = HabboAvatarRenderLib_HabboAvatarGeometry;
        public static var HabboAvatarPartSets:Class = HabboAvatarRenderLib_HabboAvatarPartSets;
        public static var HabboAvatarPetActions:Class = HabboAvatarRenderLib_HabboAvatarPetActions;
        public static var HabboAvatarPetAnimation:Class = HabboAvatarRenderLib_HabboAvatarPetAnimation;
        public static var HabboAvatarPetFigure:Class = HabboAvatarRenderLib_HabboAvatarPetFigure;
        public static var HabboAvatarPetGeometry:Class = HabboAvatarRenderLib_HabboAvatarPetGeometry;
        public static var HabboAvatarPetPartSets:Class = HabboAvatarRenderLib_HabboAvatarPetPartSets;

    }
}//package 

// HabboAvatarRenderLib_HabboAvatarAnimation = "_-14v" (String#4976, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s3_png = "_-RW" (String#8236, DoABC#2)
// HabboAvatarRenderLib_number_4_small_png = "_-0Aj" (String#3771, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_4_png = "_-s1" (String#8736, DoABC#2)
// HabboAvatarRenderLib_number_2_png = "_-yn" (String#8855, DoABC#2)
// HabboAvatarRenderLib_action_offset_swim = "_-2io" (String#6927, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s4_png = "_-2gc" (String#6881, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarActions = "_-yl" (String#8854, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s0_png = "_-1O7" (String#5313, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_6_png = "_-2MI" (String#6489, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s1_png = "_-20Z" (String#6058, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPetGeometry = "_-NJ" (String#8151, DoABC#2)
// HabboAvatarRenderLib_action_offset_lay = "_-OK" (String#8171, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_2_png = "_-35v" (String#7428, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_5_png = "_-0ge" (String#4437, DoABC#2)
// HabboAvatarRenderLib_number_4_png = "_-kV" (String#8613, DoABC#2)
// HabboAvatarRenderLib_number_2_small_png = "_-0KH" (String#3959, DoABC#2)
// HabboAvatarRenderLib_number_5_small_png = "_-1Dn" (String#5139, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarFigure = "_-0YY" (String#4273, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s6_png = "_-EV" (String#7961, DoABC#2)
// HabboAvatarRenderLib_number_1_small_png = "_-0aT" (String#4312, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s5_png = "_-02c" (String#3620, DoABC#2)
// HabboAvatarRenderLib_manifest = "_-0CI" (String#3796, DoABC#2)
// HabboAvatarRenderLib_user_typing_small_png = "_-2nl" (String#7035, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPartSets = "_-19i" (String#5072, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s2_png = "_-Ng" (String#8158, DoABC#2)
// HabboAvatarRenderLib_number_1_png = "_-17l" (String#5033, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPetActions = "_-1RR" (String#5385, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_3_png = "_-0Q-" (String#4093, DoABC#2)
// HabboAvatarRenderLib_number_3_png = "_-13O" (String#4941, DoABC#2)
// HabboAvatarRenderLib_pet_experience_bubble_png = "_-0sW" (String#4697, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarGeometry = "_-0xt" (String#4806, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_s7_png = "_-1R3" (String#5375, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPetPartSets = "_-1XW" (String#5509, DoABC#2)
// HabboAvatarRenderLib_number_5_png = "_-VW" (String#8312, DoABC#2)
// HabboAvatarRenderLib_number_3_small_png = "_-0IA" (String#3919, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPetFigure = "_-0Rp" (String#4131, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_7_png = "_-048" (String#3650, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_1_png = "_-2or" (String#7054, DoABC#2)
// HabboAvatarRenderLib_HabboAvatarPetAnimation = "_-2hW" (String#6897, DoABC#2)
// HabboAvatarRenderLib_user_typing_png = "_-0R5" (String#4114, DoABC#2)
// HabboAvatarRenderLib_pet_placeholder_0_png = "_-3Jc" (String#7696, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboCatalog;
    import com.sulake.iid.IIDHabboCatalog;

    public class HabboCatalogCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCatalogCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCatalog, IIDHabboCatalog);
        public static const bot_thumb_bg:Class = HabboCatalogCom_bot_thumb_bg;
        public static const bot_thumb_bg_selected:Class = HabboCatalogCom_bot_thumb_bg_selected;
        public static const ctlg_clr_27x22_1:Class = HabboCatalogCom_ctlg_clr_27x22_1;
        public static const ctlg_clr_27x22_2:Class = HabboCatalogCom_ctlg_clr_27x22_2;
        public static const ctlg_clr_27x22_3:Class = HabboCatalogCom_ctlg_clr_27x22_3;
        public static const ctlg_clr_40x32_1:Class = HabboCatalogCom_ctlg_clr_40x32_1;
        public static const ctlg_clr_40x32_2:Class = HabboCatalogCom_ctlg_clr_40x32_2;
        public static const ctlg_clr_40x32_3:Class = HabboCatalogCom_ctlg_clr_40x32_3;
        public static const ctlg_pic_DEV_fx_explosion:Class = HabboCatalogCom_ctlg_pic_DEV_fx_explosion;
        public static const ctlg_pic_DEV_fx_flare:Class = HabboCatalogCom_ctlg_pic_DEV_fx_flare;
        public static const ctlg_pic_fx_bubble:Class = HabboCatalogCom_ctlg_pic_fx_bubble;
        public static const ctlg_arrow_down:Class = HabboCatalogCom_ctlg_arrow_down;
        public static const ctlg_arrow_next:Class = HabboCatalogCom_ctlg_arrow_next;
        public static const ctlg_arrow_prev:Class = HabboCatalogCom_ctlg_arrow_prev;
        public static const ctlg_arrow_right:Class = HabboCatalogCom_ctlg_arrow_right;
        public static const ctlg_dyndeal_background:Class = HabboCatalogCom_ctlg_dyndeal_background;
        public static const ctlg_icon_deal_hc:Class = HabboCatalogCom_ctlg_icon_deal_hc;
        public static const ctlg_pic_deal_icon_narrow:Class = HabboCatalogCom_ctlg_pic_deal_icon_narrow;
        public static const ctlg_recycler_slot_bg:Class = HabboCatalogCom_ctlg_recycler_slot_bg;
        public static const purse_club_small:Class = HabboCatalogCom_purse_club_small;
        public static const purse_coins_small:Class = HabboCatalogCom_purse_coins_small;
        public static const purse_pixels_small:Class = HabboCatalogCom_purse_pixels_small;
        public static const testarrow_down:Class = HabboCatalogCom_testarrow_down;
        public static const testarrow_right:Class = HabboCatalogCom_testarrow_right;
        public static const icon_credit_0:Class = HabboCatalogCom_icon_credit_0;
        public static const icon_credit_1:Class = HabboCatalogCom_icon_credit_1;
        public static const icon_credit_2:Class = HabboCatalogCom_icon_credit_2;
        public static const icon_credit_3:Class = HabboCatalogCom_icon_credit_3;
        public static const icon_credit_4:Class = HabboCatalogCom_icon_credit_4;
        public static const icon_credit_5:Class = HabboCatalogCom_icon_credit_5;
        public static const icon_credit_6:Class = HabboCatalogCom_icon_credit_6;
        public static const icon_activity_point_1:Class = HabboCatalogCom_icon_activity_point_1;
        public static const icon_activity_point_2:Class = HabboCatalogCom_icon_activity_point_2;
        public static const icon_activity_point_3:Class = HabboCatalogCom_icon_activity_point_3;
        public static const icon_activity_point_4:Class = HabboCatalogCom_icon_activity_point_4;
        public static const icon_bg_img_2:Class = HabboCatalogCom_icon_bg_img_2;
        public static const icon_bg_img:Class = HabboCatalogCom_icon_bg_img;
        public static const layout_bg:Class = HabboCatalogCom_layout_bg;
        public static const thumb_bg:Class = HabboCatalogCom_thumb_bg;
        public static const thumb_bg_selected:Class = HabboCatalogCom_thumb_bg_selected;
        public static const catalog:Class = HabboCatalogCom_catalog;
        public static const catalog_with_purse:Class = HabboCatalogCom_catalog_with_purse;
        public static const club_extend_confirmation:Class = HabboCatalogCom_club_extend_confirmation;
        public static const club_buy_confirmation:Class = HabboCatalogCom_club_buy_confirmation;
        public static const club_buy_hc_item:Class = HabboCatalogCom_club_buy_hc_item;
        public static const club_buy_info_item:Class = HabboCatalogCom_club_buy_info_item;
        public static const club_buy_vip_item:Class = HabboCatalogCom_club_buy_vip_item;
        public static const club_buy_vip_upgrade_item:Class = HabboCatalogCom_club_buy_vip_upgrade_item;
        public static const club_gift_confirmation:Class = HabboCatalogCom_club_gift_confirmation;
        public static const club_gift_list_item:Class = HabboCatalogCom_club_gift_list_item;
        public static const club_gift_preview:Class = HabboCatalogCom_club_gift_preview;
        public static const color_chooser_cell:Class = HabboCatalogCom_color_chooser_cell;
        public static const configuration_catalog_spaces:Class = HabboCatalogCom_configuration_catalog_spaces;
        public static const gridItem:Class = HabboCatalogCom_gridItem;
        public static const ctlg_camera1:Class = HabboCatalogCom_ctlg_camera1;
        public static const ctlg_camera2:Class = HabboCatalogCom_ctlg_camera2;
        public static const ctlg_cars:Class = HabboCatalogCom_ctlg_cars;
        public static const ctlg_club1:Class = HabboCatalogCom_ctlg_club1;
        public static const ctlg_club2:Class = HabboCatalogCom_ctlg_club2;
        public static const ctlg_club_buy:Class = HabboCatalogCom_ctlg_club_buy;
        public static const ctlg_club_gifts:Class = HabboCatalogCom_ctlg_club_gifts;
        public static const ctlg_collectibles:Class = HabboCatalogCom_ctlg_collectibles;
        public static const ctlg_default_3x3_extrainfo:Class = HabboCatalogCom_ctlg_default_3x3_extrainfo;
        public static const ctlg_default_3x3:Class = HabboCatalogCom_ctlg_default_3x3;
        public static const ctlg_frontpage1:Class = HabboCatalogCom_ctlg_frontpage1;
        public static const ctlg_frontpage2:Class = HabboCatalogCom_ctlg_frontpage2;
        public static const ctlg_frontpage3:Class = HabboCatalogCom_ctlg_frontpage3;
        public static const ctlg_info_credits:Class = HabboCatalogCom_ctlg_info_credits;
        public static const ctlg_info_pixels:Class = HabboCatalogCom_ctlg_info_pixels;
        public static const ctlg_mad_money:Class = HabboCatalogCom_ctlg_mad_money;
        public static const ctlg_monkey:Class = HabboCatalogCom_ctlg_monkey;
        public static const ctlg_marketplace_own_items:Class = HabboCatalogCom_ctlg_marketplace_own_items;
        public static const ctlg_marketplace:Class = HabboCatalogCom_ctlg_marketplace;
        public static const ctlg_pets2:Class = HabboCatalogCom_ctlg_pets2;
        public static const ctlg_pets:Class = HabboCatalogCom_ctlg_pets;
        public static const ctlg_pixeldeals:Class = HabboCatalogCom_ctlg_pixeldeals;
        public static const ctlg_pixeleffects:Class = HabboCatalogCom_ctlg_pixeleffects;
        public static const ctlg_pixelrent:Class = HabboCatalogCom_ctlg_pixelrent;
        public static const ctlg_plasto:Class = HabboCatalogCom_ctlg_plasto;
        public static const ctlg_presents:Class = HabboCatalogCom_ctlg_presents;
        public static const ctlg_purse:Class = HabboCatalogCom_ctlg_purse;
        public static const ctlg_recycler_info:Class = HabboCatalogCom_ctlg_recycler_info;
        public static const ctlg_recycler_prizes:Class = HabboCatalogCom_ctlg_recycler_prizes;
        public static const ctlg_recycler:Class = HabboCatalogCom_ctlg_recycler;
        public static const ctlg_soundmachine:Class = HabboCatalogCom_ctlg_soundmachine;
        public static const ctlg_spaces:Class = HabboCatalogCom_ctlg_spaces;
        public static const ctlg_spaces_new:Class = HabboCatalogCom_ctlg_spaces_new;
        public static const ctlg_trophies:Class = HabboCatalogCom_ctlg_trophies;
        public static const ctlg_infopage1:Class = HabboCatalogCom_ctlg_infopage1;
        public static const ctlg_infopage2:Class = HabboCatalogCom_ctlg_infopage2;
        public static const ctlg_layout1:Class = HabboCatalogCom_ctlg_layout1;
        public static const ctlg_layout2:Class = HabboCatalogCom_ctlg_layout2;
        public static const ctlg_layout3:Class = HabboCatalogCom_ctlg_layout3;
        public static const ctlg_loading:Class = HabboCatalogCom_ctlg_loading;
        public static const ctlg_norares:Class = HabboCatalogCom_ctlg_norares;
        public static const ctlg_pixelsdeals:Class = HabboCatalogCom_ctlg_pixelsdeals;
        public static const ctlg_productpage1:Class = HabboCatalogCom_ctlg_productpage1;
        public static const ctlg_productpage2b:Class = HabboCatalogCom_ctlg_productpage2b;
        public static const ctlg_productpage2:Class = HabboCatalogCom_ctlg_productpage2;
        public static const ctlg_productpage3b:Class = HabboCatalogCom_ctlg_productpage3b;
        public static const ctlg_productpage3:Class = HabboCatalogCom_ctlg_productpage3;
        public static const ctrl_info_credits:Class = HabboCatalogCom_ctrl_info_credits;
        public static const habbo_orderinfo_cantbuycredits:Class = HabboCatalogCom_habbo_orderinfo_cantbuycredits;
        public static const habbo_orderinfo_dialog:Class = HabboCatalogCom_habbo_orderinfo_dialog;
        public static const habbo_orderinfo_gift_checked:Class = HabboCatalogCom_habbo_orderinfo_gift_checked;
        public static const habbo_orderinfo_gift_unchecked:Class = HabboCatalogCom_habbo_orderinfo_gift_unchecked;
        public static const habbo_orderinfo_nocredits:Class = HabboCatalogCom_habbo_orderinfo_nocredits;
        public static const habbo_orderinfo_receiver_suggestion:Class = HabboCatalogCom_habbo_orderinfo_receiver_suggestion;
        public static const bundleGridWidget:Class = HabboCatalogCom_bundleGridWidget;
        public static const clubBuyWidget:Class = HabboCatalogCom_clubBuyWidget;
        public static const clubGiftWidget:Class = HabboCatalogCom_clubGiftWidget;
        public static const effectViewWidget:Class = HabboCatalogCom_effectViewWidget;
        public static const itemGridWidget:Class = dynamic;
        public static const marketPlaceOwnItemsWidget:Class = HabboCatalogCom_marketPlaceOwnItemsWidget;
        public static const marketPlaceWidget:Class = HabboCatalogCom_marketPlaceWidget;
        public static const productViewWidget:Class = HabboCatalogCom_productViewWidget;
        public static const purchaseWidgetCreditsPixelsStub:Class = HabboCatalogCom_purchaseWidgetCreditsPixelsStub;
        public static const purchaseWidgetCreditsStub:Class = HabboCatalogCom_purchaseWidgetCreditsStub;
        public static const purchaseWidgetPixelsStub:Class = HabboCatalogCom_purchaseWidgetPixelsStub;
        public static const purchaseWidget:Class = HabboCatalogCom_purchaseWidget;
        public static const purseWidget:Class = HabboCatalogCom_purseWidget;
        public static const recyclerPrizesWidgetLevelItem:Class = HabboCatalogCom_recyclerPrizesWidgetLevelItem;
        public static const recyclerWidgetInactive:Class = HabboCatalogCom_recyclerWidgetInactive;
        public static const recyclerWidgetTimeout:Class = HabboCatalogCom_recyclerWidgetTimeout;
        public static const recyclerWidget:Class = HabboCatalogCom_recyclerWidget;
        public static const redeemItemCodeWidget:Class = HabboCatalogCom_redeemItemCodeWidget;
        public static const singleViewWidget:Class = HabboCatalogCom_singleViewWidget;
        public static const specialInfoWidget:Class = HabboCatalogCom_specialInfoWidget;
        public static const textInputWidget:Class = HabboCatalogCom_textInputWidget;
        public static const traxPreviewWidget:Class = HabboCatalogCom_traxPreviewWidget;
        public static const trophyWidget:Class = HabboCatalogCom_trophyWidget;
        public static const list_item_list:Class = HabboCatalogCom_list_item_list;
        public static const marketplace_expired_item:Class = HabboCatalogCom_marketplace_expired_item;
        public static const marketplace_offer_details:Class = HabboCatalogCom_marketplace_offer_details;
        public static const marketplace_offers_item:Class = HabboCatalogCom_marketplace_offers_item;
        public static const marketplace_ongoing_item:Class = HabboCatalogCom_marketplace_ongoing_item;
        public static const marketplace_purchase_confirmation:Class = HabboCatalogCom_marketplace_purchase_confirmation;
        public static const marketplace_search_advanced:Class = HabboCatalogCom_marketplace_search_advanced;
        public static const marketplace_search_simple:Class = HabboCatalogCom_marketplace_search_simple;
        public static const marketplace_sold_item:Class = HabboCatalogCom_marketplace_sold_item;
        public static const navigation_list_item:Class = HabboCatalogCom_navigation_list_item;
        public static const navigation_list_subitem:Class = HabboCatalogCom_navigation_list_subitem;
        public static const charge_confirmation:Class = HabboCatalogCom_charge_confirmation;
        public static const gift_no_wrapping:Class = HabboCatalogCom_gift_no_wrapping;
        public static const gift_palette_item:Class = HabboCatalogCom_gift_palette_item;
        public static const gift_wrapping:Class = HabboCatalogCom_gift_wrapping;
        public static const purchase_confirmation:Class = HabboCatalogCom_purchase_confirmation;
        public static const suggestion_list_item:Class = HabboCatalogCom_suggestion_list_item;
        public static const spaces:Class = HabboCatalogCom_spaces;
        public static const purchaseWidgetBuyClubStub:Class = HabboCatalogCom_purchaseWidgetBuyClubStub;
        public static const purchaseWidgetBuyVipStub:Class = HabboCatalogCom_purchaseWidgetBuyVipStub;
        public static const purchaseWidgetUpgradeVipStub:Class = HabboCatalogCom_purchaseWidgetUpgradeVipStub;

    }
}//package 

// HabboCatalogCom_ctlg_pets2 = "_-1e9" (String#5632, DoABC#2)
// HabboCatalogCom_ctlg_frontpage3 = "_-2Hn" (String#6399, DoABC#2)
// HabboCatalogCom_ctlg_frontpage2 = "_-289" (String#6207, DoABC#2)
// HabboCatalogCom_club_extend_confirmation = "_-1yt" (String#6013, DoABC#2)
// HabboCatalogCom_traxPreviewWidget = "_-vr" (String#8801, DoABC#2)
// HabboCatalogCom_thumb_bg_selected = "_-0t-" (String#4706, DoABC#2)
// HabboCatalogCom_ctlg_cars = "_-BH" (String#7893, DoABC#2)
// HabboCatalogCom_navigation_list_item = "_-0Ih" (String#3928, DoABC#2)
// HabboCatalogCom_ctlg_pets = "_-161" (String#4995, DoABC#2)
// HabboCatalogCom_ctlg_dyndeal_background = "_-0Ce" (String#3803, DoABC#2)
// HabboCatalogCom_ctlg_default_3x3_extrainfo = "_-1b-" (String#5577, DoABC#2)
// HabboCatalogCom_ctlg_arrow_next = "_-2Jd" (String#6431, DoABC#2)
// HabboCatalogCom_marketplace_search_simple = "_-2jj" (String#6949, DoABC#2)
// HabboCatalogCom_ctlg_info_pixels = "_-33Q" (String#7373, DoABC#2)
// HabboCatalogCom_ctlg_recycler_prizes = "_-2fK" (String#6857, DoABC#2)
// HabboCatalogCom_purse_coins_small = "_-1Cn" (String#5122, DoABC#2)
// HabboCatalogCom_purchaseWidgetBuyVipStub = "_-2aP" (String#6766, DoABC#2)
// HabboCatalogCom_icon_bg_img_2 = "_-2yV" (String#7249, DoABC#2)
// HabboCatalogCom_recyclerWidgetTimeout = "_-1cC" (String#5605, DoABC#2)
// HabboCatalogCom_manifest = "_-3Iy" (String#7689, DoABC#2)
// HabboCatalogCom_ctlg_norares = "_-26V" (String#6176, DoABC#2)
// HabboCatalogCom_club_buy_confirmation = "_-2jB" (String#6940, DoABC#2)
// HabboCatalogCom_ctlg_default_3x3 = "_-2Mz" (String#6499, DoABC#2)
// HabboCatalogCom_layout_bg = "_-2G1" (String#6364, DoABC#2)
// HabboCatalogCom_testarrow_right = "_-0j9" (String#4482, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_gift_checked = "_-Du" (String#7950, DoABC#2)
// HabboCatalogCom_marketplace_sold_item = "_-1Su" (String#5412, DoABC#2)
// HabboCatalogCom_marketplace_expired_item = "_-2Dw" (String#6319, DoABC#2)
// HabboCatalogCom_purchase_confirmation = "_-1SP" (String#5404, DoABC#2)
// HabboCatalogCom_textInputWidget = "_-0P7" (String#4072, DoABC#2)
// HabboCatalogCom_ctlg_pic_deal_icon_narrow = "_-30U" (String#7314, DoABC#2)
// HabboCatalogCom_ctlg_pixelrent = "_-2Uf" (String#6659, DoABC#2)
// HabboCatalogCom_productViewWidget = "_-0yq" (String#4824, DoABC#2)
// HabboCatalogCom_ctlg_club_gifts = "_-0Fb" (String#3863, DoABC#2)
// HabboCatalogCom_ctlg_productpage3b = "_-1cL" (String#5607, DoABC#2)
// HabboCatalogCom_ctlg_info_credits = "_-3Bu" (String#7550, DoABC#2)
// HabboCatalogCom_ctlg_pic_DEV_fx_explosion = "_-1hK" (String#5691, DoABC#2)
// HabboCatalogCom_list_item_list = "_-2Xa" (String#6714, DoABC#2)
// HabboCatalogCom_club_gift_preview = "_-0T1" (String#4160, DoABC#2)
// HabboCatalogCom_club_buy_hc_item = "_-9u" (String#7861, DoABC#2)
// HabboCatalogCom_ctlg_club1 = "_-3La" (String#7730, DoABC#2)
// HabboCatalogCom_ctlg_club2 = "_-2B2" (String#6268, DoABC#2)
// HabboCatalogCom_gridItem = "_-0NM" (String#4026, DoABC#2)
// HabboCatalogCom_ctlg_purse = "_-2ni" (String#7034, DoABC#2)
// HabboCatalogCom_recyclerPrizesWidgetLevelItem = "_-2K6" (String#6445, DoABC#2)
// HabboCatalogCom_ctlg_clr_27x22_1 = "_-0gh" (String#4438, DoABC#2)
// HabboCatalogCom_catalog_with_purse = "_-2yF" (String#7243, DoABC#2)
// HabboCatalogCom_ctlg_clr_27x22_3 = "_-0av" (String#4322, DoABC#2)
// HabboCatalogCom_ctlg_clr_27x22_2 = "_-wv" (String#8823, DoABC#2)
// HabboCatalogCom_ctlg_arrow_down = "_-0ko" (String#4517, DoABC#2)
// HabboCatalogCom_purchaseWidgetUpgradeVipStub = "_-0px" (String#4634, DoABC#2)
// HabboCatalogCom_purchaseWidgetBuyClubStub = "_-iu" (String#8576, DoABC#2)
// HabboCatalogCom_marketPlaceOwnItemsWidget = "_-2yu" (String#7259, DoABC#2)
// HabboCatalogCom_ctlg_pixeleffects = "_-1E4" (String#5142, DoABC#2)
// HabboCatalogCom_ctlg_collectibles = "_-1ig" (String#5727, DoABC#2)
// HabboCatalogCom_bundleGridWidget = "_-ez" (String#8497, DoABC#2)
// HabboCatalogCom_charge_confirmation = "_-P0" (String#8185, DoABC#2)
// HabboCatalogCom_gift_wrapping = "_-yw" (String#8860, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_nocredits = "_-0oF" (String#4598, DoABC#2)
// HabboCatalogCom_ctlg_monkey = "_-06t" (String#3700, DoABC#2)
// HabboCatalogCom_ctlg_productpage1 = "_-DP" (String#7940, DoABC#2)
// HabboCatalogCom_purse_pixels_small = "_-GR" (String#8004, DoABC#2)
// HabboCatalogCom_ctlg_productpage3 = "_-0Xq" (String#4264, DoABC#2)
// HabboCatalogCom_ctlg_productpage2 = "_-0sv" (String#4703, DoABC#2)
// HabboCatalogCom_marketplace_offer_details = "_-sS" (String#8745, DoABC#2)
// HabboCatalogCom_ctlg_club_buy = "_-0ZF" (String#4285, DoABC#2)
// HabboCatalogCom_icon_bg_img = "_-06n" (String#3698, DoABC#2)
// HabboCatalogCom_ctlg_pic_DEV_fx_flare = "_-vK" (String#8790, DoABC#2)
// HabboCatalogCom_testarrow_down = "_-0rT" (String#4674, DoABC#2)
// HabboCatalogCom_ctlg_layout3 = "_-se" (String#8749, DoABC#2)
// HabboCatalogCom_ctlg_pixeldeals = "_-0Ed" (String#3841, DoABC#2)
// HabboCatalogCom_ctlg_layout2 = "_-2n9" (String#7024, DoABC#2)
// HabboCatalogCom_ctlg_layout1 = "_-2q1" (String#7079, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_dialog = "_-20O" (String#6053, DoABC#2)
// HabboCatalogCom_ctlg_infopage2 = "_-2tO" (String#7146, DoABC#2)
// HabboCatalogCom_ctlg_infopage1 = "_-16s" (String#5013, DoABC#2)
// HabboCatalogCom_color_chooser_cell = "_-1KL" (String#5250, DoABC#2)
// HabboCatalogCom_gift_no_wrapping = "_-2H2" (String#6387, DoABC#2)
// HabboCatalogCom_purse_club_small = "_-0aP" (String#4310, DoABC#2)
// HabboCatalogCom_ctlg_spaces_new = "_-Ld" (String#8118, DoABC#2)
// HabboCatalogCom_purchaseWidgetCreditsStub = "_-1K5" (String#5245, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_cantbuycredits = "_-2G3" (String#6366, DoABC#2)
// HabboCatalogCom_spaces = "_-0RS" (String#4122, DoABC#2)
// HabboCatalogCom_ctlg_camera2 = "_-Ub" (String#8297, DoABC#2)
// HabboCatalogCom_ctlg_camera1 = "_-2kQ" (String#6965, DoABC#2)
// HabboCatalogCom_ctlg_spaces = "_-QZ" (String#8216, DoABC#2)
// HabboCatalogCom_ctlg_loading = "_-2Av" (String#6266, DoABC#2)
// HabboCatalogCom_clubBuyWidget = "_-0bV" (String#4332, DoABC#2)
// HabboCatalogCom_club_gift_list_item = "_-1Nd" (String#5303, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_gift_unchecked = "_-3Gp" (String#7643, DoABC#2)
// HabboCatalogCom_ctlg_recycler_info = "_-1ak" (String#5573, DoABC#2)
// HabboCatalogCom_ctrl_info_credits = "_-0wU" (String#4781, DoABC#2)
// HabboCatalogCom_ctlg_pic_fx_bubble = "_-2sD" (String#7125, DoABC#2)
// HabboCatalogCom_ctlg_arrow_right = "_-21k" (String#6078, DoABC#2)
// HabboCatalogCom_bot_thumb_bg_selected = "_-1uR" (String#5928, DoABC#2)
// HabboCatalogCom_marketplace_offers_item = "_-2X-" (String#6700, DoABC#2)
// HabboCatalogCom_navigation_list_subitem = "_-33P" (String#7372, DoABC#2)
// HabboCatalogCom_club_buy_vip_item = "_-37s" (String#7466, DoABC#2)
// HabboCatalogCom_clubGiftWidget = "_-0LW" (String#3992, DoABC#2)
// HabboCatalogCom_ctlg_trophies = "_-1yi" (String#6007, DoABC#2)
// HabboCatalogCom_catalog = "_-2gD" (String#6874, DoABC#2)
// HabboCatalogCom_redeemItemCodeWidget = "_-00k" (String#3577, DoABC#2)
// HabboCatalogCom_club_buy_info_item = "_-WC" (String#8327, DoABC#2)
// HabboCatalogCom_suggestion_list_item = "_-2By" (String#6284, DoABC#2)
// HabboCatalogCom_club_buy_vip_upgrade_item = "_-hY" (String#8546, DoABC#2)
// HabboCatalogCom_singleViewWidget = "_-1Kh" (String#5255, DoABC#2)
// HabboCatalogCom_ctlg_plasto = "_-0jB" (String#4483, DoABC#2)
// HabboCatalogCom_purchaseWidgetCreditsPixelsStub = "_-04d" (String#3658, DoABC#2)
// HabboCatalogCom_ctlg_presents = "_-GX" (String#8008, DoABC#2)
// HabboCatalogCom_ctlg_icon_deal_hc = "_-0R6" (String#4115, DoABC#2)
// HabboCatalogCom_ctlg_clr_40x32_1 = "_-1PG" (String#5339, DoABC#2)
// HabboCatalogCom_ctlg_clr_40x32_2 = "_-2V6" (String#6667, DoABC#2)
// HabboCatalogCom_trophyWidget = "_-2r" (String#7097, DoABC#2)
// HabboCatalogCom_ctlg_clr_40x32_3 = "_-0i1" (String#4466, DoABC#2)
// HabboCatalogCom_habbo_orderinfo_receiver_suggestion = "_-0Xf" (String#4260, DoABC#2)
// HabboCatalogCom_thumb_bg = "_-2ln" (String#7000, DoABC#2)
// HabboCatalogCom_ctlg_pixelsdeals = "_-2RE" (String#6587, DoABC#2)
// HabboCatalogCom_ctlg_mad_money = "_-2rU" (String#7113, DoABC#2)
// HabboCatalogCom_configuration_catalog_spaces = "_-2JD" (String#6424, DoABC#2)
// HabboCatalogCom_ctlg_marketplace_own_items = "_-07l" (String#3717, DoABC#2)
// HabboCatalogCom_gift_palette_item = "_-30b" (String#7316, DoABC#2)
// HabboCatalogCom_purchaseWidget = "_-0ws" (String#4788, DoABC#2)
// HabboCatalogCom_marketplace_purchase_confirmation = "_-RZ" (String#8238, DoABC#2)
// HabboCatalogCom_purseWidget = "_-2FZ" (String#6354, DoABC#2)
// HabboCatalogCom_icon_activity_point_1 = "_-3DY" (String#7587, DoABC#2)
// HabboCatalogCom_icon_credit_5 = "_-0bf" (String#4337, DoABC#2)
// HabboCatalogCom_marketplace_ongoing_item = "_-21y" (String#6086, DoABC#2)
// HabboCatalogCom_icon_credit_6 = "_-017" (String#3586, DoABC#2)
// HabboCatalogCom_icon_credit_3 = "_-1pe" (String#5847, DoABC#2)
// HabboCatalogCom_recyclerWidget = "_-0Qy" (String#4110, DoABC#2)
// HabboCatalogCom_icon_credit_4 = "_-0WG" (String#4232, DoABC#2)
// HabboCatalogCom_icon_credit_1 = "_-1VL" (String#5463, DoABC#2)
// HabboCatalogCom_icon_credit_2 = "_-1hj" (String#5702, DoABC#2)
// HabboCatalogCom_effectViewWidget = "_-ZM" (String#8403, DoABC#2)
// HabboCatalogCom_ctlg_recycler = "_-S9" (String#8250, DoABC#2)
// HabboCatalogCom_specialInfoWidget = "_-P6" (String#8186, DoABC#2)
// HabboCatalogCom_ctlg_soundmachine = "_-CA" (String#7916, DoABC#2)
// HabboCatalogCom_ctlg_arrow_prev = "_-4A" (String#7747, DoABC#2)
// HabboCatalogCom_icon_activity_point_4 = "_-2sp" (String#7136, DoABC#2)
// HabboCatalogCom_icon_activity_point_3 = "_-39A" (String#7493, DoABC#2)
// HabboCatalogCom_icon_activity_point_2 = "_-0Oi" (String#4063, DoABC#2)
// HabboCatalogCom_purchaseWidgetPixelsStub = "_-0KR" (String#3964, DoABC#2)
// HabboCatalogCom_ctlg_productpage2b = "_-1X-" (String#5495, DoABC#2)
// HabboCatalogCom_marketplace_search_advanced = "_-1eM" (String#5635, DoABC#2)
// HabboCatalogCom_marketPlaceWidget = "_-08O" (String#3729, DoABC#2)
// HabboCatalogCom_ctlg_recycler_slot_bg = "_-1aQ" (String#5568, DoABC#2)
// HabboCatalogCom_bot_thumb_bg = "_-196" (String#5058, DoABC#2)
// HabboCatalogCom_ctlg_marketplace = "_-0aK" (String#4308, DoABC#2)
// HabboCatalogCom_recyclerWidgetInactive = "_-2ij" (String#6926, DoABC#2)
// HabboCatalogCom_club_gift_confirmation = "_-2Qy" (String#6577, DoABC#2)
// HabboCatalogCom_ctlg_frontpage1 = "_-2KB" (String#6448, DoABC#2)
// HabboCatalogCom_icon_credit_0 = "_-02L" (String#3613, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.habbo.communication.HabboCommunicationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;

    public class HabboCommunicationCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCommunicationCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCommunicationManager, IIDHabboCommunicationManager);
        private static const _encodeChars:Vector.<int> = _initEncoreChar();

        public static function encodeByteArray(data:ByteArray):String
        {
            var c:uint = null;
            var out:ByteArray = new ByteArray();
            out.length = (((2 + data.length) - (data.length + 2)) % ((3 * 4) / 3));
            var i:int;
            var r:int = (data.length % 3);
            var len:int = (data.length - r);
            var outPos:int;
            while (i < len) {
                c = (((data[int(i++)] << 16) | (data[int(i++)] << 8)) | data[int(i++)]);
                out[int(outPos++)] = _encodeChars[int((c >>> 18))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 12) & 63))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 6) & 63))];
                out[int(outPos++)] = _encodeChars[int((c & 63))];
            };
            if (r == 1){
                c = data[int(i)];
                out[int(outPos++)] = _encodeChars[int((c >>> 2))];
                out[int(outPos++)] = _encodeChars[int(((c & 3) << 4))];
                out[int(outPos++)] = 61;
                out[int(outPos++)] = 61;
            }
            else {
                if (r == 2){
                    c = ((data[int(i++)] << 8) | data[int(i)]);
                    out[int(outPos++)] = _encodeChars[int((c >>> 10))];
                    out[int(outPos++)] = _encodeChars[int(((c >>> 4) & 63))];
                    out[int(outPos++)] = _encodeChars[int(((c & 15) << 2))];
                    out[int(outPos++)] = 61;
                };
            };
            return (out.readUTFBytes(out.length));
        }
        private static function _initEncoreChar():Vector.<int>
        {
            var i:int;
            var encodeChars:Vector.<int> = new Vector.<int>(64, true);
            var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            i = 0;
            while (i < 64) {
                encodeChars[i] = chars.charCodeAt(i);
                i++;
            };
            return (encodeChars);
        }

    }
}//package 

// HabboCommunicationCom_manifest = "_-0Jk" (String#3945, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboCommunicationDemo;

    public class HabboCommunicationDemoCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCommunicationDemoCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCommunicationDemo);
        public static var login_window:Class = HabboCommunicationDemoCom_login_window;
        public static var air_login_window:Class = HabboCommunicationDemoCom_air_login_window;
        public static var hotel_view_window:Class = HabboCommunicationDemoCom_hotel_view_window;
        public static var login_user_list_item:Class = HabboCommunicationDemoCom_login_user_list_item;
        public static var message_tester:Class = HabboCommunicationDemoCom_message_tester;

    }
}//package 

// HabboCommunicationDemoCom_hotel_view_window = "_-0iN" (String#4471, DoABC#2)
// HabboCommunicationDemoCom_login_user_list_item = "_-1Bt" (String#5108, DoABC#2)
// HabboCommunicationDemoCom_manifest = "_-2yr" (String#7258, DoABC#2)
// HabboCommunicationDemoCom_air_login_window = "_-0V-" (String#4205, DoABC#2)
// HabboCommunicationDemoCom_message_tester = "_-2p9" (String#7062, DoABC#2)
// HabboCommunicationDemoCom_login_window = "_-Gw" (String#8014, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboConfigurationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.configuration.HabboConfigurationManager;

    public class HabboConfigurationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboConfigurationManager, IIDHabboConfigurationManager);
        public static var manifest:Class = HabboConfigurationCom_manifest;
        public static var default_configuration:Class = HabboConfigurationCom_default_configuration;
        public static var IIDHabboConfigurationManager:Class = IIDHabboConfigurationManager;
        public static var HabboConfigurationManager:Class = HabboConfigurationManager;

    }
}//package 

// HabboConfigurationCom_manifest = "_-14e" (String#4972, DoABC#2)
// HabboConfigurationCom_default_configuration = "_-3Id" (String#7682, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboFriendBar;

    public class HabboFriendBarCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboFriendBarCom_manifest;
        public static var bar_xml:Class = HabboFriendBarCom_bar_xml;
        public static var entity_xml:Class = HabboFriendBarCom_entity_xml;
        public static var add_friends_tab_xml:Class = HabboFriendBarCom_add_friends_tab_xml;
        public static var friend_requests_tab_xml:Class = HabboFriendBarCom_friend_requests_tab_xml;
        public static var friend_request_tab_xml:Class = HabboFriendBarCom_friend_request_tab_xml;
        public static var toggle_xml:Class = HabboFriendBarCom_toggle_xml;
        public static var facebook_piece_xml:Class = HabboFriendBarCom_facebook_piece_xml;
        public static var controls_piece_xml:Class = HabboFriendBarCom_controls_piece_xml;
        public static var message_piece_xml:Class = HabboFriendBarCom_message_piece_xml;
        public static var event_stream_display_xml:Class = HabboFriendBarCom_event_stream_display_xml;
        public static var stream_welcome_png:Class = HabboFriendBarCom_stream_welcome_png;
        public static var stream_empty_png:Class = HabboFriendBarCom_stream_empty_png;
        public static var stream_thumb_png:Class = HabboFriendBarCom_stream_thumb_png;
        public static var ach_notification_icon_png:Class = HabboFriendBarCom_ach_notification_icon_png;
        public static var event_notification_icon_png:Class = HabboFriendBarCom_event_notification_icon_png;
        public static var im_notification_icon_png:Class = HabboFriendBarCom_im_notification_icon_png;
        public static var imnew_notification_icon_png:Class = HabboFriendBarCom_imnew_notification_icon_png;
        public static var small_ach_notification_icon_png:Class = HabboFriendBarCom_small_ach_notification_icon_png;
        public static var small_event_notification_icon_png:Class = HabboFriendBarCom_small_event_notification_icon_png;
        public static var small_imnew_notification_icon_png:Class = HabboFriendBarCom_small_imnew_notification_icon_png;
        public static var plus_friend_icon_png:Class = HabboFriendBarCom_plus_friend_icon_png;
        public static var add_friends_icon_png:Class = HabboFriendBarCom_add_friends_icon_png;
        public static var find_friends_icon_png:Class = HabboFriendBarCom_find_friends_icon_png;
        public static var fb_icon_small_png:Class = HabboFriendBarCom_fb_icon_small_png;
        public static var friends_icon_png:Class = HabboFriendBarCom_friends_icon_png;
        public static var icon_friendlist_png:Class = HabboFriendBarCom_icon_friendlist_png;
        public static var icon_friendlist_notify_0_png:Class = HabboFriendBarCom_icon_friendlist_notify_0_png;
        public static var icon_friendlist_notify_1_png:Class = HabboFriendBarCom_icon_friendlist_notify_1_png;
        public static var icon_friendlist_hover_0_png:Class = HabboFriendBarCom_icon_friendlist_hover_0_png;
        public static var icon_friendlist_hover_1_png:Class = HabboFriendBarCom_icon_friendlist_hover_1_png;
        public static var icon_friendlist_hover_2_png:Class = HabboFriendBarCom_icon_friendlist_hover_2_png;
        public static var icon_friendlist_hover_3_png:Class = HabboFriendBarCom_icon_friendlist_hover_3_png;
        public static var icon_messenger_png:Class = HabboFriendBarCom_icon_messenger_png;
        public static var icon_messenger_notify_0_png:Class = HabboFriendBarCom_icon_messenger_notify_0_png;
        public static var icon_messenger_notify_1_png:Class = HabboFriendBarCom_icon_messenger_notify_1_png;
        public static var icon_stream_png:Class = HabboFriendBarCom_icon_stream_png;
        public static var icon_stream_hover_png:Class = HabboFriendBarCom_icon_stream_hover_png;
        public static var icon_stream_new_png:Class = HabboFriendBarCom_icon_stream_new_png;
        public static var icon_stream_new_hover_png:Class = HabboFriendBarCom_icon_stream_new_hover_png;
        public static var requiredClasses:Array = new Array(HabboFriendBar);

    }
}//package 

// HabboFriendBarCom_icon_friendlist_notify_0_png = "_-QO" (String#8211, DoABC#2)
// HabboFriendBarCom_small_ach_notification_icon_png = "_-18F" (String#5041, DoABC#2)
// HabboFriendBarCom_stream_thumb_png = "_-11Y" (String#4907, DoABC#2)
// HabboFriendBarCom_icon_stream_png = "_-0Pu" (String#4089, DoABC#2)
// HabboFriendBarCom_event_notification_icon_png = "_-37U" (String#7458, DoABC#2)
// HabboFriendBarCom_imnew_notification_icon_png = "_-99" (String#7845, DoABC#2)
// HabboFriendBarCom_event_stream_display_xml = "_-17n" (String#1624, DoABC#2)
// HabboFriendBarCom_friend_requests_tab_xml = "_-X" (String#2125, DoABC#2)
// HabboFriendBarCom_icon_friendlist_hover_1_png = "_-93" (String#7843, DoABC#2)
// HabboFriendBarCom_icon_stream_new_png = "_-Xs" (String#8366, DoABC#2)
// HabboFriendBarCom_ach_notification_icon_png = "_-1nV" (String#5811, DoABC#2)
// HabboFriendBarCom_icon_friendlist_hover_2_png = "_-0vS" (String#4756, DoABC#2)
// HabboFriendBarCom_add_friends_tab_xml = "_-R5" (String#2107, DoABC#2)
// HabboFriendBarCom_icon_stream_hover_png = "_-054" (String#3667, DoABC#2)
// HabboFriendBarCom_plus_friend_icon_png = "_-00" (String#3564, DoABC#2)
// HabboFriendBarCom_icon_friendlist_hover_3_png = "_-2bj" (String#6789, DoABC#2)
// HabboFriendBarCom_stream_empty_png = "_-3De" (String#7590, DoABC#2)
// HabboFriendBarCom_small_imnew_notification_icon_png = "_-33v" (String#7385, DoABC#2)
// HabboFriendBarCom_icon_friendlist_hover_0_png = "_-2Hd" (String#6397, DoABC#2)
// HabboFriendBarCom_add_friends_icon_png = "_-2ua" (String#7170, DoABC#2)
// HabboFriendBarCom_icon_messenger_png = "_-I5" (String#8042, DoABC#2)
// HabboFriendBarCom_small_event_notification_icon_png = "_-0v1" (String#4746, DoABC#2)
// HabboFriendBarCom_icon_friendlist_notify_1_png = "_-1lV" (String#5775, DoABC#2)
// HabboFriendBarCom_manifest = "_-0Hz" (String#1446, DoABC#2)
// HabboFriendBarCom_im_notification_icon_png = "_-0F5" (String#3853, DoABC#2)
// HabboFriendBarCom_bar_xml = "_-2MY" (String#1864, DoABC#2)
// HabboFriendBarCom_fb_icon_small_png = "_-ba" (String#8448, DoABC#2)
// HabboFriendBarCom_controls_piece_xml = "_-x-" (String#2221, DoABC#2)
// HabboFriendBarCom_entity_xml = "_-04h" (String#1397, DoABC#2)
// HabboFriendBarCom_message_piece_xml = "_-3CE" (String#2019, DoABC#2)
// HabboFriendBarCom_stream_welcome_png = "_-2Y" (String#6725, DoABC#2)
// HabboFriendBarCom_find_friends_icon_png = "_-1Lt" (String#5275, DoABC#2)
// HabboFriendBarCom_facebook_piece_xml = "_-3LS" (String#2044, DoABC#2)
// HabboFriendBarCom_icon_messenger_notify_0_png = "_-1pp" (String#5852, DoABC#2)
// HabboFriendBarCom_icon_friendlist_png = "_-2U7" (String#6649, DoABC#2)
// HabboFriendBarCom_toggle_xml = "_-y6" (String#2227, DoABC#2)
// HabboFriendBarCom_friend_request_tab_xml = "_-0DR" (String#1432, DoABC#2)
// HabboFriendBarCom_icon_messenger_notify_1_png = "_-0LS" (String#3989, DoABC#2)
// HabboFriendBarCom_friends_icon_png = "_-1OA" (String#5314, DoABC#2)
// HabboFriendBarCom_icon_stream_new_hover_png = "_-2Vf" (String#6677, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboFriendList;
    import com.sulake.iid.IIDHabboFriendList;

    public class HabboFriendListCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboFriendListCom_manifest;
        public static var arrow_down_black_png:Class = HabboFriendListCom_arrow_down_black_png;
        public static var arrow_down_white_png:Class = HabboFriendListCom_arrow_down_white_png;
        public static var arrow_right_black_png:Class = HabboFriendListCom_arrow_right_black_png;
        public static var arrow_right_white_png:Class = HabboFriendListCom_arrow_right_white_png;
        public static var ask_for_friend_png:Class = HabboFriendListCom_ask_for_friend_png;
        public static var follow_friend_png:Class = HabboFriendListCom_follow_friend_png;
        public static var hdr_friend_requests_png:Class = HabboFriendListCom_hdr_friend_requests_png;
        public static var hdr_friends_png:Class = HabboFriendListCom_hdr_friends_png;
        public static var hdr_hilite_png:Class = HabboFriendListCom_hdr_hilite_png;
        public static var hdr_search_png:Class = HabboFriendListCom_hdr_search_png;
        public static var minimail_png:Class = HabboFriendListCom_minimail_png;
        public static var offline_png:Class = HabboFriendListCom_offline_png;
        public static var open_edit_ctgs_png:Class = HabboFriendListCom_open_edit_ctgs_png;
        public static var open_homepage_png:Class = HabboFriendListCom_open_homepage_png;
        public static var open_inbox_png:Class = HabboFriendListCom_open_inbox_png;
        public static var open_minimail_png:Class = HabboFriendListCom_open_minimail_png;
        public static var opened_to_web_png:Class = HabboFriendListCom_opened_to_web_png;
        public static var popup_arrow_left_png:Class = HabboFriendListCom_popup_arrow_left_png;
        public static var popup_arrow_right_png:Class = HabboFriendListCom_popup_arrow_right_png;
        public static var remove_friend_png:Class = HabboFriendListCom_remove_friend_png;
        public static var room_invite_png:Class = HabboFriendListCom_room_invite_png;
        public static var start_chat_png:Class = HabboFriendListCom_start_chat_png;
        public static var search_png:Class = HabboFriendListCom_search_png;
        public static var avatar_popup_xml:Class = HabboFriendListCom_avatar_popup_xml;
        public static var friend_entry_xml:Class = HabboFriendListCom_friend_entry_xml;
        public static var friend_remove_confirm_xml:Class = HabboFriendListCom_friend_remove_confirm_xml;
        public static var friend_request_entry_xml:Class = HabboFriendListCom_friend_request_entry_xml;
        public static var friend_requests_footer_xml:Class = HabboFriendListCom_friend_requests_footer_xml;
        public static var friends_footer_xml:Class = HabboFriendListCom_friends_footer_xml;
        public static var opened_to_web_popup_xml:Class = HabboFriendListCom_opened_to_web_popup_xml;
        public static var pagelink_xml:Class = HabboFriendListCom_pagelink_xml;
        public static var main_window_xml:Class = HabboFriendListCom_main_window_xml;
        public static var room_invite_confirm_xml:Class = HabboFriendListCom_room_invite_confirm_xml;
        public static var search_entry_xml:Class = HabboFriendListCom_search_entry_xml;
        public static var search_footer_xml:Class = HabboFriendListCom_search_footer_xml;
        public static var simple_alert_xml:Class = HabboFriendListCom_simple_alert_xml;
        public static var tab_content_xml:Class = HabboFriendListCom_tab_content_xml;
        public static var requiredClasses:Array = new Array(HabboFriendList, IIDHabboFriendList);

    }
}//package 

// HabboFriendListCom_search_png = "_-1J" (String#5220, DoABC#2)
// HabboFriendListCom_follow_friend_png = "_-01g" (String#3595, DoABC#2)
// HabboFriendListCom_remove_friend_png = "_-0bc" (String#4336, DoABC#2)
// HabboFriendListCom_arrow_right_white_png = "_-6x" (String#7805, DoABC#2)
// HabboFriendListCom_hdr_search_png = "_-0eX" (String#4401, DoABC#2)
// HabboFriendListCom_simple_alert_xml = "_-0ek" (String#4406, DoABC#2)
// HabboFriendListCom_opened_to_web_popup_xml = "_-10a" (String#4884, DoABC#2)
// HabboFriendListCom_manifest = "_-19Z" (String#5068, DoABC#2)
// HabboFriendListCom_pagelink_xml = "_-1cb" (String#5612, DoABC#2)
// HabboFriendListCom_friend_request_entry_xml = "_-1ZW" (String#5554, DoABC#2)
// HabboFriendListCom_minimail_png = "_-Az" (String#7887, DoABC#2)
// HabboFriendListCom_open_inbox_png = "_-3KW" (String#7713, DoABC#2)
// HabboFriendListCom_room_invite_png = "_-Bg" (String#7904, DoABC#2)
// HabboFriendListCom_start_chat_png = "_-1z9" (String#6019, DoABC#2)
// HabboFriendListCom_hdr_hilite_png = "_-284" (String#6205, DoABC#2)
// HabboFriendListCom_hdr_friends_png = "_-281" (String#6203, DoABC#2)
// HabboFriendListCom_open_edit_ctgs_png = "_-1iy" (String#5734, DoABC#2)
// HabboFriendListCom_arrow_down_white_png = "_-0rU" (String#4675, DoABC#2)
// HabboFriendListCom_arrow_down_black_png = "_-0eI" (String#4397, DoABC#2)
// HabboFriendListCom_offline_png = "_-Vg" (String#8314, DoABC#2)
// HabboFriendListCom_ask_for_friend_png = "_-1Ql" (String#5367, DoABC#2)
// HabboFriendListCom_open_minimail_png = "_-0Fn" (String#3869, DoABC#2)
// HabboFriendListCom_room_invite_confirm_xml = "_-2ND" (String#6507, DoABC#2)
// HabboFriendListCom_friends_footer_xml = "_-2Zr" (String#6757, DoABC#2)
// HabboFriendListCom_search_footer_xml = "_-0Wu" (String#4246, DoABC#2)
// HabboFriendListCom_search_entry_xml = "_-2TS" (String#6634, DoABC#2)
// HabboFriendListCom_hdr_friend_requests_png = "_-23G" (String#6111, DoABC#2)
// HabboFriendListCom_friend_requests_footer_xml = "_-it" (String#8575, DoABC#2)
// HabboFriendListCom_arrow_right_black_png = "_-0o7" (String#4596, DoABC#2)
// HabboFriendListCom_open_homepage_png = "_-0M9" (String#4004, DoABC#2)
// HabboFriendListCom_avatar_popup_xml = "_-14a" (String#4969, DoABC#2)
// HabboFriendListCom_popup_arrow_right_png = "_-38e" (String#7485, DoABC#2)
// HabboFriendListCom_tab_content_xml = "_-0pa" (String#4624, DoABC#2)
// HabboFriendListCom_popup_arrow_left_png = "_-3Z" (String#7739, DoABC#2)
// HabboFriendListCom_opened_to_web_png = "_-0wM" (String#4778, DoABC#2)
// HabboFriendListCom_main_window_xml = "_-12T" (String#4924, DoABC#2)
// HabboFriendListCom_friend_remove_confirm_xml = "_-2cz" (String#6813, DoABC#2)
// HabboFriendListCom_friend_entry_xml = "_-1cj" (String#5614, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboGroupsManager;
    import com.sulake.iid.IIDHabboGroupsManager;

    public class HabboGroupsCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboGroupsCom_manifest;
        public static var requiredClasses:Array = new Array(HabboGroupsManager, IIDHabboGroupsManager);

    }
}//package 

// HabboGroupsCom_manifest = "_-2Xq" (String#6721, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboHelp;
    import com.sulake.iid.IIDHabboHelp;

    public class HabboHelpCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHelpCom_manifest;
        public static var placeholder_xml:Class = HabboHelpCom_placeholder_xml;
        public static var help_frame_xml:Class = HabboHelpCom_help_frame_xml;
        public static var help_back_button_xml:Class = HabboHelpCom_help_back_button_xml;
        public static var help_front_page_xml:Class = HabboHelpCom_help_front_page_xml;
        public static var help_faq_categories_xml:Class = HabboHelpCom_help_faq_categories_xml;
        public static var help_faq_category_xml:Class = HabboHelpCom_help_faq_category_xml;
        public static var help_faq_entry_xml:Class = HabboHelpCom_help_faq_entry_xml;
        public static var help_itemlist_item_xml:Class = HabboHelpCom_help_itemlist_item_xml;
        public static var help_itemlist_item_urgent_xml:Class = HabboHelpCom_help_itemlist_item_urgent_xml;
        public static var help_itemlist_item_white_bg_xml:Class = HabboHelpCom_help_itemlist_item_white_bg_xml;
        public static var help_cfh_send_xml:Class = HabboHelpCom_help_cfh_send_xml;
        public static var help_cfh_pick_topic_xml:Class = HabboHelpCom_help_cfh_pick_topic_xml;
        public static var help_cfh_pick_topic_item_xml:Class = HabboHelpCom_help_cfh_pick_topic_item_xml;
        public static var help_cfh_thanks_xml:Class = HabboHelpCom_help_cfh_thanks_xml;
        public static var help_cfh_abusive_xml:Class = HabboHelpCom_help_cfh_abusive_xml;
        public static var help_cfh_pending_xml:Class = HabboHelpCom_help_cfh_pending_xml;
        public static var report_user_pick_topic_xml:Class = HabboHelpCom_report_user_pick_topic_xml;
        public static var report_user_send_xml:Class = HabboHelpCom_report_user_send_xml;
        public static var report_user_pick_user_xml:Class = HabboHelpCom_report_user_pick_user_xml;
        public static var report_user_pick_user_item_xml:Class = HabboHelpCom_report_user_pick_user_item_xml;
        public static var hotel_merge_name_change_xml:Class = HabboHelpCom_hotel_merge_name_change_xml;
        public static var hotel_merge_name_selection_xml:Class = HabboHelpCom_hotel_merge_name_selection_xml;
        public static var hotel_merge_name_confirmation_xml:Class = HabboHelpCom_hotel_merge_name_confirmation_xml;
        public static var welcome_name_change_xml:Class = HabboHelpCom_welcome_name_change_xml;
        public static var welcome_name_selection_xml:Class = HabboHelpCom_welcome_name_selection_xml;
        public static var welcome_name_confirmation_xml:Class = HabboHelpCom_welcome_name_confirmation_xml;
        public static var welcome_screen_xml:Class = HabboHelpCom_welcome_screen_xml;
        public static var welcome_screen_arrow:Class = HabboHelpCom_welcome_screen_arrow;
        public static var back_png:Class = HabboHelpCom_back_png;
        public static var back_hi_png:Class = HabboHelpCom_back_hi_png;
        public static var guidebot_icon_png:Class = HabboHelpCom_guidebot_icon_png;
        public static var tutorial_frame_xml:Class = HabboHelpCom_tutorial_frame_xml;
        public static var tutorial_front_page_xml:Class = HabboHelpCom_tutorial_front_page_xml;
        public static var tutorial_change_name_xml:Class = HabboHelpCom_tutorial_change_name_xml;
        public static var tutorial_change_name_confirmation_xml:Class = HabboHelpCom_tutorial_change_name_confirmation_xml;
        public static var tutorial_change_clothes_xml:Class = HabboHelpCom_tutorial_change_clothes_xml;
        public static var tutorial_call_guidebot_xml:Class = HabboHelpCom_tutorial_call_guidebot_xml;
        public static var tutorial_name_suggestion_item_xml:Class = HabboHelpCom_tutorial_name_suggestion_item_xml;
        public static var tutorial_arrow_xml:Class = HabboHelpCom_tutorial_arrow_xml;
        public static var tutorial_button_changelooks_over:Class = HabboHelpCom_tutorial_button_changelooks_over;
        public static var tutorial_button_changelooks:Class = HabboHelpCom_tutorial_button_changelooks;
        public static var tutorial_button_changename_over:Class = HabboHelpCom_tutorial_button_changename_over;
        public static var tutorial_button_changename:Class = HabboHelpCom_tutorial_button_changename;
        public static var tutorial_button_guidebot_over:Class = HabboHelpCom_tutorial_button_guidebot_over;
        public static var tutorial_button_guidebot:Class = HabboHelpCom_tutorial_button_guidebot;
        public static var tutorial_button_min_bg:Class = HabboHelpCom_tutorial_button_min_bg;
        public static var tutorial_button_min_over:Class = HabboHelpCom_tutorial_button_min_over;
        public static var tutorial_button_min:Class = HabboHelpCom_tutorial_button_min;
        public static var tutorial_button_name_check:Class = HabboHelpCom_tutorial_button_name_check;
        public static var tutorial_button_name_check_over:Class = HabboHelpCom_tutorial_button_name_check_over;
        public static var tutorial_highlight_blue_arrow:Class = HabboHelpCom_tutorial_highlight_blue_arrow;
        public static var requiredClasses:Array = new Array(HabboHelp, IIDHabboHelp);

    }
}//package 

// HabboHelpCom_help_frame_xml = "_-04i" (String#3661, DoABC#2)
// HabboHelpCom_hotel_merge_name_confirmation_xml = "_-2Jq" (String#6435, DoABC#2)
// HabboHelpCom_hotel_merge_name_selection_xml = "_-1G2" (String#5170, DoABC#2)
// HabboHelpCom_tutorial_name_suggestion_item_xml = "_-0hF" (String#4450, DoABC#2)
// HabboHelpCom_back_hi_png = "_-36-" (String#7430, DoABC#2)
// HabboHelpCom_tutorial_front_page_xml = "_-1K1" (String#5243, DoABC#2)
// HabboHelpCom_tutorial_button_changelooks_over = "_-1gw" (String#5682, DoABC#2)
// HabboHelpCom_placeholder_xml = "_-0Zv" (String#4297, DoABC#2)
// HabboHelpCom_manifest = "_-c2" (String#8456, DoABC#2)
// HabboHelpCom_tutorial_button_changename_over = "_-tm" (String#8763, DoABC#2)
// HabboHelpCom_tutorial_button_name_check = "_-1Lk" (String#5272, DoABC#2)
// HabboHelpCom_tutorial_button_changelooks = "_-14i" (String#4974, DoABC#2)
// HabboHelpCom_tutorial_button_guidebot_over = "_-gC" (String#8515, DoABC#2)
// HabboHelpCom_help_cfh_send_xml = "_-2lR" (String#6989, DoABC#2)
// HabboHelpCom_report_user_pick_user_xml = "_-34o" (String#7404, DoABC#2)
// HabboHelpCom_tutorial_frame_xml = "_-2NB" (String#6506, DoABC#2)
// HabboHelpCom_welcome_name_change_xml = "_-1NC" (String#5298, DoABC#2)
// HabboHelpCom_tutorial_change_clothes_xml = "_-2FO" (String#6351, DoABC#2)
// HabboHelpCom_tutorial_button_min_over = "_-1Jk" (String#5237, DoABC#2)
// HabboHelpCom_welcome_name_confirmation_xml = "_-E0" (String#7953, DoABC#2)
// HabboHelpCom_tutorial_button_name_check_over = "_-2e8" (String#6836, DoABC#2)
// HabboHelpCom_help_faq_categories_xml = "_-8o" (String#7838, DoABC#2)
// HabboHelpCom_help_cfh_abusive_xml = "_-0QK" (String#4098, DoABC#2)
// HabboHelpCom_tutorial_arrow_xml = "_-nH" (String#8662, DoABC#2)
// HabboHelpCom_help_back_button_xml = "_-0Kj" (String#3967, DoABC#2)
// HabboHelpCom_tutorial_button_changename = "_-15m" (String#4991, DoABC#2)
// HabboHelpCom_report_user_send_xml = "_-Aw" (String#7885, DoABC#2)
// HabboHelpCom_back_png = "_-0bh" (String#4339, DoABC#2)
// HabboHelpCom_help_itemlist_item_white_bg_xml = "_-0Io" (String#3930, DoABC#2)
// HabboHelpCom_help_cfh_pick_topic_item_xml = "_-2B1" (String#6267, DoABC#2)
// HabboHelpCom_help_cfh_thanks_xml = "_-0-Q" (String#3553, DoABC#2)
// HabboHelpCom_help_front_page_xml = "_-2Yx" (String#6744, DoABC#2)
// HabboHelpCom_tutorial_highlight_blue_arrow = "_-0Bs" (String#3792, DoABC#2)
// HabboHelpCom_guidebot_icon_png = "_-1Zx" (String#5562, DoABC#2)
// HabboHelpCom_tutorial_button_min = "_-PF" (String#8189, DoABC#2)
// HabboHelpCom_help_faq_category_xml = "_-14x" (String#4977, DoABC#2)
// HabboHelpCom_report_user_pick_user_item_xml = "_-2En" (String#6337, DoABC#2)
// HabboHelpCom_help_itemlist_item_urgent_xml = "_-1GG" (String#5173, DoABC#2)
// HabboHelpCom_help_itemlist_item_xml = "_-2Ef" (String#6334, DoABC#2)
// HabboHelpCom_help_cfh_pending_xml = "_-W4" (String#8323, DoABC#2)
// HabboHelpCom_help_faq_entry_xml = "_-0cg" (String#4357, DoABC#2)
// HabboHelpCom_tutorial_call_guidebot_xml = "_-1Iw" (String#5218, DoABC#2)
// HabboHelpCom_tutorial_button_guidebot = "_-2HM" (String#6392, DoABC#2)
// HabboHelpCom_welcome_name_selection_xml = "_-H1" (String#8019, DoABC#2)
// HabboHelpCom_welcome_screen_arrow = "_-q-" (String#8708, DoABC#2)
// HabboHelpCom_tutorial_change_name_xml = "_-2c3" (String#6796, DoABC#2)
// HabboHelpCom_report_user_pick_topic_xml = "_-1vV" (String#5951, DoABC#2)
// HabboHelpCom_hotel_merge_name_change_xml = "_-13G" (String#4939, DoABC#2)
// HabboHelpCom_tutorial_button_min_bg = "_-0hG" (String#4451, DoABC#2)
// HabboHelpCom_welcome_screen_xml = "_-2py" (String#7078, DoABC#2)
// HabboHelpCom_tutorial_change_name_confirmation_xml = "_-0vL" (String#4753, DoABC#2)
// HabboHelpCom_help_cfh_pick_topic_xml = "_-1CZ" (String#5118, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboInventory;
    import com.sulake.iid.IIDHabboInventory;

    public class HabboInventoryCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboInventory, IIDHabboInventory);
        public static var manifest:Class = HabboInventoryCom_manifest;
        public static var inventory_icon_png:Class = HabboInventoryCom_inventory_icon_png;
        public static var inventory_empty_png:Class = HabboInventoryCom_inventory_empty_png;
        public static var download_icon_png:Class = HabboInventoryCom_download_icon_png;
        public static var thumb_bg_png:Class = HabboInventoryCom_thumb_bg_png;
        public static var thumb_bg_selected_png:Class = HabboInventoryCom_thumb_bg_selected_png;
        public static var thumb_icon_recycle_png:Class = HabboInventoryCom_thumb_icon_recycle_png;
        public static var no_recycle_icon_png:Class = HabboInventoryCom_no_recycle_icon_png;
        public static var recycle_icon_png:Class = HabboInventoryCom_recycle_icon_png;
        public static var no_trade_icon_png:Class = HabboInventoryCom_no_trade_icon_png;
        public static var trade_icon_png:Class = HabboInventoryCom_trade_icon_png;
        public static var trading_locked_icon_png:Class = HabboInventoryCom_trading_locked_icon_png;
        public static var trading_unlocked_icon_png:Class = HabboInventoryCom_trading_unlocked_icon_png;
        public static var thumb_selected_outline_png:Class = HabboInventoryCom_thumb_selected_outline_png;
        public static var inventory_xml:Class = HabboInventoryCom_inventory_xml;
        public static var inventory_furni_base_xml:Class = HabboInventoryCom_inventory_furni_base_xml;
        public static var inventory_furni_grid_xml:Class = HabboInventoryCom_inventory_furni_grid_xml;
        public static var inventory_furni_preview_xml:Class = HabboInventoryCom_inventory_furni_preview_xml;
        public static var inventory_badges_xml:Class = HabboInventoryCom_inventory_badges_xml;
        public static var inventory_effects_xml:Class = HabboInventoryCom_inventory_effects_xml;
        public static var inventory_trading_xml:Class = HabboInventoryCom_inventory_trading_xml;
        public static var inventory_trading_minimized_xml:Class = HabboInventoryCom_inventory_trading_minimized_xml;
        public static var inventory_thumb_xml:Class = HabboInventoryCom_inventory_thumb_xml;
        public static var inventory_pets_view_xml:Class = HabboInventoryCom_inventory_pets_view_xml;
        public static var buy_marketplace_tokens_xml:Class = HabboInventoryCom_buy_marketplace_tokens_xml;
        public static var make_marketplace_offer_xml:Class = HabboInventoryCom_make_marketplace_offer_xml;
        public static var marketplace_no_credits_xml:Class = HabboInventoryCom_marketplace_no_credits_xml;
        public static var unseen_items_counter_xml:Class = HabboInventoryCom_unseen_items_counter_xml;
        public static var unseen_item_symbol_xml:Class = HabboInventoryCom_unseen_item_symbol_xml;
        public static var fx_icon_1_png:Class = HabboInventoryCom_fx_icon_1_png;
        public static var fx_icon_2_png:Class = HabboInventoryCom_fx_icon_2_png;
        public static var fx_icon_3_png:Class = HabboInventoryCom_fx_icon_3_png;
        public static var fx_icon_4_png:Class = HabboInventoryCom_fx_icon_4_png;
        public static var fx_icon_5_png:Class = HabboInventoryCom_fx_icon_5_png;
        public static var fx_icon_6_png:Class = HabboInventoryCom_fx_icon_6_png;
        public static var fx_icon_7_png:Class = HabboInventoryCom_fx_icon_7_png;
        public static var fx_icon_8_png:Class = HabboInventoryCom_fx_icon_8_png;
        public static var fx_icon_9_png:Class = HabboInventoryCom_fx_icon_9_png;
        public static var fx_icon_10_png:Class = HabboInventoryCom_fx_icon_10_png;
        public static var fx_icon_11_png:Class = HabboInventoryCom_fx_icon_11_png;
        public static var fx_icon_12_png:Class = HabboInventoryCom_fx_icon_12_png;
        public static var fx_icon_13_png:Class = HabboInventoryCom_fx_icon_13_png;
        public static var fx_icon_14_png:Class = HabboInventoryCom_fx_icon_14_png;
        public static var fx_icon_15_png:Class = HabboInventoryCom_fx_icon_15_png;
        public static var fx_icon_16_png:Class = HabboInventoryCom_fx_icon_16_png;
        public static var fx_icon_17_png:Class = HabboInventoryCom_fx_icon_17_png;
        public static var fx_icon_18_png:Class = HabboInventoryCom_fx_icon_18_png;
        public static var fx_icon_19_png:Class = HabboInventoryCom_fx_icon_19_png;
        public static var fx_icon_20_png:Class = HabboInventoryCom_fx_icon_20_png;
        public static var fx_icon_21_png:Class = HabboInventoryCom_fx_icon_21_png;
        public static var fx_icon_22_png:Class = HabboInventoryCom_fx_icon_22_png;
        public static var fx_icon_23_png:Class = HabboInventoryCom_fx_icon_23_png;
        public static var fx_icon_24_png:Class = HabboInventoryCom_fx_icon_24_png;
        public static var fx_icon_25_png:Class = HabboInventoryCom_fx_icon_25_png;
        public static var fx_icon_26_png:Class = HabboInventoryCom_fx_icon_26_png;
        public static var fx_icon_27_png:Class = HabboInventoryCom_fx_icon_27_png;
        public static var fx_icon_31_png:Class = HabboInventoryCom_fx_icon_31_png;
        public static var fx_icon_32_png:Class = HabboInventoryCom_fx_icon_32_png;
        public static var fx_icon_44_png:Class = HabboInventoryCom_fx_icon_44_png;
        public static var fx_icon_47_png:Class = HabboInventoryCom_fx_icon_47_png;
        public static var fx_icon_53_png:Class = HabboInventoryCom_fx_icon_53_png;
        public static var fx_icon_54_png:Class = HabboInventoryCom_fx_icon_54_png;
        public static var fx_icon_59_png:Class = HabboInventoryCom_fx_icon_59_png;
        public static var fx_icon_60_png:Class = HabboInventoryCom_fx_icon_60_png;
        public static var fx_icon_61_png:Class = HabboInventoryCom_fx_icon_61_png;
        public static var fx_icon_62_png:Class = HabboInventoryCom_fx_icon_62_png;
        public static var fx_icon_63_png:Class = HabboInventoryCom_fx_icon_63_png;
        public static var fx_icon_64_png:Class = HabboInventoryCom_fx_icon_64_png;
        public static var fx_icon_65_png:Class = HabboInventoryCom_fx_icon_65_png;
        public static var fx_icon_66_png:Class = HabboInventoryCom_fx_icon_66_png;
        public static var fx_icon_67_png:Class = HabboInventoryCom_fx_icon_67_png;
        public static var fx_icon_69_png:Class = HabboInventoryCom_fx_icon_69_png;
        public static var fx_icon_70_png:Class = HabboInventoryCom_fx_icon_70_png;
        public static var fx_icon_71_png:Class = HabboInventoryCom_fx_icon_71_png;
        public static var fx_icon_72_png:Class = HabboInventoryCom_fx_icon_72_png;
        public static var fx_icon_73_png:Class = HabboInventoryCom_fx_icon_73_png;
        public static var fx_icon_74_png:Class = HabboInventoryCom_fx_icon_74_png;
        public static var fx_icon_75_png:Class = HabboInventoryCom_fx_icon_75_png;
        public static var fx_icon_76_png:Class = HabboInventoryCom_fx_icon_76_png;
        public static var icon_wallpaper_png:Class = HabboInventoryCom_icon_wallpaper_png;
        public static var icon_floor_png:Class = HabboInventoryCom_icon_floor_png;
        public static var icon_landscape_png:Class = HabboInventoryCom_icon_landscape_png;
        public static var item_popup_xml:Class = HabboInventoryCom_item_popup_xml;
        public static var popup_arrow_left_png:Class = HabboInventoryCom_popup_arrow_left_png;
        public static var popup_arrow_right_png:Class = HabboInventoryCom_popup_arrow_right_png;

    }
}//package 

// HabboInventoryCom_fx_icon_60_png = "_-0yI" (String#4816, DoABC#2)
// HabboInventoryCom_fx_icon_59_png = "_-ZV" (String#8407, DoABC#2)
// HabboInventoryCom_fx_icon_5_png = "_-1Zo" (String#5560, DoABC#2)
// HabboInventoryCom_fx_icon_20_png = "_-2vI" (String#7183, DoABC#2)
// HabboInventoryCom_fx_icon_21_png = "_-2XM" (String#6708, DoABC#2)
// HabboInventoryCom_fx_icon_13_png = "_-35F" (String#7413, DoABC#2)
// HabboInventoryCom_popup_arrow_left_png = "_-1H8" (String#5190, DoABC#2)
// HabboInventoryCom_fx_icon_27_png = "_-8D" (String#7827, DoABC#2)
// HabboInventoryCom_recycle_icon_png = "_-JN" (String#8072, DoABC#2)
// HabboInventoryCom_fx_icon_10_png = "_-2h7" (String#6894, DoABC#2)
// HabboInventoryCom_fx_icon_69_png = "_-03e" (String#3638, DoABC#2)
// HabboInventoryCom_fx_icon_15_png = "_-1Z1" (String#5542, DoABC#2)
// HabboInventoryCom_fx_icon_17_png = "_-0Qd" (String#4103, DoABC#2)
// HabboInventoryCom_no_recycle_icon_png = "_-IT" (String#8049, DoABC#2)
// HabboInventoryCom_fx_icon_8_png = "_-0SV" (String#4150, DoABC#2)
// HabboInventoryCom_fx_icon_76_png = "_-1Ms" (String#5289, DoABC#2)
// HabboInventoryCom_inventory_furni_base_xml = "_-0wL" (String#4777, DoABC#2)
// HabboInventoryCom_item_popup_xml = "_-77" (String#7809, DoABC#2)
// HabboInventoryCom_fx_icon_47_png = "_-2i2" (String#6908, DoABC#2)
// HabboInventoryCom_fx_icon_62_png = "_-025" (String#3607, DoABC#2)
// HabboInventoryCom_fx_icon_12_png = "_-2w0" (String#7203, DoABC#2)
// HabboInventoryCom_make_marketplace_offer_xml = "_-NA" (String#8148, DoABC#2)
// HabboInventoryCom_popup_arrow_right_png = "_-YO" (String#8380, DoABC#2)
// HabboInventoryCom_thumb_bg_selected_png = "_-JU" (String#8076, DoABC#2)
// HabboInventoryCom_icon_landscape_png = "_-64" (String#7782, DoABC#2)
// HabboInventoryCom_inventory_xml = "_-1V5" (String#5457, DoABC#2)
// HabboInventoryCom_fx_icon_2_png = "_-15k" (String#4990, DoABC#2)
// HabboInventoryCom_inventory_furni_preview_xml = "_-13Z" (String#4944, DoABC#2)
// HabboInventoryCom_fx_icon_14_png = "_-RX" (String#8237, DoABC#2)
// HabboInventoryCom_fx_icon_26_png = "_-1Qs" (String#5370, DoABC#2)
// HabboInventoryCom_fx_icon_70_png = "_-2Lb" (String#6474, DoABC#2)
// HabboInventoryCom_inventory_furni_grid_xml = "_-04b" (String#3657, DoABC#2)
// HabboInventoryCom_fx_icon_73_png = "_-0x3" (String#4792, DoABC#2)
// HabboInventoryCom_fx_icon_11_png = "_-1rB" (String#5878, DoABC#2)
// HabboInventoryCom_marketplace_no_credits_xml = "_-3HB" (String#7651, DoABC#2)
// HabboInventoryCom_fx_icon_64_png = "_-GC" (String#7998, DoABC#2)
// HabboInventoryCom_trade_icon_png = "_-Hr" (String#8035, DoABC#2)
// HabboInventoryCom_no_trade_icon_png = "_-34Y" (String#7400, DoABC#2)
// HabboInventoryCom_inventory_trading_xml = "_-2e1" (String#6833, DoABC#2)
// HabboInventoryCom_fx_icon_71_png = "_-2No" (String#6517, DoABC#2)
// HabboInventoryCom_fx_icon_66_png = "_-17r" (String#5035, DoABC#2)
// HabboInventoryCom_fx_icon_9_png = "_-1fC" (String#5649, DoABC#2)
// HabboInventoryCom_thumb_bg_png = "_-0cy" (String#4368, DoABC#2)
// HabboInventoryCom_buy_marketplace_tokens_xml = "_-2wn" (String#7221, DoABC#2)
// HabboInventoryCom_manifest = "_-0AO" (String#3765, DoABC#2)
// HabboInventoryCom_fx_icon_19_png = "_-2wN" (String#7209, DoABC#2)
// HabboInventoryCom_fx_icon_31_png = "_-0Vw" (String#4228, DoABC#2)
// HabboInventoryCom_fx_icon_16_png = "_-AI" (String#7872, DoABC#2)
// HabboInventoryCom_fx_icon_32_png = "_-2Zq" (String#6756, DoABC#2)
// HabboInventoryCom_fx_icon_6_png = "_-07M" (String#3709, DoABC#2)
// HabboInventoryCom_unseen_items_counter_xml = "_-0S2" (String#4138, DoABC#2)
// HabboInventoryCom_fx_icon_54_png = "_-0RR" (String#4121, DoABC#2)
// HabboInventoryCom_fx_icon_22_png = "_-eh" (String#8493, DoABC#2)
// HabboInventoryCom_fx_icon_4_png = "_-1f9" (String#5647, DoABC#2)
// HabboInventoryCom_inventory_icon_png = "_-GL" (String#8001, DoABC#2)
// HabboInventoryCom_fx_icon_25_png = "_-03N" (String#3635, DoABC#2)
// HabboInventoryCom_thumb_icon_recycle_png = "_-0qW" (String#4649, DoABC#2)
// HabboInventoryCom_fx_icon_74_png = "_-0KZ" (String#3965, DoABC#2)
// HabboInventoryCom_icon_wallpaper_png = "_-1Sm" (String#5410, DoABC#2)
// HabboInventoryCom_fx_icon_3_png = "_-RB" (String#8231, DoABC#2)
// HabboInventoryCom_download_icon_png = "_-1N7" (String#5295, DoABC#2)
// HabboInventoryCom_inventory_badges_xml = "_-0r2" (String#4664, DoABC#2)
// HabboInventoryCom_trading_locked_icon_png = "_-1Cv" (String#5123, DoABC#2)
// HabboInventoryCom_fx_icon_63_png = "_-03z" (String#3648, DoABC#2)
// HabboInventoryCom_inventory_pets_view_xml = "_-0RH" (String#4118, DoABC#2)
// HabboInventoryCom_fx_icon_75_png = "_-hO" (String#8543, DoABC#2)
// HabboInventoryCom_inventory_trading_minimized_xml = "_-309" (String#7308, DoABC#2)
// HabboInventoryCom_fx_icon_61_png = "_-0Gr" (String#3892, DoABC#2)
// HabboInventoryCom_fx_icon_23_png = "_-3GQ" (String#7634, DoABC#2)
// HabboInventoryCom_unseen_item_symbol_xml = "_-120" (String#4916, DoABC#2)
// HabboInventoryCom_fx_icon_67_png = "_-3J8" (String#7691, DoABC#2)
// HabboInventoryCom_fx_icon_1_png = "_-17S" (String#5026, DoABC#2)
// HabboInventoryCom_fx_icon_7_png = "_-Bm" (String#7909, DoABC#2)
// HabboInventoryCom_thumb_selected_outline_png = "_-0pl" (String#4628, DoABC#2)
// HabboInventoryCom_fx_icon_65_png = "_-0o8" (String#4597, DoABC#2)
// HabboInventoryCom_fx_icon_72_png = "_-0hc" (String#4460, DoABC#2)
// HabboInventoryCom_inventory_empty_png = "_-3Hr" (String#7663, DoABC#2)
// HabboInventoryCom_fx_icon_53_png = "_-11X" (String#4906, DoABC#2)
// HabboInventoryCom_fx_icon_44_png = "_-0ft" (String#4424, DoABC#2)
// HabboInventoryCom_trading_unlocked_icon_png = "_-3Fv" (String#7629, DoABC#2)
// HabboInventoryCom_inventory_effects_xml = "_-0Un" (String#4200, DoABC#2)
// HabboInventoryCom_fx_icon_24_png = "_-2Ly" (String#6482, DoABC#2)
// HabboInventoryCom_icon_floor_png = "_-3Av" (String#7530, DoABC#2)
// HabboInventoryCom_inventory_thumb_xml = "_-094" (String#3740, DoABC#2)
// HabboInventoryCom_fx_icon_18_png = "_-1ba" (String#5589, DoABC#2)



package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboLocalizationManager;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.localization.HabboLocalizationManager;

    public class HabboLocalizationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboLocalizationManager, IIDCoreLocalizationManager, IIDHabboLocalizationManager);
        public static var manifest:Class = HabboLocalizationCom_manifest;
        public static var default_localization:Class = HabboLocalizationCom_default_localization;
        public static var keys_in_use:Class = HabboLocalizationCom_keys_in_use;
        public static var IIDCoreLocalizationManager:Class = IIDCoreLocalizationManager;
        public static var IIDHabboLocalizationManager:Class = IIDHabboLocalizationManager;
        public static var ICoreLocalizationManager:Class = ICoreLocalizationManager;
        public static var IHabboLocalizationManager:Class = IHabboLocalizationManager;
        public static var HabboLocalizationManager:Class = HabboLocalizationManager;

    }
}//package 

// HabboLocalizationCom_keys_in_use = "_-1dH" (String#5619, DoABC#2)
// HabboLocalizationCom_default_localization = "_-0nJ" (String#4577, DoABC#2)
// HabboLocalizationCom_manifest = "_-28p" (String#6219, DoABC#2)



package 
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.ICore;
    import flash.display.DisplayObjectContainer;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import com.sulake.core.Core;
    import flash.external.ExternalInterface;
    import com.sulake.core.runtime.Component;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.events.LibraryProgressEvent;

    public class HabboMain extends Sprite 
    {

        private static const _SafeStr_14556:Number = 0.71;

        private var _SafeStr_9663:ICore;
        private var _SafeStr_14557:Boolean = false;
        private var _SafeStr_3426:DisplayObjectContainer;
        private var _SafeStr_13789:HabboTracking;

        public function HabboMain(_arg_1:DisplayObjectContainer)
        {
            this._SafeStr_3426 = _arg_1;
            this._SafeStr_3426.addEventListener(Event.COMPLETE, this.onCompleteEvent);
            this._SafeStr_3426.addEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            Logger.log(("Core version: " + Core.version));
        }
        private function dispose():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this._SafeStr_3426){
                this._SafeStr_3426.removeEventListener(Event.COMPLETE, this.onCompleteEvent);
                this._SafeStr_3426.removeEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
                this._SafeStr_3426 = null;
            };
            if (parent){
                parent.removeChild(this);
            };
        }
        private function initializeCore():void
        {
            try {
                this._SafeStr_9663.initialize();
                if (ExternalInterface.available){
                    ExternalInterface.addCallback("unloading", this.unloading);
                };
            }
            catch(error:Error) {
                Habbo.trackLoginStep(Habbo._SafeStr_3407);
                Core.Core(("Failed to initialize the core: " + error.message), Core._SafeStr_9854, error);
            };
        }
        public function unloading():void
        {
            if (((this._SafeStr_9663) && (!(this._SafeStr_9663.disposed)))){
                this._SafeStr_9663.events.dispatchEvent(new Event(Event.UNLOAD));
            };
        }
        protected function onAddedToStage(event:Event=null):void
        {
            try {
                this.prepareCore();
            }
            catch(error:Error) {
                Habbo.trackLoginStep(Habbo._SafeStr_3407);
                Habbo.reportCrash(("Failed to prepare the core: " + error.message), Core._SafeStr_9854, error);
                Core.dispose();
            };
        }
        private function prepareCore():void
        {
            Habbo.trackLoginStep(Habbo._SafeStr_3406);
            this._SafeStr_9663 = Core.Core(stage, Core._SafeStr_8923);
            this._SafeStr_9663.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onCoreError);
            this._SafeStr_9663.IContext(CoreCommunicationFrameworkLib);
            this._SafeStr_9663.IContext(HabboRoomObjectLogicLib);
            this._SafeStr_9663.IContext(HabboRoomObjectVisualizationLib);
            this._SafeStr_9663.IContext(RoomManagerLib);
            this._SafeStr_9663.IContext(RoomSpriteRendererLib);
            this._SafeStr_9663.IContext(HabboRoomSessionManagerLib);
            this._SafeStr_9663.IContext(HabboAvatarRenderLib);
            this._SafeStr_9663.IContext(HabboSessionDataManagerLib);
            this._SafeStr_9663.IContext(HabboTrackingLib);
            this._SafeStr_9663.IContext(HabboConfigurationCom);
            this._SafeStr_9663.IContext(HabboLocalizationCom);
            this._SafeStr_9663.IContext(HabboWindowManagerCom);
            this._SafeStr_9663.IContext(HabboCommunicationCom);
            this._SafeStr_9663.IContext(HabboCommunicationDemoCom);
            this._SafeStr_9663.IContext(HabboNavigatorCom);
            this._SafeStr_9663.IContext(HabboFriendListCom);
            this._SafeStr_9663.IContext(HabboMessengerCom);
            this._SafeStr_9663.IContext(HabboInventoryCom);
            this._SafeStr_9663.IContext(HabboToolbarCom);
            this._SafeStr_9663.IContext(HabboCatalogCom);
            this._SafeStr_9663.IContext(HabboRoomEngineCom);
            this._SafeStr_9663.IContext(HabboRoomUICom);
            this._SafeStr_9663.IContext(HabboAvatarEditorCom);
            this._SafeStr_9663.IContext(HabboNotificationsCom);
            this._SafeStr_9663.IContext(HabboHelpCom);
            this._SafeStr_9663.IContext(HabboAdManagerCom);
            this._SafeStr_9663.IContext(HabboModerationCom);
            this._SafeStr_9663.IContext(HabboUserDefinedRoomEventsCom);
            this._SafeStr_9663.IContext(HabboSoundManagerFlash10Com);
            this._SafeStr_9663.IContext(HabboQuestEngineCom);
            this._SafeStr_9663.IContext(HabboFriendBarCom);
            this._SafeStr_9663.IContext(HabboGroupsCom);
            this._SafeStr_13789 = HabboTracking.getInstance();
            var _local_1:AssetLoaderStruct = this._SafeStr_9663.assets.loadAssetFromFile("config.xml", new URLRequest("config_habbo.xml"));
            if (_local_1.assetLoader.ready){
                this.setupCoreConfigFromLoader(_local_1);
            }
            else {
                _local_1.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
                _local_1.addEventListener(AssetLoaderEvent._SafeStr_4221, this.configLoadedHandler);
            };
        }
        private function configLoadedHandler(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            _local_2 = (_arg_1.target as AssetLoaderStruct);
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.configLoadedHandler);
            if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                this.setupCoreConfigFromLoader(_local_2);
            }
            else {
                Habbo.reportCrash((("Failed to download external configuration document " + _local_2.assetLoader.url) + "!"), Core._SafeStr_8935, null);
            };
        }
        private function setupCoreConfigFromLoader(_arg_1:AssetLoaderStruct):void
        {
            var _local_2:XmlAsset = (this._SafeStr_9663.assets.getAssetByName(_arg_1.assetName) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                Habbo.reportCrash("Download external configuration document is null!", Core._SafeStr_8935, null);
            };
            if (this._SafeStr_9663){
                this._SafeStr_9663.readConfigDocument(XML(_local_2.content), this._SafeStr_3426);
            }
            else {
                Habbo.reportCrash("Core vanished while downloading config document!", Core._SafeStr_8935, null);
            };
        }
        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:Sprite;
            if (this._SafeStr_3426){
                _local_2 = (this._SafeStr_3426.getChildByName("background") as Sprite);
                if (_local_2){
                    _local_2.alpha = (_local_2.alpha - 0.01);
                    if (_local_2.alpha <= 0){
                    };
                };
                if (this._SafeStr_14557){
                    if (this._SafeStr_3426.alpha <= 0){
                        this.dispose();
                        this._SafeStr_14557 = false;
                    }
                    else {
                        this._SafeStr_3426.alpha = (this._SafeStr_3426.alpha - 0.1);
                    };
                };
            };
        }
        private function onCompleteEvent(_arg_1:Event):void
        {
            this.updateLoadingBar(this._SafeStr_3426, 1);
            this.initializeCore();
            this._SafeStr_14557 = true;
        }
        private function onProgressEvent(_arg_1:ProgressEvent):void
        {
            var _local_2:Number;
            var _local_3:Sprite;
            var _local_4:LibraryProgressEvent;
            if (this._SafeStr_3426){
                _local_2 = (_arg_1.bytesLoaded / _arg_1.bytesTotal);
                this.updateLoadingBar(this._SafeStr_3426, _local_2);
                _local_3 = (this._SafeStr_3426.getChildByName("background") as Sprite);
                if (_local_3){
                    _local_3.alpha = Math.min((1 - _local_2), _local_3.alpha);
                };
                if ((_arg_1 is LibraryProgressEvent)){
                    _local_4 = (_arg_1 as LibraryProgressEvent);
                    if ((((_local_4.fileName == "hh_human_fx.swf")) || ((_local_4.fileName == "hh_human_body.swf")))){
                        if (((this._SafeStr_13789) && (!(this._SafeStr_13789.disposed)))){
                            this._SafeStr_13789.trackGoogle("libraryLoaded", _local_4.fileName, _local_4.elapsedTime);
                        };
                    };
                };
            };
        }
        private function updateLoadingBar(_arg_1:DisplayObjectContainer, _arg_2:Number):void
        {
            var _local_9:int;
            var _local_10:int;
            var _local_3 = 200;
            var _local_4:int = 20;
            var _local_5:int = 1;
            var _local_6:int = 1;
            var _local_7:Sprite = (_arg_1.getChildByName(Habbo._SafeStr_3417) as Sprite);
            var _local_8:Sprite = (_local_7.getChildByName(Habbo._SafeStr_3418) as Sprite);
            var _local_11:int = (this._SafeStr_9663.getNumberOfFilesPending() + this._SafeStr_9663.getNumberOfFilesLoaded());
            var _local_12:Number = ((1 - _SafeStr_14556) + ((this._SafeStr_9663.getNumberOfFilesLoaded() / _local_11) * _SafeStr_14556));
            _local_8.x = (_local_5 + _local_6);
            _local_8.y = (_local_5 + _local_6);
            _local_8.graphics.clear();
            _local_9 = ((_local_4 - (_local_5 * 2)) - (_local_6 * 2));
            _local_10 = (((_local_3 - (_local_5 * 2)) - (_local_6 * 2)) * _local_12);
            _local_8.graphics.beginFill(0xFF0000);
            _local_8.graphics.drawRect(0, 0, _local_10, (_local_9 / 2));
            _local_8.graphics.endFill();
            _local_8.graphics.beginFill(0xB30000);
            _local_8.graphics.drawRect(0, (_local_9 / 2), _local_10, ((_local_9 / 2) + 1));
            _local_8.graphics.endFill();
        }
        public function onCoreError(_arg_1:Event):void
        {
            Habbo.trackLoginStep(Habbo._SafeStr_3407);
        }

    }
}//package 

// _SafeStr_13789 = "_-2HY" (String#6395, DoABC#2)
// _SafeStr_14556 = "_-1vd" (String#18782, DoABC#2)
// _SafeStr_14557 = "_-35f" (String#21718, DoABC#2)
// onCompleteEvent = "_-0L1" (String#14878, DoABC#2)
// onProgressEvent = "_-1Be" (String#16926, DoABC#2)
// initializeCore = "_-2Rd" (String#20105, DoABC#2)
// prepareCore = "_-Zl" (String#23625, DoABC#2)
// onCoreError = "_-3Ee" (String#22060, DoABC#2)
// setupCoreConfigFromLoader = "_-j5" (String#24002, DoABC#2)
// configLoadedHandler = "_-1go" (String#18167, DoABC#2)
// _SafeStr_3406 = "_-fC" (String#23855, DoABC#2)
// _SafeStr_3407 = "_-2Kn" (String#19836, DoABC#2)
// _SafeStr_3417 = "_-2hE" (String#20738, DoABC#2)
// _SafeStr_3418 = "_-0wz" (String#16310, DoABC#2)
// _SafeStr_3426 = "_-2GU" (String#19660, DoABC#2)
// onAddedToStage = "_-0EB" (String#14614, DoABC#2)
// trackLoginStep = "_-2T-" (String#20162, DoABC#2)
// reportCrash = "_-lB" (String#24076, DoABC#2)
// onEnterFrame = "_-20T" (String#6057, DoABC#2)
// updateLoadingBar = "_-087" (String#14371, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// ICore = "_-2kX" (String#6966, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// LibraryProgressEvent = "_-26o" (String#19282, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// elapsedTime = "_-3Cm" (String#21986, DoABC#2)
// fileName = "_-1MC" (String#17367, DoABC#2)
// Core = "_-1--" (String#16429, DoABC#2)
// _SafeStr_8923 = "_-3J" (String#22237, DoABC#2)
// getNumberOfFilesPending = "_-2Yn" (String#6742, DoABC#2)
// getNumberOfFilesLoaded = "_-2cq" (String#6808, DoABC#2)
// readConfigDocument = "_-0ct" (String#4365, DoABC#2)
// _SafeStr_8935 = "_-0DA" (String#14575, DoABC#2)
// IContext = "_-hI" (String#8541, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9663 = "_-2Gg" (String#6381, DoABC#2)
// _SafeStr_9854 = "_-1Pp" (String#17502, DoABC#2)
// Core = "_-Pb" (String#23231, DoABC#2)


