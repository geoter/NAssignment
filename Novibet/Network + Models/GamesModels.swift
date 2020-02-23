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

func getGamesEvents(for element:[GamesJSONElement])->[Event]{
    let events:[Event]? = element.first?.betViews.first?.competitions.flatMap { (comp) -> [Event] in
        return comp.events
    }
    return events ?? []
}

// MARK: - GamesJSONElement
struct GamesJSONElement: Codable {
    let betViews: [BetView]
    let hasHighlights: Bool
    let totalCount: Int
    let caption, marketViewType, marketViewKey, modelType: String
}

// MARK: - BetView
struct BetView: Codable {
    let competitionContextCaption: String
    let competitions: [Competition]
    let totalCount: Int
    let marketCaptions: [MarketCaption]
    let betViewKey, modelType: String
}

// MARK: - Competition
struct Competition: Codable {
    let betContextID: Int
    let caption, regionCaption: String
    let events: [Event]

    enum CodingKeys: String, CodingKey {
        case betContextID = "betContextId"
        case caption, regionCaption, events
    }
}

// MARK: - Event
struct Event: Codable {
    let betContextID: Int
    let path: String
    let isHighlighted: Bool
    let additionalCaptions: AdditionalCaptions
    let liveData: LiveData
    let markets: [Market]
    let hasBetContextInfo: Bool

    enum CodingKeys: String, CodingKey {
        case betContextID = "betContextId"
        case path, isHighlighted, additionalCaptions, liveData, markets, hasBetContextInfo
    }
}

// MARK: - AdditionalCaptions
struct AdditionalCaptions: Codable {
    let type: Int
    let competitor1: String
    let competitor1ImageID: Int
    let competitor2: String
    let competitor2ImageID: Int

    enum CodingKeys: String, CodingKey {
        case type, competitor1
        case competitor1ImageID = "competitor1ImageId"
        case competitor2
        case competitor2ImageID = "competitor2ImageId"
    }
}

// MARK: - LiveData
struct LiveData: Codable {
    let homeGoals, awayGoals, homeCorners, awayCorners: Int
    let homeYellowCards, awayYellowCards, homeRedCards, awayRedCards: Int
    let homePenaltyKicks, awayPenaltyKicks: Int
    let supportsAchievements: Bool
    let liveStreamingCountries: String?
    let sportradarMatchID: Int?
    let referenceTime: String
    let referenceTimeUnix: Int
    let elapsed: String
    let elapsedSeconds: Double
    let duration, durationSeconds: JSONNull?
    let timeToNextPhase: String?
    let timeToNextPhaseSeconds: Double?
    let phaseSysname: String
    let phaseCaption: String
    let phaseCaptionLong: String
    let isLive, isInPlay, isInPlayPaused, isInterrupted: Bool
    let supportsActions: Bool
    let timeline: JSONNull?
    let adjustTimeMillis: Int

    enum CodingKeys: String, CodingKey {
        case homeGoals, awayGoals, homeCorners, awayCorners, homeYellowCards, awayYellowCards, homeRedCards, awayRedCards, homePenaltyKicks, awayPenaltyKicks, supportsAchievements, liveStreamingCountries
        case sportradarMatchID = "sportradarMatchId"
        case referenceTime, referenceTimeUnix, elapsed, elapsedSeconds, duration, durationSeconds, timeToNextPhase, timeToNextPhaseSeconds, phaseSysname, phaseCaption, phaseCaptionLong, isLive, isInPlay, isInPlayPaused, isInterrupted, supportsActions, timeline, adjustTimeMillis
    }
}

// MARK: - Market
struct Market: Codable {
    let marketID: Int
    let betTypeSysname: String
    let betItems: [BetItem]

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case betTypeSysname, betItems
    }
}

// MARK: - BetItem
struct BetItem: Codable {
    let id: Int
    let code, caption: String
    let instanceCaption: JSONNull?
    let price: Double
    let oddsText: String
    let isAvailable: Bool
}

// MARK: - MarketCaption
struct MarketCaption: Codable {
    let betTypeSysname, marketCaption: String
    let betCaptions: JSONNull?
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

    public func hash(into hasher: inout Hasher) {
        // No-op
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
