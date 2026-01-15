//
//  SceneDelegateTests.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import XCTest
import EssentialFeediOS
@testable import EssentialApp

class SceneDelegateTests: XCTestCase {
    func test_sceneWillConnectToSessionConfiguresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        
        let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        sut.configureWindow(windowScene: windowScene)
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing: root)) instead")
        XCTAssertNotNil(topController is FeedViewController, "Expected a feed controller as top view controller, got \(String(describing: topController)) instead")
    }
}
