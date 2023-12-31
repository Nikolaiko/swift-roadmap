//
// ModelCharacter.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ModelCharacter: Codable, JSONEncodable, Hashable {

    public var id: Int
    public var name: String
    public var status: String
    public var species: String
    public var type: String?
    public var gender: String
    public var origin: Location
    public var location: Location?
    public var image: String?
    public var url: String?
    public var created: String?
    public var episode: [String]?

    public init(id: Int, name: String, status: String, species: String, type: String? = nil, gender: String, origin: Location, location: Location? = nil, image: String? = nil, url: String? = nil, created: String? = nil, episode: [String]? = nil) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.url = url
        self.created = created
        self.episode = episode
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case url
        case created
        case episode
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(species, forKey: .species)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encode(gender, forKey: .gender)
        try container.encode(origin, forKey: .origin)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(episode, forKey: .episode)
    }
}

