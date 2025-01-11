//
//  ToudlyWidget.swift
//  ToudlyWidget
//
//  Created by 김지훈 on 1/6/25.
//

import WidgetKit
import Foundation
import SwiftUI
import RealmSwift

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        configureRealmForWidget()
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

func configureRealmForWidget() {
    guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.JihoonKim.Toudly")
    else {
        print("Error: Could not find App Group container")
        return
    }
    
    let realmURL = container.appendingPathComponent("default.realm")
    let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
    Realm.Configuration.defaultConfiguration = config
    
    do {
        let realm = try Realm()
        print("Widget Realm Path: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    } catch {
        print("Error initializing Realm in widget: \(error)")
    }
}

func getFormattedCurrentDate() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/M/d"
    return dateFormatter.string(from: currentDate)
}

func getMonthDayAbbrev() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    return dateFormatter.string(from: currentDate)
}

func getMonthDay() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d"
    return dateFormatter.string(from: currentDate)
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct ToudlyWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    private let cachedSampleTodos: [String]
    
    init(entry: Provider.Entry) {
        self.entry = entry
        let todos = ToudlyWidgetEntryView.filteredAndSortedTodos(for: entry.date)
        self.cachedSampleTodos = ToudlyWidgetEntryView.processSampleTodos(todos: todos)
    }
    
    private static func filteredAndSortedTodos(for date: Date) -> [TodoList] {
        return RealmManager.shared.getData()
            .filter { $0.date == getFormattedCurrentDate() && $0.checkbox == false }
            .sorted(by: { $0.order < $1.order })
    }
    
    
    
    private static func processSampleTodos(todos: [TodoList]) -> [String] {
        var todosList = todos.map { todo in
            return "• \(todo.todoContent)"
        }
        //        var todosList = todos.map { todo in
        //            if todo.checkbox {
        //                return strikeThroughTodoListContent(todoContent: todo.todoContent)
        //            } else {
        //                return NSAttributedString(string: "• \(todo.todoContent)")
        //            }
        //        }
        
        while todosList.count < 5 {
            todosList.append("")
            
        }
        
        if todosList.count > 5 {
            todosList = Array(todosList.prefix(5))
        }
        
        return todosList
    }
    
    var body: some View {
        ZStack {
            Color(.white)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    TodoTitleView(date: todayDate, todoCount: cachedSampleTodos.count, widgetSize: widgetSize)
                    Spacer()
                    Image("appImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                }
                
                Divider().overlay(Color("pastelGreen"))
                
                VStack(alignment: .leading, spacing: listSpacing) {
                    ForEach(cachedSampleTodos, id: \.self) { todo in
                        TodoListView(content: todo, widgetSize: widgetSize)
                    }
                }
                .padding(5)
            }
            .padding(EdgeInsets(top: widgetTopSpacing, leading: widgetSpacing, bottom: widgetBottomSpacing, trailing: widgetSpacing))
        }
        .containerBackground(for: .widget) {
            Color(.white)
        }
    }
    
    private var widgetSize: String {
        widgetFamily == .systemSmall ? "small" : "medium"
    }
    
    private var todayDate: String {
        widgetFamily == .systemSmall ? getMonthDayAbbrev() : getMonthDay()
    }
    
    private var widgetSpacing: CGFloat {
        widgetFamily == .systemSmall ? 2 : 5
    }
    
    private var widgetSideSpacing: CGFloat {
        widgetFamily == .systemSmall ? 0 : 5
    }
    
    private var widgetTopSpacing: CGFloat {
        widgetFamily == .systemSmall ? 0 : 20
    }
    
    private var widgetBottomSpacing: CGFloat {
        widgetFamily == .systemSmall ? 0 : 20
    }
    
    private var imageSize: CGFloat {
        widgetFamily == .systemSmall ? 0 : 28
    }
    
    private var listSpacing: CGFloat {
        widgetFamily == .systemSmall ? 5 : 7
    }
    
    //    private static func strikeThroughTodoListContent(todoContent: String) -> NSAttributedString {
    //        let strikethroughlineAttribute: [NSAttributedString.Key: Any] = [
    //            .strikethroughStyle: NSUnderlineStyle.thick.rawValue,
    //            .paragraphStyle: {
    //                let paragraphStyle = NSMutableParagraphStyle()
    //                paragraphStyle.lineSpacing = 4
    //                return paragraphStyle
    //            }()
    //        ]
    //        let attributedString = NSAttributedString(string: "• \(todoContent)", attributes: strikethroughlineAttribute)
    //
    //        return NSAttributedString(string: "• \(todoContent)", attributes: strikethroughlineAttribute)
    //    }
}

struct TodoTitleView: View {
    var date: String
    var todoCount: Int
    var widgetSize: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("  \(date)  ")
                .foregroundColor(Color("mainDarkGreen"))
                .font(.custom("NanumSquareRoundOTFB", size: widgetSize == "small" ? 17 : 20))
                .multilineTextAlignment(.leading)
                .lineLimit(1)
        }  .background(Color("pastelGreen"))
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 5))
        
        HStack(alignment: .center, spacing: 5) {
            Text(" \(todoCount) ")
                .foregroundColor(Color("colonyGreen"))
                .font(.custom("SUIT-Heavy", size: widgetSize == "small" ? 14 : 18))
                .multilineTextAlignment(.leading)
                .lineLimit(1)
        }
        .background(Color("pastelYellow"))
        .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 50))
        
    }
}

struct TodoListView: View {
    var content: String
    var widgetSize: String
    
    var body: some View {
        Text("\(content)")
            .foregroundColor(Color.black)
            .font(.custom("NanumSquareRoundOTFR", size: widgetSize == "small" ? 12 : 12.5))
        //            .font(.custom("NanumSquareRoundOTFR", size: 12))
            .lineLimit(1)
    }
    
    private func getPlainString(from attributedString: NSAttributedString) -> String {
        return attributedString.string
    }
}

struct ToudlyWidget: Widget {
    let kind: String = "ToudlyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ToudlyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("투들리")
        .description("간편하게 투들리 일정을 확인하세요.")
        .supportedFamilies([.systemSmall, .systemMedium])
        .containerBackgroundRemovable(false)
    }
}

struct ToudlyWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToudlyWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            ToudlyWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
