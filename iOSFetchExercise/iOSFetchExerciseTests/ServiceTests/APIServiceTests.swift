import XCTest
@testable import iOSFetchExercise

class APIServiceTests: XCTestCase {
    var sut: APIService!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIService.shared
        mockURLSession = MockURLSession()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        sut = nil
        mockURLSession = nil
        try super.tearDownWithError()
    }

    // MARK: - Helper Methods

    func getMockMealDetailData() -> Data {
        return """
        {"meals":[{
            "idMeal":"52771",
            "strMeal":"Spicy Arrabiata Penne",
            "strDrinkAlternate":null,
            "strCategory":"Vegetarian",
            "strArea":"Italian",
            "strInstructions":"Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes...",
            "strMealThumb":"https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
            "strTags":"Pasta,Curry",
            "strYoutube":"https://www.youtube.com/watch?v=1IszT_guI08",
            "strIngredient1":"penne rigate",
            "strIngredient2":"olive oil",
            "strMeasure1":"1 pound",
            "strMeasure2":"1/4 cup",
            "strSource":"https://www.foodnetwork.com/recipes/giada-de-laurentiis/arrabiata-sauce-recipe2.html",
            "strImageSource":null,
            "strCreativeCommonsConfirmed":null,
            "dateModified":null
        }]}
        """.data(using: .utf8)!
    }

    // MARK: - fetchMeals Tests

    func testFetchMeals_Success() async throws {
        // Given
        let mockData = """
        {"meals":[
            {"strMeal":"Apple Frangipan Tart","strMealThumb":"https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg","idMeal":"52768"},
            {"strMeal":"Apple & Blackberry Crumble","strMealThumb":"https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg","idMeal":"52893"},
            {"strMeal":"Apam balik","strMealThumb":"https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg","idMeal":"53049"}
        ]}
        """.data(using: .utf8)!
        mockURLSession.data = mockData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let meals = try await sut.fetchMeals()

        // Then
        XCTAssertEqual(meals.count, 3)
        XCTAssertEqual(meals.first?.strMeal, "Apam balik")
        XCTAssertEqual(meals.first?.idMeal, "53049")
        XCTAssertEqual(meals.last?.strMeal, "Apple Frangipan Tart")
        
        // Check if the meals are sorted alphabetically by name
        let mealNames = meals.map { $0.strMeal }
        XCTAssertEqual(mealNames, mealNames.sorted(), "Meals should be sorted alphabetically by name")
        
        // Check for uniqueness of meals
        let uniqueMealIDs = Set(meals.map { $0.idMeal })
        XCTAssertEqual(uniqueMealIDs.count, meals.count, "All meals should have unique IDs")
    }

    func testFetchMeals_EmptyResponse() async throws {
        // Given
        let emptyData = """
        {"meals":[]}
        """.data(using: .utf8)!
        mockURLSession.data = emptyData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let meals = try await sut.fetchMeals()

        // Then
        XCTAssertTrue(meals.isEmpty)
    }

    func testFetchMeals_InvalidJSON() async {
        // Given
        mockURLSession.data = "Invalid JSON".data(using: .utf8)!
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When/Then
        do {
            _ = try await sut.fetchMeals()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testFetchMeals_NetworkError() async {
        // Given
        mockURLSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)

        // When/Then
        do {
            _ = try await sut.fetchMeals()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, NSURLErrorDomain)
            XCTAssertEqual((error as NSError).code, NSURLErrorNotConnectedToInternet)
        }
    }

    // MARK: - fetchMealDetail Tests

    func testFetchMealDetail_Success() async throws {
        // Given
        mockURLSession.data = getMockMealDetailData()
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let mealDetail = try await sut.fetchMealDetail(id: "52771")

        // Then
        XCTAssertNotNil(mealDetail)
        XCTAssertEqual(mealDetail?.idMeal, "52771")
        XCTAssertEqual(mealDetail?.strMeal, "Spicy Arrabiata Penne")
        XCTAssertEqual(mealDetail?.strInstructions.prefix(48), "Bring a large pot of water to a boil. Add kosher")
        XCTAssertEqual(mealDetail?.strMealThumb, "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg")
        XCTAssertEqual(mealDetail?.strYoutube, "https://www.youtube.com/watch?v=1IszT_guI08")
        XCTAssertEqual(mealDetail?.strSource, "https://www.foodnetwork.com/recipes/giada-de-laurentiis/arrabiata-sauce-recipe2.html")
        XCTAssertEqual(mealDetail?.strTags, "Pasta,Curry")
        XCTAssertEqual(mealDetail?.strArea, "Italian")
        
        // Check ingredients and measurements
        let ingredients = mealDetail?.ingredientsWithMeasurements
        XCTAssertEqual(ingredients?.count, 2)
        XCTAssertEqual(ingredients?.first?.0, "olive oil")
        XCTAssertEqual(ingredients?.first?.1, "1/4 cup")
    }

    func testFetchMealDetail_NotFound() async throws {
        // Given
        let notFoundData = """
        {"meals":null}
        """.data(using: .utf8)!
        mockURLSession.data = notFoundData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let mealDetail = try await sut.fetchMealDetail(id: "nonexistent")

        // Then
        XCTAssertNil(mealDetail)
    }

    func testFetchMealDetail_InvalidJSON() async {
        // Given
        mockURLSession.data = "Invalid JSON".data(using: .utf8)!
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When/Then
        do {
            _ = try await sut.fetchMealDetail(id: "52771")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testFetchMealDetail_NetworkError() async {
        // Given
        mockURLSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)

        // When/Then
        do {
            _ = try await sut.fetchMealDetail(id: "52771")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, NSURLErrorDomain)
            XCTAssertEqual((error as NSError).code, NSURLErrorTimedOut)
        }
    }

    // MARK: - fetchRandomMealID Tests

    func testFetchRandomMealID_Success() async throws {
        // Given
        mockURLSession.data = getMockMealDetailData()
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let randomMealID = try await sut.fetchRandomMealID()

        // Then
        XCTAssertNotNil(randomMealID)
        XCTAssertEqual(randomMealID, "52771")
    }

    func testFetchRandomMealID_EmptyResponse() async throws {
        // Given
        let emptyData = """
        {"meals":[]}
        """.data(using: .utf8)!
        mockURLSession.data = emptyData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let randomMealID = try await sut.fetchRandomMealID()

        // Then
        XCTAssertNil(randomMealID)
    }

    func testFetchRandomMealID_InvalidJSON() async {
        // Given
        mockURLSession.data = "Invalid JSON".data(using: .utf8)!
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When/Then
        do {
            _ = try await sut.fetchRandomMealID()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testFetchRandomMealID_NetworkError() async {
        // Given
        mockURLSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotConnectToHost, userInfo: nil)

        // When/Then
        do {
            _ = try await sut.fetchRandomMealID()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, NSURLErrorDomain)
            XCTAssertEqual((error as NSError).code, NSURLErrorCannotConnectToHost)
        }
    }
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var response: URLResponse?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
