//
//  WidgetAntiSonoLiveActivity.swift
//  WidgetAntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/20/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetAntiSonoAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetAntiSonoLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetAntiSonoAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetAntiSonoAttributes {
    fileprivate static var preview: WidgetAntiSonoAttributes {
        WidgetAntiSonoAttributes(name: "World")
    }
}

extension WidgetAntiSonoAttributes.ContentState {
    fileprivate static var smiley: WidgetAntiSonoAttributes.ContentState {
        WidgetAntiSonoAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetAntiSonoAttributes.ContentState {
         WidgetAntiSonoAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetAntiSonoAttributes.preview) {
   WidgetAntiSonoLiveActivity()
} contentStates: {
    WidgetAntiSonoAttributes.ContentState.smiley
    WidgetAntiSonoAttributes.ContentState.starEyes
}
