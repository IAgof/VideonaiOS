//
//  EffectProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//
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
        
        shaderEffects.append(ShaderEffect(identifier: "FX4",
            name: "Mirror",
            iconId: "common_filter_distortion_fx4_mirror",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        //        shaderEffects.append(ShaderEffect(identifier: "FX3", name: "Dent", iconId: "common_filter_distortion_fx3_dent", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX5",
            name: "Squeeze",
            iconId: "common_filter_distortion_fx5_squeeze",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "AD7",
            name: "Posterize",
            iconId: "common_filter_color_ad7_whiteboard",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "FX2",
            name: "Stretch",
            iconId: "common_filter_distortion_fx2_stretch",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        
        shaderEffects.append(ShaderEffect(identifier: "FX1",
            name: "Fisheye",
            iconId: "common_filter_distortion_fx1_fisheye",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX7",
            name: "Twirl",
            iconId: "common_filter_distortion_fx7_twirl",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "FX6",
            name: "Tunnel",
            iconId: "common_filter_distortion_fx6_tunnel",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        //        shaderEffects.append(ShaderEffect(identifier: "FX8", name: "Bulge", iconId: "common_filter_distortion_fx8_bulge", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_DISTORTION))
        shaderEffects.append(ShaderEffect(identifier: "AD5",
            name: "Negative",
            iconId: "common_filter_color_ad5_negative",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD4",
            name: "Mono",
            iconId: "common_filter_color_ad4_mono",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD1",
            name: "Aqua",
            iconId: "common_filter_color_ad1_aqua",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        //        shaderEffects.append(ShaderEffect(identifier: "AD2",
        //            name: "Posterizebw",
        //            iconId: "common_filter_color_ad2_postericebw",
        //            resourceId: "",
        //            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD3",
            name: "Emboss",
            iconId: "common_filter_color_ad3_emboss",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD8",
            name: "Sepia",
            iconId: "common_filter_color_ad8_sepia",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        shaderEffects.append(ShaderEffect(identifier: "AD6",
            name: "Night",
            iconId: "common_filter_color_ad6_green",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR))
        
        return shaderEffects
    }
    
    
    
    func getOverlayFilterList() -> Array<Effect> {
        var overlayList = [Effect]()
        
        overlayList.append(OverlayEffect(identifier: "ovb003", name: "Dirty", iconId: "common_filter_overlay_ovb003_dirty", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_COLOR))
        overlayList.append(OverlayEffect(identifier: "ovf003", name: "Retrogame", iconId: "common_filter_overlay_ovf003_retro_game", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovh002", name: "Game", iconId: "common_filter_overlay_ovh002_game", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovh003", name: "Tattoo", iconId: "common_filter_overlay_ovh003_tattoo", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovi003", name: "Unicorn", iconId: "common_filter_overlay_ovi003_unicorn", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovn003", name: "Hawai", iconId: "common_filter_overlay_ovn003_hawaii", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovp003", name: "Baby", iconId: "common_filter_overlay_ovp003_baby", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovr003", name: "NY", iconId: "common_filter_overlay_ovr003_ny", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovs003", name: "Holidays", iconId: "common_filter_overlay_ovs003_holidays", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        overlayList.append(OverlayEffect(identifier: "ovt002", name: "Olimpic", iconId: "common_filter_overlay_ovt002_olimpic", resourceId: "", type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        return overlayList
    }
    
    func getFilterByName(name:String) -> Effect {
        let colorsFilters = self.getOverlayFilterList()
        
        for filter in colorsFilters {
            if filter.getName() == name {
                return filter
            }
        }
        
        let shadersFilters = self.getShaderEffectList()
        
        for filter in shadersFilters {
            if filter.getName() == name{
                return filter
            }
        }
        
        return Effect()
    }
}