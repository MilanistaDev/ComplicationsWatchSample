//
//  ComplicationController.swift
//  ComplicationsWatchSample Extension
//
//  Created by 麻生 拓弥 on 2018/11/19.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        case .graphicCorner:
            // Infographのみ
            // gaugeProvider, leadingTextProvider, trailingTextProvider, outerTextProvider が必要
            let cornerTemplate = CLKComplicationTemplateGraphicCornerGaugeText()

            // leadingTextProviderの実装(ゲージの左側に表示するテキスト)
            let leadingText = CLKSimpleTextProvider(text: "9")
            leadingText.tintColor = .cyan
            cornerTemplate.leadingTextProvider = leadingText

            // trailingTextProviderの実装(ゲージの右側に表示するテキスト)
            let trailingText = CLKSimpleTextProvider(text: "24")
            trailingText.tintColor = .red
            cornerTemplate.trailingTextProvider = trailingText

            // outerTextProviderの実装(コーナーに表示するテキスト)
            let outerText = CLKSimpleTextProvider(text: "18")
            outerText.tintColor = .white
            cornerTemplate.outerTextProvider = outerText

            // gaugeProviderの実装
            // ゲージに使用する色
            let gaugeColors = [UIColor.cyan, UIColor.yellow, UIColor.red]
            // ゲージに使用する色の位置合い
            let gaugeColorLocations = [0.0, 0.5, 1.0]
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .ring,
                                       gaugeColors: gaugeColors,
                                       gaugeColorLocations: gaugeColorLocations as [NSNumber],
                                       fillFraction: 0.75)
            cornerTemplate.gaugeProvider = gaugeProvider

            // 用意したTemplateをセット
            let entry = CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: cornerTemplate)
            handler(entry)
        case .graphicCircular:
            // Infograph Modular, Infographのみ
            // circularTemplateの実装
            // gaugeProvider, centerTextProvider が必要
            let circularClosedGaugeTemplate = CLKComplicationTemplateGraphicCircularClosedGaugeText()

            // centerTextProviderの実装
            let centerText = CLKSimpleTextProvider(text: "40")
            centerText.tintColor = .white
            circularClosedGaugeTemplate.centerTextProvider = centerText

            // gaugeProviderの実装
            let gaugeColor = UIColor(red: 0.0, green: 167.0/255.0, blue: 219.0/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.4)
            circularClosedGaugeTemplate.gaugeProvider = gaugeProvider
            // 用意したTemplateをセット
            let entry = CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: circularClosedGaugeTemplate)
            handler(entry)
        case .graphicBezel:
            // Infographのみ
            // circularTemplate, textProvider が必要
            let bezelCircularTemplate = CLKComplicationTemplateGraphicBezelCircularText()

            // textProviderの実装
            let bezelText = CLKSimpleTextProvider(text: "Qiita Advent Calendar 7 日目")
            bezelText.tintColor = .white
            bezelCircularTemplate.textProvider = bezelText

            // circularTemplateの実装
            // gaugeProvider, bottomTextProvider, centerTextProvider が必要
            let circularTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()

            // bottomTextProviderの実装
            let bottomText = CLKSimpleTextProvider(text: "DEC")
            bottomText.tintColor = .white
            circularTemplate.bottomTextProvider = bottomText

            // centerTextProviderの実装
            let centerText = CLKSimpleTextProvider(text: "7")
            centerText.tintColor = .white
            circularTemplate.centerTextProvider = centerText

            // gaugeProviderの実装
            let gaugeColors = [UIColor.red, UIColor.yellow, UIColor.green]
            let gaugeColorLocations = [0.0, 0.4, 1.0]
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .ring,
                                       gaugeColors: gaugeColors,
                                       gaugeColorLocations: gaugeColorLocations as [NSNumber],
                                       fillFraction: 0.3)
            circularTemplate.gaugeProvider = gaugeProvider
            bezelCircularTemplate.circularTemplate = circularTemplate

            // 用意したTemplateをセット
            let entry = CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: bezelCircularTemplate)
            handler(entry)
        case .graphicRectangular:
            // Infograph Modularのみ
            // headerImageProvider(nil可), headerTextProvider, body1TextProvider,  gaugeProviderが必要
            let rectangularTemplate = CLKComplicationTemplateGraphicRectangularTextGauge()

            // headerTextProviderを実装
            let headerText = CLKSimpleTextProvider(text: "Qiita 投稿")
            headerText.tintColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            rectangularTemplate.headerTextProvider = headerText

            // body1TextProviderを実装
            let bodyText = CLKSimpleTextProvider(text: "残タスク：1")
            bodyText.tintColor = .white
            rectangularTemplate.body1TextProvider = bodyText

            // gaugeProviderの実装
            let gaugeColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.5)
            rectangularTemplate.gaugeProvider = gaugeProvider
            // 用意したTemplateをセット
            let entry = CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: rectangularTemplate)
            handler(entry)
        default:
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        switch complication.family {
        case .graphicCorner:
            // Infographのみ
            // gaugeProvider, leadingTextProvider, trailingTextProvider, outerTextProvider が必要
            let cornerTemplate = CLKComplicationTemplateGraphicCornerGaugeText()

            // leadingTextProviderの実装(ゲージの左側に表示するテキスト)
            let leadingText = CLKSimpleTextProvider(text: "9")
            leadingText.tintColor = .cyan
            cornerTemplate.leadingTextProvider = leadingText

            // trailingTextProviderの実装(ゲージの右側に表示するテキスト)
            let trailingText = CLKSimpleTextProvider(text: "24")
            trailingText.tintColor = .red
            cornerTemplate.trailingTextProvider = trailingText

            // outerTextProviderの実装(コーナーに表示するテキスト)
            let outerText = CLKSimpleTextProvider(text: "18")
            outerText.tintColor = .white
            cornerTemplate.outerTextProvider = outerText

            // gaugeProviderの実装
            // ゲージに使用する色
            let gaugeColors = [UIColor.cyan, UIColor.yellow, UIColor.red]
            // ゲージに使用する色の位置合い
            let gaugeColorLocations = [0.0, 0.5, 1.0]
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .ring,
                                       gaugeColors: gaugeColors,
                                       gaugeColorLocations: gaugeColorLocations as [NSNumber],
                                       fillFraction: 0.75)
            cornerTemplate.gaugeProvider = gaugeProvider
            handler(cornerTemplate)
        case .graphicCircular:
            // Infograph Modular, Infographのみ
            // circularTemplateの実装
            // gaugeProvider, centerTextProvider が必要
            let circularClosedGaugeTemplate = CLKComplicationTemplateGraphicCircularClosedGaugeText()

            // centerTextProviderの実装
            let centerText = CLKSimpleTextProvider(text: "40")
            centerText.tintColor = .white
            circularClosedGaugeTemplate.centerTextProvider = centerText

            // gaugeProviderの実装
            let gaugeColor = UIColor(red: 0.0, green: 167.0/255.0, blue: 219.0/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.4)
            circularClosedGaugeTemplate.gaugeProvider = gaugeProvider
            handler(circularClosedGaugeTemplate)
        case .graphicBezel:
            // Infographのみ
            // circularTemplate, textProvider が必要
            let bezelCircularTemplate = CLKComplicationTemplateGraphicBezelCircularText()

            // textProviderの実装
            let bezelText = CLKSimpleTextProvider(text: "Qiita Advent Calendar 7 日目")
            bezelText.tintColor = .white
            bezelCircularTemplate.textProvider = bezelText

            // circularTemplateの実装
            // gaugeProvider, bottomTextProvider, centerTextProvider が必要
            let circularTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()

            // bottomTextProviderの実装
            let bottomText = CLKSimpleTextProvider(text: "DEC")
            bottomText.tintColor = .white
            circularTemplate.bottomTextProvider = bottomText

            // centerTextProviderの実装
            let centerText = CLKSimpleTextProvider(text: "7")
            centerText.tintColor = .white
            circularTemplate.centerTextProvider = centerText

            // gaugeProviderの実装
            let gaugeColors = [UIColor.red, UIColor.yellow, UIColor.green]
            let gaugeColorLocations = [0.0, 0.4, 1.0]
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .ring,
                                       gaugeColors: gaugeColors,
                                       gaugeColorLocations: gaugeColorLocations as [NSNumber],
                                       fillFraction: 0.3)
            circularTemplate.gaugeProvider = gaugeProvider
            bezelCircularTemplate.circularTemplate = circularTemplate
            handler(bezelCircularTemplate)
        case .graphicRectangular:
            // Infograph Modularのみ
            // headerImageProvider(nil可), headerTextProvider, body1TextProvider,  gaugeProviderが必要
            let rectangularTemplate = CLKComplicationTemplateGraphicRectangularTextGauge()

            // headerTextProviderを実装
            let headerText = CLKSimpleTextProvider(text: "Qiita 投稿")
            headerText.tintColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            rectangularTemplate.headerTextProvider = headerText

            // body1TextProviderを実装
            let bodyText = CLKSimpleTextProvider(text: "残タスク：1")
            bodyText.tintColor = .white
            rectangularTemplate.body1TextProvider = bodyText

            // gaugeProviderの実装
            let gaugeColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.5)
            rectangularTemplate.gaugeProvider = gaugeProvider
            handler(rectangularTemplate)
        default:
            handler(nil)
        }
    }
}
