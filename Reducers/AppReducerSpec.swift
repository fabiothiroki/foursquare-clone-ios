//
//  AppReducerSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 05/12/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import XCTest
import Swinject
import ReSwift

class AppReducerSpec: XCTestCase {

    private var container: Container!
    private var reducer: AppReducer!
    private var store: StoreMock!

    override func setUp() {
        super.setUp()

        setupDependencies()
    }

    func testShouldResolveDependencies() {
        XCTAssertNotNil(reducer)
        XCTAssertNotNil(store)
        XCTAssertNotNil(reducer.store)
    }

    func testShouldReturnInitialState() {
        let newState = reducer.reduce(action: FetchPlacesAction(), state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: .loading))
    }

    func testShouldChangeStateAfterSuccessfulRequest() {
        let places = LocationPlaces()
        let action = SetPlacesAction.init(places: places)

        let newState = reducer.reduce(action: action, state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: Result.finished(places)))
    }

    func testShouldChangeStateAfterErrorRequest() {
        let mockError = NSError(domain: "Mock error", code: 42, userInfo: nil )
        let action = SetErrorAction(error: mockError)

        let newState = reducer.reduce(action: action, state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: Result.failed))
    }

    func testShouldDispatchCorrectActionAfterSuccessfulRequest() {
        _ = reducer.reduce(action: FetchPlacesAction(), state: nil)

        if let dispatchedAction = store.dispatchedAction as? SetPlacesAction {
            let places = LocationPlaces()
            XCTAssertEqual(dispatchedAction, SetPlacesAction.init(places: places))
        } else {
            XCTFail("Dispatched action should be of type SetPlacesAction")
        }
    }

    private func setupDependencies() {
        container = Container()
        container.register(UserLocationDatasource.self) { _ in UserLocationServiceMock() }
            .inObjectScope(.container)
        container.register(PlacesDatasource.self) { _ in PlacesApiMock()}
            .inObjectScope(.container)
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService.init(userLocationDatasource: resolver.resolve(UserLocationDatasource.self)!,
                                     placesDatasource: resolver.resolve(PlacesDatasource.self)!)}

        container.register(AppStore.self) { _ in StoreMock() }.inObjectScope(.container)

        container.register(AppReducer.self) { resolver in
            AppReducer.init(resolver.resolve(NearbyPlacesService.self)!)
            }.initCompleted { (resolver, appReducer) in
                var reducer = appReducer
                reducer.store = resolver.resolve(AppStore.self)
        }

        reducer = container.resolve(AppReducer.self)
        store = container.resolve(AppStore.self) as? StoreMock
        reducer.store = store
    }
}
