// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let headlinesJSON = try? newJSONDecoder().decode(HeadlinesJSON.self, from: jsonData)

import Foundation


// MARK: - HeadlinesJSONElement
struct HeadlinesJSONElement: Codable {
    let HBetViews: [HBetView]?
    let caption: String?
    let marketViewType: String?
    let marketViewKey: String?
    let modelType: String?

    enum CodingKeys: String, CodingKey {
        case HBetViews = "betViews"
        case caption = "caption"
        case marketViewType = "marketViewType"
        case marketViewKey = "marketViewKey"
        case modelType = "modelType"
    }
}

typealias Headline = HBetView
// MARK: - HBetView
struct HBetView: Codable {
    let HBetViewKey: String?
    let modelType: String?
    let betContextID: Int?
    let marketViewGroupID: Int?
    let marketViewID: Int?
    let rootMarketViewGroupID: Int?
    let path: String?
    let startTime: String?
    let competitor1Caption: String?
    let competitor2Caption: String?
    let marketTags: [JSONAny]?
    let betItems: [HBetItem]?
    let liveData: HLiveData?
    let displayFormat: String?
    let text: String?
    let url: HJSONNull?
    let imageID: Int?

    enum CodingKeys: String, CodingKey {
        case HBetViewKey = "HBetViewKey"
        case modelType = "modelType"
        case betContextID = "betContextId"
        case marketViewGroupID = "marketViewGroupId"
        case marketViewID = "marketViewId"
        case rootMarketViewGroupID = "rootMarketViewGroupId"
        case path = "path"
        case startTime = "startTime"
        case competitor1Caption = "competitor1Caption"
        case competitor2Caption = "competitor2Caption"
        case marketTags = "marketTags"
        case betItems = "betItems"
        case liveData = "liveData"
        case displayFormat = "displayFormat"
        case text = "text"
        case url = "url"
        case imageID = "imageId"
    }
}

// MARK: - BetItem
struct HBetItem: Codable {
    let id: Int?
    let code: String?
    let caption: String?
    let instanceCaption: String?
    let price: Double?
    let oddsText: String?
    let isAvailable: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "code"
        case caption = "caption"
        case instanceCaption = "instanceCaption"
        case price = "price"
        case oddsText = "oddsText"
        case isAvailable = "isAvailable"
    }
}

// MARK: - LiveData
struct HLiveData: Codable {
    let remaining: String?
    let remainingSeconds: Double?
    let homePoints: Int?
    let awayPoints: Int?
    let quarterScores: [QuarterScore]?
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
    let timeToNextPhase: HJSONNull?
    let timeToNextPhaseSeconds: HJSONNull?
    let phaseSysname: String?
    let phaseCaption: String?
    let phaseCaptionLong: String?
    let isLive: Bool?
    let isInPlay: Bool?
    let isInPlayPaused: Bool?
    let isInterrupted: Bool?
    let supportsActions: Bool?
    let timeline: HJSONNull?
    let adjustTimeMillis: Int?

    enum CodingKeys: String, CodingKey {
        case remaining = "remaining"
        case remainingSeconds = "remainingSeconds"
        case homePoints = "homePoints"
        case awayPoints = "awayPoints"
        case quarterScores = "quarterScores"
        case homePossession = "homePossession"
        case supportsAchievements = "supportsAchievements"
        case liveStreamingCountries = "liveStreamingCountries"
        case sportradarMatchID = "sportradarMatchId"
        case referenceTime = "referenceTime"
        case referenceTimeUnix = "referenceTimeUnix"
        case elapsed = "elapsed"
        case elapsedSeconds = "elapsedSeconds"
        case duration = "duration"
        case durationSeconds = "durationSeconds"
        case timeToNextPhase = "timeToNextPhase"
        case timeToNextPhaseSeconds = "timeToNextPhaseSeconds"
        case phaseSysname = "phaseSysname"
        case phaseCaption = "phaseCaption"
        case phaseCaptionLong = "phaseCaptionLong"
        case isLive = "isLive"
        case isInPlay = "isInPlay"
        case isInPlayPaused = "isInPlayPaused"
        case isInterrupted = "isInterrupted"
        case supportsActions = "supportsActions"
        case timeline = "timeline"
        case adjustTimeMillis = "adjustTimeMillis"
    }
}

// MARK: - QuarterScore
struct QuarterScore: Codable {
    let caption: String?
    let homeScore: Int?
    let awayScore: Int?

    enum CodingKeys: String, CodingKey {
        case caption = "caption"
        case homeScore = "homeScore"
        case awayScore = "awayScore"
    }
}

typealias HeadlinesJSON = [HeadlinesJSONElement]

// MARK: - Encode/decode helpers

class HJSONNull: Codable, Hashable {
    static func == (lhs: HJSONNull, rhs: HJSONNull) -> Bool {
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
