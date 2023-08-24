//
//  Icon.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/4/23.
//

import Foundation
import SwiftUI

enum Icon: Equatable {
    case sfSymbol(_ icon:SFSymbols, color: Color?)
    case custom(CustomIcons)
    case commands(DogCommandIcon)
    case logs(_ icon:LogIcon, color: Color?)
    case dogStage(DogStageIcon)
}

enum SFSymbols: String {
    case message = "message"
    case pencil = "pencil"
    case person = "person"
    case gear = "gear"
    case check = "checkmark.circle.fill"
    case close = "xmark.circle.fill"
    case chevRight = "chevron.right"
    case chevLeft = "chevron.left"
    case downArrow = "arrow.down"
    case upArrow = "arrow.up"
    case clock = "clock.fill"
    case upload = "square.and.arrow.up"
    case loading = "arrow.clockwise"
    case swap = "rectangle.2.swap"
    case heart = "heart"
    case heartFull = "heart.fill"
    case plus = "plus"
    case percentage = "percent"
    case intensity = "figure.highintensity.intervaltraining"
    case squareDownChev = "chevron.down.square.fill"
    case bookmark = "bookmark"
    case bookmarkFill = "bookmark.fill"
    case stretch = "figure.flexibility"
    case heartRate = "waveform.path.ecg"
    case training = "figure.strengthtraining.traditional"
    case bar = "chart.bar.fill"
    case pawPrint = "pawprint"
    case lock = "lock"
    case camera = "camera"
    case settings = "gearshape.fill"
    case minusCalendar = "calendar.badge.minus"
}

enum CustomIcons: String {
    case oval = "oval"
    case play = "play"
    case miniChevLeft = "miniChevLeft"
    case chest = "chest"
    case dumbbell = "dumbbell"
    case flame = "flame"
    case whiteFlame = "whiteFlame"
    case solarShare = "share"
    case maximize = "maximize"
    case calendar = "Calendar"
    case paw = "paw"
    case taskbarPaw = "tabbar-paw"
    case taskbarPawSelected = "tabbar-paw-selected"
    case taskbarLog = "tabbar-log"
    case taskbarLogSelected = "tabbar-log-selected"
    case taskbarList = "tabbar-list"
    case taskbarListSelected = "tabbar-list-selected"
    case taskbarProfile = "tabbar-profile"
    case taskbarProfileSelected = "tabbar-profile-selected"
    
}

enum DogStageIcon: String {
    case puppyStage = "puppyStage"
    case adolescentStage = "adolescentStage"
    case adultStage = "adultStage"
}

enum LogIcon: String {
    case poop = "poop"
    case walk = "walk"
    case ate = "ate"
    case training = "training"
    case water = "water"
}

enum DogCommandIcon: String {
    case sit = "sit" //have it
    case stay = "stay" // have it
    case down = "down" //have it
    case come = "come" //have it
    case heel = "heel" //have it
    case off = "off"
    case leaveIt = "leaveIt"
    case dropIt = "dropIt" //
    case watchMe = "focus" //have it
    case quiet = "quiet"
    case wait = "wait"
    case backup = "backup"
    case touch = "touch"
    case spin = "spin"
    case rollOver = "rollOver"
    case fetch = "fetch"
    case speak = "speak"
    case tug = "tug"
    case playDead = "playDead"
    case stand = "stand"
    case turn = "turn"
    case legWeave = "legWeave"
    case goAround = "goAround"
    case over = "over"
    case under = "under"
    case crawl = "crawl"
    case weave = "weave"
    case takeIt = "takeIt"
    case findIt = "findIt"
    case hold = "hold"
    case settle = "settle"
    case bow = "bow"
    case dance = "dance"
    case peekABoo = "peekABoo"
    case jump = "jump"
    case balance = "balance"
    case hug = "hug"
    case paw = "paw" //have it
    case place = "place"
}
