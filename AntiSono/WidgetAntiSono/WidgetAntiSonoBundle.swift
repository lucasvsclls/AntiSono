//
//  WidgetAntiSonoBundle.swift
//  WidgetAntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/20/25.
//

import WidgetKit
import SwiftUI

@main
struct WidgetAntiSonoBundle: WidgetBundle {
    var body: some Widget {
        WidgetAntiSono()
        WidgetAntiSonoControl()
        WidgetAntiSonoLiveActivity()
    }
}
