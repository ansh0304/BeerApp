//
//  BeerMDO.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 17/09/21.
//

import UIKit


struct BeerMDO : Codable {
    let id : Double?
    let name : String?
    let tagline : String?
    let first_brewed : String?
    let description : String?
    let image_url : String?
    let abv : Double?
    let ibu : Double?
    let target_fg : Double?
    let target_og : Double?
    let ebc : Double?
    let srm : Double?
    let ph : Double?
    let attenuation_level : Double?
    let volume : Volume?
    let boil_volume : Boil_volume?
    let method : Method?
    let ingredients : Ingredients?
    let food_pairing : [String]?
    let brewers_tips : String?
    let contributed_by : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case tagline = "tagline"
        case first_brewed = "first_brewed"
        case description = "description"
        case image_url = "image_url"
        case abv = "abv"
        case ibu = "ibu"
        case target_fg = "target_fg"
        case target_og = "target_og"
        case ebc = "ebc"
        case srm = "srm"
        case ph = "ph"
        case attenuation_level = "attenuation_level"
        case volume = "volume"
        case boil_volume = "boil_volume"
        case method = "method"
        case ingredients = "ingredients"
        case food_pairing = "food_pairing"
        case brewers_tips = "brewers_tips"
        case contributed_by = "contributed_by"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Double.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        first_brewed = try values.decodeIfPresent(String.self, forKey: .first_brewed)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        abv = try values.decodeIfPresent(Double.self, forKey: .abv)
        ibu = try values.decodeIfPresent(Double.self, forKey: .ibu)
        target_fg = try values.decodeIfPresent(Double.self, forKey: .target_fg)
        target_og = try values.decodeIfPresent(Double.self, forKey: .target_og)
        ebc = try values.decodeIfPresent(Double.self, forKey: .ebc)
        srm = try values.decodeIfPresent(Double.self, forKey: .srm)
        ph = try values.decodeIfPresent(Double.self, forKey: .ph)
        attenuation_level = try values.decodeIfPresent(Double.self, forKey: .attenuation_level)
        volume = try values.decodeIfPresent(Volume.self, forKey: .volume)
        boil_volume = try values.decodeIfPresent(Boil_volume.self, forKey: .boil_volume)
        method = try values.decodeIfPresent(Method.self, forKey: .method)
        ingredients = try values.decodeIfPresent(Ingredients.self, forKey: .ingredients)
        food_pairing = try values.decodeIfPresent([String].self, forKey: .food_pairing)
        brewers_tips = try values.decodeIfPresent(String.self, forKey: .brewers_tips)
        contributed_by = try values.decodeIfPresent(String.self, forKey: .contributed_by)
    }

}
struct Method : Codable {
    let mash_temp : [Mash_temp]?
    let fermentation : Fermentation?
    let twist : String?

    enum CodingKeys: String, CodingKey {

        case mash_temp = "mash_temp"
        case fermentation = "fermentation"
        case twist = "twist"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mash_temp = try values.decodeIfPresent([Mash_temp].self, forKey: .mash_temp)
        fermentation = try values.decodeIfPresent(Fermentation.self, forKey: .fermentation)
        twist = try values.decodeIfPresent(String.self, forKey: .twist)
    }

}
struct Temp : Codable {
    let value : Double?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
struct Amount : Codable {
    let value : Double?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
struct Ingredients : Codable {
    let malt : [Malt]?
    let hops : [Hops]?
    let yeast : String?

    enum CodingKeys: String, CodingKey {

        case malt = "malt"
        case hops = "hops"
        case yeast = "yeast"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        malt = try values.decodeIfPresent([Malt].self, forKey: .malt)
        hops = try values.decodeIfPresent([Hops].self, forKey: .hops)
        yeast = try values.decodeIfPresent(String.self, forKey: .yeast)
    }

}
struct Mash_temp : Codable {
    let temp : Temp?
    let duration : Double?

    enum CodingKeys: String, CodingKey {

        case temp = "temp"
        case duration = "duration"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Temp.self, forKey: .temp)
        duration = try values.decodeIfPresent(Double.self, forKey: .duration)
    }

}
struct Boil_volume : Codable {
    let value : Double?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
struct Malt : Codable {
    let name : String?
    let amount : Amount?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case amount = "amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        amount = try values.decodeIfPresent(Amount.self, forKey: .amount)
    }

}
struct Fermentation : Codable {
    let temp : Temp?

    enum CodingKeys: String, CodingKey {

        case temp = "temp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Temp.self, forKey: .temp)
    }

}
struct Hops : Codable {
    let name : String?
    let amount : Amount?
    let add : String?
    let attribute : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case amount = "amount"
        case add = "add"
        case attribute = "attribute"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        amount = try values.decodeIfPresent(Amount.self, forKey: .amount)
        add = try values.decodeIfPresent(String.self, forKey: .add)
        attribute = try values.decodeIfPresent(String.self, forKey: .attribute)
    }

}
struct Volume : Codable {
    let value : Double?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
