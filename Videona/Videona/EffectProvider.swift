//
//  EffectProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

public class EffectProvider {
    
    func getShaderEffectList() -> Array<Effect> {
        var shaderEffects = [ShaderEffect]()
        
        //Falta por poner los iconsId y los resourcesId
        shaderEffects.append(ShaderEffect(
            identifier: "FX5",
            name: "Squeeze",
            iconId: "common_filter_distortion_fx5_squeeze",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION,
            effect: GPUImageFilter(fragmentShaderFromFile: "Squeeze")))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD7",
            name: "Posterize",
            iconId: "common_filter_color_ad7_whiteboard",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect:PosterizebwFilter().posterizebwFilter!))
        
        shaderEffects.append(ShaderEffect(
            identifier: "FX2",
            name: "Stretch",
            iconId: "common_filter_distortion_fx2_stretch",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION,
            effect: GPUImageFilter(fragmentShaderFromFile: "Stretch")))
        
        shaderEffects.append(ShaderEffect(
            identifier: "FX1",
            name: "Fisheye",
            iconId: "common_filter_distortion_fx1_fisheye",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION,
            effect: GPUImageFilter(fragmentShaderFromFile: "Stretch")))
        
        shaderEffects.append(ShaderEffect(
            identifier: "FX7",
            name: "Twirl",
            iconId: "common_filter_distortion_fx7_twirl",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION,
            effect: GPUImageFilter(fragmentShaderFromFile: "Twirl")))
        
        shaderEffects.append(ShaderEffect(
            identifier: "FX6",
            name: "Tunnel",
            iconId: "common_filter_distortion_fx6_tunnel",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_DISTORTION,
            effect: GPUImageFilter(fragmentShaderFromFile: "Mirror")))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD5",
            name: "Negative",
            iconId: "common_filter_color_ad5_negative",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: GPUImageColorInvertFilter()))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD4",
            name: "Mono",
            iconId: "common_filter_color_ad4_mono",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: GPUImageGrayscaleFilter()))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD1",
            name: "Aqua",
            iconId: "common_filter_color_ad1_aqua",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: BlueFilter().blueFilter!))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD3",
            name: "Emboss",
            iconId: "common_filter_color_ad3_emboss",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: GPUImageEmbossFilter()))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD8",
            name: "Sepia",
            iconId: "common_filter_color_ad8_sepia",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: GPUImageSepiaFilter()))
        
        shaderEffects.append(ShaderEffect(
            identifier: "AD6",
            name: "Night",
            iconId: "common_filter_color_ad6_green",
            resourceId: "",
            type: AnalyticsConstants().FILTER_TYPE_COLOR,
            effect: NightFilter().nightFilter!))
        
        return shaderEffects
    }
    
    
    
    func getOverlayFilterList() -> Array<Effect> {
        var overlayList = [Effect]()
        
        //Copy from this example to do new overlays
        //        overlayList.append(OverlayEffect(identifier: "",
        //            name: "",
        //            iconId: "",
        //            resourceId: "",
        //            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        //
        
        overlayList.append(OverlayEffect(identifier: "ovh004",
            name: "Surf",
            iconId: "common_filter_overlay_ovh004_surf",
            resourceId: "overlay_filter_surf",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovw001",
            name: "Mexico",
            iconId: "common_filter_overlay_ovw001_mexico",
            resourceId: "overlay_filter_mexico",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovs003",
            name: "Holidays",
            iconId: "common_filter_overlay_ovs003_holidays",
            resourceId: "overlay_filter_holidays",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovt002",
            name: "Pixel",
            iconId: "common_filter_overlay_ovt002_pixel",
            resourceId: "overlay_filter_pixel",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovt002",
            name: "Olimpic",
            iconId: "common_filter_overlay_ovt002_olimpic",
            resourceId: "overlay_filter_olimpic",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovp004",
            name: "Dog",
            iconId: "common_filter_overlay_ovp004_dog",
            resourceId: "overlay_filter_dog",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        
        overlayList.append(OverlayEffect(identifier: "ovh004",
            name: "Disco",
            iconId: "common_filter_overlay_ovh004_disco",
            resourceId: "overlay_filter_disco",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        
        overlayList.append(OverlayEffect(identifier: "ovb004",
            name: "Birthday",
            iconId: "common_filter_overlay_ovb004_birthday",
            resourceId: "overlay_filter_birthday",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovr004",
            name: "Polygon",
            iconId: "common_filter_overlay_ovr004_polygon",
            resourceId: "overlay_filter_polygon",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovi004",
            name: "Steampunk",
            iconId: "common_filter_overlay_ovi004_steampunk",
            resourceId: "overlay_filter_steampunk",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        
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
