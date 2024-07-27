//
//  MealDetailModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import Foundation

// MARK: - MealDetailModel

/// Represents detailed information about a meal
struct MealDetailModel: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String?
    let strSource: String?
    let strTags: String?
    let strArea: String?
    
    // Store ingredient-measure pairs
    private var ingredientMeasures: [String: String]
    
    // Conform to Identifiable protocol
    var id: String { idMeal }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb, strYoutube, strSource, strTags, strArea
    }
    
    /// Custom decoding to handle dynamic ingredient and measure keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        
        // Decode dynamic ingredient-measure pairs
        ingredientMeasures = [:]
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for i in 1...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
               let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)"),
               let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty && !measure.isEmpty {
                ingredientMeasures[ingredient] = measure
            }
        }
    }
    
    /// Custom encoding to handle dynamic ingredient and measure keys
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        try container.encodeIfPresent(strYoutube, forKey: .strYoutube)
        try container.encodeIfPresent(strSource, forKey: .strSource)
        try container.encodeIfPresent(strTags, forKey: .strTags)
        try container.encodeIfPresent(strArea, forKey: .strArea)
        
        // Encode ingredient-measure pairs
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (index, (ingredient, measure)) in ingredientMeasures.enumerated() {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index + 1)"),
               let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index + 1)") {
                try dynamicContainer.encode(ingredient, forKey: ingredientKey)
                try dynamicContainer.encode(measure, forKey: measureKey)
            }
        }
        
        // Encode empty strings for unused ingredient and measure fields
        for i in (ingredientMeasures.count + 1)...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
               let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)") {
                try dynamicContainer.encode("", forKey: ingredientKey)
                try dynamicContainer.encode("", forKey: measureKey)
            }
        }
    }
    
    // MARK: - Computed Properties
    
    /// Returns sorted array of ingredient-measure pairs
    var ingredientsWithMeasurements: [(String, String)] {
        ingredientMeasures.map { ($0.key, $0.value) }.sorted(by: { $0.0 < $1.0 })
    }
    
    /// Returns array of tags
    var tagsArray: [String] {
        strTags?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } ?? []
    }
}

// MARK: - DynamicCodingKeys

/// Allows for dynamic coding keys when decoding/encoding JSON
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}

// MARK: - MealDetailResponse

/// Wrapper struct for API response containing meal details
struct MealDetailResponse: Codable {
    let meals: [MealDetailModel]
}
