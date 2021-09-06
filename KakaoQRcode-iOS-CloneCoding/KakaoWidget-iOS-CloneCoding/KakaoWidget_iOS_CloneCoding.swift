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
        .configurationDisplayName("내 프로필")
        .description("내 프로필 이미지를 보여주고,\n나와의 채팅방으로 빠르게 접근합니다.")
        .supportedFamilies([.systemSmall])
    }
}

// Favorites widget
struct FavoritesWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text("즐겨찾기")
    }
}

struct FavoritesWidget: Widget {
    let kind: String = "FavoritesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FavoritesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("즐겨찾기")
        .description("즐겨찾기한 채팅방을 보여주고, 빠르게 접근합니다.")
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
            Text("톡캘린더 - small")
        case .systemMedium:
            Text("톡캘린더 - medium")
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
        .configurationDisplayName("톡캘린더")
        .description("예정된 일정을 쉽게 확인하고 톡캘린더에\n빠르게 접근합니다.")
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
        .configurationDisplayName("QR체크인")
        .description("홈 화면에서 QR체크인 페이지로\n 빠르게 접근합니다.")
        .supportedFamilies([.systemSmall])
        
    }
}

// 여러 종류의 위젯 추가
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
        QRcodeWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
