//
//  GamesModels.swift
//  Novibet
//
//  Created by George Termentzoglou on 23/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gamesJSON = try? newJSONDecoder().decode(GamesJSON.self, from: jsonData)

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gamesJSON = try? newJSONDecoder().decode(GamesJSON.self, from: jsonData)

// MARK: - GamesJSONElement
struct GamesJSONElement: Codable {
    let betViews: [BetView]?
    let caption: String?
    let marketViewType: String?
    let marketViewKey: String?
    let modelType: String?
    let hasHighlights: Bool?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case betViews
        case caption
        case marketViewType
        case marketViewKey
        case modelType
        case hasHighlights
        case totalCount
    }
}

// MARK: - BetView
struct BetView: Codable {
    let betViewKey: String?
    let modelType: String?
    let competitionContextCaption: String?
    let competitions: [Competition]?
    let totalCount: Int?
    let marketCaptions: [MarketCaption]?

    enum CodingKeys: String, CodingKey {
        case betViewKey
        case modelType
        case competitionContextCaption
        case competitions
        case totalCount
        case marketCaptions
    }
}

// MARK: - Competition
struct Competition: Codable {
    let betContextID: Int?
    let caption: String?
    let regionCaption: String?
    let events: [Event]?

    enum CodingKeys: String, CodingKey {
        case betContextID
        case caption
        case regionCaption
        case events
    }
}

// MARK: - Event
struct Event: Codable {
    let betContextID: Int?
    let path: String?
    let isHighlighted: Bool?
    let additionalCaptions: AdditionalCaptions?
    let liveData: LiveData?
    let markets: [Market]?
    let hasBetContextInfo: Bool?

    enum CodingKeys: String, CodingKey {
        case betContextID
        case path
        case isHighlighted
        case additionalCaptions
        case liveData
        case markets
        case hasBetContextInfo
    }
}

// MARK: - AdditionalCaptions
struct AdditionalCaptions: Codable {
    let type: Int?
    let competitor1: String?
    let competitor1ImageID: Int?
    let competitor2: String?
    let competitor2ImageID: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case competitor1
        case competitor1ImageID
        case competitor2
        case competitor2ImageID
    }
}

// MARK: - LiveData
struct LiveData: Codable {
    let remaining: String?
    let remainingSeconds: Double?
    let homePoints: Int?
    let awayPoints: Int?
    let quarterScores: JSONNull?
    let homePossession: Bool?
    let supportsAchievements: Bool?
    let liveStreamingCountries: String?
    let sportradarMatchID: Int?
    let referenceTime: String?
    let referenceTimeUnix: Int?
    let elapsed: String?
    let elapsedSeconds: Double?
    let duration: String?
    let durationSeconds: Int?
    let timeToNextPhase: String?
    let timeToNextPhaseSeconds: Double?
    let phaseSysname: String?
    let phaseCaption: String?
    let phaseCaptionLong: String?
    let isLive: Bool?
    let isInPlay: Bool?
    let isInPlayPaused: Bool?
    let isInterrupted: Bool?
    let supportsActions: Bool?
    let timeline: JSONNull?
    let adjustTimeMillis: Int?

    enum CodingKeys: String, CodingKey {
        case remaining
        case remainingSeconds
        case homePoints
        case awayPoints
        case quarterScores
        case homePossession
        case supportsAchievements
        case liveStreamingCountries
        case sportradarMatchID
        case referenceTime
        case referenceTimeUnix
        case elapsed
        case elapsedSeconds
        case duration
        case durationSeconds
        case timeToNextPhase
        case timeToNextPhaseSeconds
        case phaseSysname
        case phaseCaption
        case phaseCaptionLong
        case isLive
        case isInPlay
        case isInPlayPaused
        case isInterrupted
        case supportsActions
        case timeline
        case adjustTimeMillis
    }
}

// MARK: - Market
struct Market: Codable {
    let marketID: Int?
    let betTypeSysname: String?
    let betItems: [BetItem]?

    enum CodingKeys: String, CodingKey {
        case marketID
        case betTypeSysname
        case betItems
    }
}

// MARK: - BetItem
struct BetItem: Codable {
    let id: Int?
    let code: String?
    let caption: String?
    let instanceCaption: String?
    let price: Double?
    let oddsText: String?
    let isAvailable: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case code
        case caption
        case instanceCaption
        case price
        case oddsText
        case isAvailable
    }
}

// MARK: - MarketCaption
struct MarketCaption: Codable {
    let betTypeSysname: String?
    let marketCaption: String?
    let betCaptions: JSONNull?

    enum CodingKeys: String, CodingKey {
        case betTypeSysname
        case marketCaption
        case betCaptions
    }
}

typealias GamesJSON = [GamesJSONElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
