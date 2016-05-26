//
//  EffectProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

public class EffectProvider {
    
    func getColorEffectList() -> Array<Effect> {
        var colorEffects = [Effect]()
        
        //Falta por poner los iconsId y los resourcesId
        
        colorEffects.append(ShaderEffect(identifier: "AD1", name: "Aqua", iconId: "common_filter_color_ad1_aqua", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD2", name: "Posterizebw", iconId: "common_filter_color_ad2_postericebw", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD3", name: "Emboss", iconId: "common_filter_color_ad3_emboss", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD4", name: "Mono", iconId: "common_filter_color_ad4_mono", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD5", name: "Negative", iconId: "common_filter_color_ad5_negative", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD6", name: "Night", iconId: "common_filter_color_ad6_green", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD7", name: "Posterize", iconId: "common_filter_color_ad7_whiteboard", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        colorEffects.append(ShaderEffect(identifier: "AD8", name: "Sepia", iconId: "common_filter_color_ad8_sepia", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))

        
        return colorEffects
    }
    
    func getDistortionEffectList() -> Array<Effect> {
        var distortionEffects = [Effect]()
        
        //Falta por poner los iconsId y los resourcesId
        
        distortionEffects.append(ShaderEffect(identifier: "FX1", name: "Fisheye", iconId: "common_filter_distortion_fx1_fisheye", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX2", name: "Stretch", iconId: "common_filter_distortion_fx2_stretch", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX3", name: "Dent", iconId: "common_filter_distortion_fx3_dent", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX4", name: "Mirror", iconId: "common_filter_distortion_fx4_mirror", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX5", name: "Squeeze", iconId: "common_filter_distortion_fx5_squeeze", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX6", name: "Tunnel", iconId: "common_filter_distortion_fx6_tunnel", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX7", name: "Twirl", iconId: "common_filter_distortion_fx7_twirl", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        distortionEffects.append(ShaderEffect(identifier: "FX8", name: "Bulge", iconId: "common_filter_distortion_fx8_bulge", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        
        
        return distortionEffects
    }
    
    func getShaderEffectList() -> Array<Effect> {
        var shaderEffects = [Effect]()
        
        //Falta por poner los iconsId y los resourcesId
        
        shaderEffects.append(ShaderEffect(identifier: "FX4", name: "Mirror", iconId: "common_filter_distortion_fx4_mirror", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX3", name: "Dent", iconId: "common_filter_distortion_fx3_dent", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX5", name: "Squeeze", iconId: "common_filter_distortion_fx5_squeeze", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "AD7", name: "Posterize", iconId: "common_filter_color_ad7_whiteboard", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "FX2", name: "Stretch", iconId: "common_filter_distortion_fx2_stretch", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))

        shaderEffects.append(ShaderEffect(identifier: "FX1", name: "Fisheye", iconId: "common_filter_distortion_fx1_fisheye", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX7", name: "Twirl", iconId: "common_filter_distortion_fx7_twirl", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX6", name: "Tunnel", iconId: "common_filter_distortion_fx6_tunnel", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX8", name: "Bulge", iconId: "common_filter_distortion_fx8_bulge", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "AD5", name: "Negative", iconId: "common_filter_color_ad5_negative", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD4", name: "Mono", iconId: "common_filter_color_ad4_mono", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD1", name: "Aqua", iconId: "common_filter_color_ad1_aqua", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD2", name: "Posterizebw", iconId: "common_filter_color_ad2_postericebw", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD3", name: "Emboss", iconId: "common_filter_color_ad3_emboss", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD8", name: "Sepia", iconId: "common_filter_color_ad8_sepia", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD6", name: "Night", iconId: "common_filter_color_ad6_green", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        
        return shaderEffects
    }
    
    
    
    func getOverlayFilterList() -> Array<Effect> {
        var overlayList = [Effect]()
        
        //Falta por poner los iconsId y los resourcesId
        
        overlayList.append(OverlayEffect(identifier: "GIFT_OV", name: " ", iconId: "common_filter_overlay_gift", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        overlayList.append(OverlayEffect(identifier: "OV5", name: "Autumn", iconId: "common_filter_overlay_ov5_autumn", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        overlayList.append(OverlayEffect(identifier: "OV4", name: "Retrotv", iconId: "common_filter_overlay_ov4_retrotv", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
//        overlayList.append(OverlayEffect(identifier: "OV17", name: "Wasted", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        overlayList.append(OverlayEffect(identifier: "OV6", name: "Mist", iconId: "common_filter_overlay_ov6_mist", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        
        overlayList.append(OverlayEffect(identifier: "OV3", name: "Sunset", iconId: "common_filter_overlay_ov3_sunset", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        overlayList.append(OverlayEffect(identifier: "OV7", name: "Pride", iconId: "common_filter_overlay_ov7_pride", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        overlayList.append(OverlayEffect(identifier: "OV1", name: "Burn", iconId: "common_filter_overlay_ov1_burn", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
//        overlayList.append(OverlayEffect(identifier: "OV24", name: "Bokeh", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
//        overlayList.append(OverlayEffect(identifier: "OV16", name: "Game", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV22", name: "Rain", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        overlayList.append(OverlayEffect(identifier: "OV10", name: "CCTV", iconId: "common_filter_overlay_ov10_cctv", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        overlayList.append(OverlayEffect(identifier: "OV9", name: "Summer", iconId: "common_filter_overlay_ov9_summer", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV18", name: "Polaroid", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV23", name: "Dark", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV19", name: "Old", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV15", name: "Pastel", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV14", name: "Stain", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
//        overlayList.append(OverlayEffect(identifier: "OV13", name: "Passion", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))

        
        return overlayList
    }
    
//    func getOverlayFilterList() -> Effect{
//        return OverlayEffect(identifier: "OV25", name: "Spring", iconId: "", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR)
//    }
}
