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
            effect:GPUImagePosterizeFilter()))
        
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
            effect: GPUImageFilter(fragmentShaderFromFile: "Fisheye")))
        
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
            effect: GPUImageFilter(fragmentShaderFromFile: "Tunnel")))
        
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
        
//        Example
//        overlayList.append(OverlayEffect(identifier: "",
//            name: "",
//            iconId: "",
//            resourceId: "",
//            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovf004",
            name: "News",
            iconId: "common_filter_overlay_ovf004_news",
            resourceId: "overlay_filter_news",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        
        overlayList.append(OverlayEffect(identifier: "ovh001",
            name: "Invaders",
            iconId: "common_filter_overlay_ovh001_invaders",
            resourceId: "overlay_filter_invaders",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        
        overlayList.append(OverlayEffect(identifier: "ovn001",
            name: "Rain",
            iconId: "common_filter_overlay_ov22_rain",
            resourceId: "overlay_filter_rain",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovw001",
            name: "Mexico",
            iconId: "common_filter_overlay_ovw001_mexico",
            resourceId: "overlay_filter_mexico",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovp001",
            name: "Kisscam",
            iconId: "common_filter_overlay_ov13_kiss_cam",
            resourceId: "overlay_filter_kiss_cam",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovh004",
            name: "Surf",
            iconId: "common_filter_overlay_ovh004_surf",
            resourceId: "overlay_filter_surf",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovi001",
            name: "Stain",
            iconId: "common_filter_overlay_ov14_stain",
            resourceId: "overlay_filter_stain",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovf001",
            name: "Vintage",
            iconId: "common_filter_overlay_ov18_polaroid",
            resourceId: "overlay_filter_vintage",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovs002",
            name: "Dive",
            iconId: "common_filter_overlay_ovs002_dive",
            resourceId: "overlay_filter_diving",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovh002",
            name: "Gamer",
            iconId: "common_filter_overlay_ovh002_game",
            resourceId: "overlay_filter_gamer",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovb002",
            name: "Crash",
            iconId: "common_filter_overlay_ovb002_crash",
            resourceId: "overlay_filter_crash",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovr002",
            name: "Party",
            iconId: "common_filter_overlay_ovsr002_party",
            resourceId: "overlay_filter_party",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovp004",
            name: "Dog",
            iconId: "common_filter_overlay_ovp004_dog",
            resourceId: "overlay_filter_dog",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovr002",
            name: "Tattoo",
            iconId: "common_filter_overlay_ovh003_tattoo",
            resourceId: "overlay_filter_tattoo",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovp003",
            name: "Baby",
            iconId: "common_filter_overlay_ovp003_baby",
            resourceId: "overlay_filter_baby",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovi004",
            name: "Steampunk",
            iconId: "common_filter_overlay_ovi004_steampunk",
            resourceId: "overlay_filter_steampunk",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovs003",
            name: "Holidays",
            iconId: "common_filter_overlay_ovs003_holidays",
            resourceId: "overlay_filter_holidays",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovb001",
            name: "Wasted",
            iconId: "common_filter_overlay_ov17_wasted",
            resourceId: "overlay_filter_wasted",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovi003",
            name: "Unicorn",
            iconId: "common_filter_overlay_ovi003_unicorn",
            resourceId: "overlay_filter_unicorn",
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
        
        overlayList.append(OverlayEffect(identifier: "ovn005",
            name: "Mist",
            iconId: "common_filter_overlay_ov6_mist",
            resourceId: "overlay_filter_mist",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "ovf005",
            name: "CCTV",
            iconId: "common_filter_overlay_ov10_cctv",
            resourceId: "overlay_filter_cctv",
            type: AnalyticsConstants().FILTER_TYPE_OVERLAY))
        
        overlayList.append(OverlayEffect(identifier: "",
            name: "Bokeh",
            iconId: "common_filter_overlay_ov24_bokeh",
            resourceId: "overlay_filter_bokeh",
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
