//
//  AnalyticsManager.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import Foundation
import Umbrella
import Mixpanel
import FirebaseAnalytics

let analytics = Umbrella.Analytics<SwifthubEvent>()

enum SwifthubEvent {
    case appNightMode(enabled: Bool)
    case appTheme(color: String)
    case appLanguage(language: String)
    case appCacheRemoved
    case acknowledgements
    case whatsNew
    case flexOpened

    case login(login: String)
    case logout
    case search(keyword: String)
    case repoLanguage(language: String)
    case repository(fullname: String)
    case user(login: String)
    case userEvents(login: String)
    case repositoryEvents(fullname: String)
    case issues(fullname: String)
    case source(fullname: String)
    case readme(fullname: String)
}

extension SwifthubEvent: Umbrella.EventType {

    func name(for provider: ProviderType) -> String? {
        switch self {
        case .appNightMode: return "Night Mode Changed"
        case .appTheme: return "Theme"
        case .appLanguage: return "Language"
        case .appCacheRemoved: return "Cache Removed"
        case .acknowledgements: return "Acknowledgements"
        case .whatsNew: return "Whats New"
        case .flexOpened: return "Flex Opened"
        case .login: return "Login"
        case .logout: return "Logout"
        case .search: return "Search"
        case .repoLanguage: return "Repo Language"
        case .repository: return "Repository"
        case .user: return "User"
        case .userEvents: return "User Events"
        case .repositoryEvents: return "Repository Events"
        case .issues: return "Issues"
        case .source: return "Source"
        case .readme: return "Readme"
        }
    }

    func parameters(for provider: ProviderType) -> [String: Any]? {
        switch self {
        case .appNightMode(let enabled):
            return ["Enabled": enabled]
        case .appTheme(let color):
            return ["Color": color]
        case .appLanguage(let language):
            return ["Language": language]
        case .login(let login):
            return ["Login": login]
        case .search(let keyword):
            return ["Keyword": keyword]
        case .repoLanguage(let language):
            return ["Language": language]
        case .repository(let fullname):
            return ["Fullname": fullname]
        case .user(let login):
            return ["Login": login]
        case .userEvents(let login):
            return ["Login": login]
        case .repositoryEvents(let fullname):
            return ["Fullname": fullname]
        case .issues(let fullname):
            return ["Fullname": fullname]
        case .source(let fullname):
            return ["Fullname": fullname]
        case .readme(let fullname):
            return ["Fullname": fullname]
        default:
            return nil
        }
    }
}

extension Umbrella.Analytics {

    func identify(userId: String) {
        Mixpanel.sharedInstance()?.identify(userId)
        FirebaseAnalytics.Analytics.setUserID(userId)
    }

    func updateUser(name: String, email: String) {
        Mixpanel.sharedInstance()?.people.set("$name", to: name)
        Mixpanel.sharedInstance()?.people.set("$email", to: email)
        FirebaseAnalytics.Analytics.setUserProperty(name, forName: "$name")
        FirebaseAnalytics.Analytics.setUserProperty(email, forName: "$email")
    }

    func reset() {
        Mixpanel.sharedInstance()?.reset()
        FirebaseAnalytics.Analytics.resetAnalyticsData()
    }
}
