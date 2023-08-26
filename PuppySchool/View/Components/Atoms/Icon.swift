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
    case custom(CustomImages)
    case customIcon(_ icon: CustomIcons, color: Color?)
    case commands(DogCommandImages)
    case commandIcon(_ icon: DogCommandIcon, color: Color?)
    case logs(_ icon:LogIcon, color: Color?)
    case dogStage(_ icon: DogStageIcon, color: Color?)
    case messageImage(MessageImage)
}

enum SFSymbols: String {
    case message = "message"
    case pencil = "pencil"
    case person = "person"
    case personFill = "person.fill"
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
    case reload = "arrow.counterclockwise"
    case privacy = "lock.shield.fill"
    case doc = "doc"
    case birthday = "birthday.cake"
    case appleLogo = "apple.logo"
}

enum CustomImages: String {
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
    case backgroundImage1 = "dogTrainingGraphic"
    case graidentPaw = "gradientPaw"
    case tap = "tap-double"
    
}

enum CustomIcons: String {
    case dog = "dog.SFSymbol"
    case notification = "notification.SFSymbol"
    case profile = "profile.SFSymbol"
}

enum DogStageIcon: String {
    case puppyStage = "puppyStage.SFSymbol"
    case adolescentStage = "adolescentStage.SFSymbol"
    case adultStage = "adultStage.SFSymbol"
}

enum LogIcon: String {
    case poop = "poop"
    case walk = "walk"
    case ate = "ate"
    case training = "training"
    case water = "water"
}

enum MessageImage: String {
    case nailClip = "nailClip"
}


enum DogCommandImages: String {
    case sit = "sit" //have it
    case stay = "stay" // have it
    case down = "down" //have it
    case come = "come" //have it
    case heel = "heel" //have it
    case crate = "crate"
    case settle = "settle"
    case kennel = "kennel"
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
    case settleCrate = "settleCrate"
    case bow = "bow"
    case dance = "dance"
    case peekABoo = "peekABoo"
    case jump = "jump"
    case balance = "balance"
    case hug = "hug"
    case paw = "paw" //have it
    case place = "place"
    
}

enum DogCommandIcon: String {
    case sit = "sit.SFSymbol" //have it
    case stay = "stay.SFSymbol" // have it
    case down = "down.SFSymbol" //have it
    case come = "come.SFSymbol" //have it
    case heel = "heel.SFSymbol" //have it
    case off = "off.SFSymbol"
    case leaveIt = "leaveIt.SFSymbol"
    case dropIt = "dropIt.SFSymbol" //
    case watchMe = "focus.SFSymbol" //have it
    case quiet = "quiet.SFSymbol"
    case wait = "wait.SFSymbol"
    case backup = "backup.SFSymbol"
    case touch = "touch.SFSymbol"
    case spin = "spin.SFSymbol"
    case rollOver = "rollOver.SFSymbol"
    case fetch = "fetch.SFSymbol"
    case speak = "speak.SFSymbol"
    case tug = "tug.SFSymbol"
    case playDead = "playDead.SFSymbol"
    case stand = "stand.SFSymbol"
    case turn = "turn.SFSymbol"
    case legWeave = "legWeave.SFSymbol"
    case goAround = "goAround.SFSymbol"
    case over = "over.SFSymbol"
    case under = "under.SFSymbol"
    case crawl = "crawl.SFSymbol"
    case weave = "weave.SFSymbol"
    case takeIt = "takeIt.SFSymbol"
    case findIt = "findIt.SFSymbol"
    case hold = "hold.SFSymbol"
    case settle = "settle.SFSymbol"
    case bow = "bow.SFSymbol"
    case dance = "dance.SFSymbol"
    case peekABoo = "peekABoo.SFSymbol"
    case jump = "jump.SFSymbol"
    case balance = "balance.SFSymbol"
    case hug = "hug.SFSymbol"
    case paw = "paw.SFSymbol" //have it
    case place = "place.SFSymbol"
}
