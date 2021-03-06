//
//  KakaoWidget_iOS_CloneCoding.swift
//  KakaoWidget-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/03.
//

import WidgetKit
import SwiftUI
//import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

// profile widget
struct ProfileEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        let nameUserDefaults = UserDefaults(suiteName: "group.hyun99999.KakaoQRcodeiOSCloneCoding")
        
        ZStack {
            if let name = nameUserDefaults?.string(forKey: "Name"),
               let profileImageData = nameUserDefaults?.data(forKey: "ProfileImage"),
               let profileImage = UIImage(data: profileImageData) {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                
                Text(name)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { dimension in
                        dimension[HorizontalAlignment.center] + 40
                    })
                    .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                        dimension[VerticalAlignment.center] - 55
                    })
            }
        }
    }
}

struct Profile: Widget {
    let kind: String = "Profile"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ProfileEntryView(entry: entry)
        }
        .configurationDisplayName("??? ?????????")
        .description("??? ????????? ???????????? ????????????,\n????????? ??????????????? ????????? ???????????????.")
        .supportedFamilies([.systemSmall])
    }
}

// Favorites widget
struct FavoritesWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text("????????????")
    }
}

struct FavoritesWidget: Widget {
    let kind: String = "FavoritesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FavoritesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("????????????")
        .description("??????????????? ???????????? ????????????, ????????? ???????????????.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

// Calender widget
struct CalenderWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        sizeBody()
    }
    
    @ViewBuilder
    func sizeBody() -> some View {
        switch family {
        case .systemSmall:
            Text("???????????? - small")
        case .systemMedium:
            Text("???????????? - medium")
        default:
            EmptyView()
        }
    }
}

struct CalenderWidget: Widget {
    let kind: String = "CalenderWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CalenderWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("????????????")
        .description("????????? ????????? ?????? ???????????? ???????????????\n????????? ???????????????.")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

// QRcode widget
struct QRcodeWidgetEntryView : View {
    let url = URL(string: "qrcode")
    var entry: Provider.Entry

    var body: some View {
        Image("qrcodeImage")
            .resizable()
            .scaledToFill()
            .widgetURL(url)
    }
}

//@main
struct QRcodeWidget: Widget {
    let kind: String = "QRcodeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QRcodeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("QR?????????")
        .description("??? ???????????? QR????????? ????????????\n ????????? ???????????????.")
        .supportedFamilies([.systemSmall])
        
    }
}

// ?????? ????????? ?????? ??????
@main
struct KakaoWidget: WidgetBundle {
    var body: some Widget {
        Profile()
        FavoritesWidget()
        CalenderWidget()
        QRcodeWidget()
    }
}

struct KakaoWidget_iOS_CloneCoding_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ProfileEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            FavoritesWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            CalenderWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            QRcodeWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
