//
//  LiveSupportModuleTests.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import XCTest
@testable import LiveSupportModule

final class LiveSupportPresenterTests: XCTestCase {
    
    private var presenter: LiveSupportPresenter!
    private var mockView: MockLiveSupportView!
    private var mockInteractor: MockLiveSupportInteractor!
    private var mockRouter: MockLiveSupportRouter!

    override func setUp() {
        super.setUp()
        mockView = MockLiveSupportView()
        mockInteractor = MockLiveSupportInteractor()
        mockRouter = MockLiveSupportRouter()

        presenter = LiveSupportPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func test_viewDidLoad_ShouldCallInteractorMethods() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockInteractor.isConnectToWebSocketCalled, "WebSocket bağlantısı başlatılmadı.")
    }

    func test_loadTitle_ShouldUpdateViewTitle() {
        presenter.loadTitle()
        
        XCTAssertTrue(mockInteractor.isLoadTitleCalled, "Interactor'da loadTitle() çağrılmadı.")
    }

    func test_handleExitRequest_ShouldCallRouterCloseApplication() {
        presenter.handleExitRequest()
        
        XCTAssertTrue(mockRouter.isCloseApplicationCalled, "Çıkış isteği doğru yönetilmedi.")
    }
}
