//
//  TestExampleUITests.swift
//  TestExampleUITests
//
//  Created by Jisu Kim on 7/22/24.
//

import XCTest

final class TestExampleUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // 실패한 이후에도 계속 테스트를 진행할 것인지?
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNameInputProcess() {
        
        let app = XCUIApplication()
        app.launch()
        
        let greetingText = app.staticTexts["greetingText"]
        let actionButton = app.buttons["actionButton"]
        
        /// 초기 greeting text, 버튼의 text Test
        /// -> Unit Test의 영역으로 볼수도.?
        XCTAssertTrue(greetingText.label == "안녕하세요! 이름을 입력해주세요😀")
        XCTAssertTrue(actionButton.label == "✏️ 입력하러 가기")
        
        actionButton.tap()
                
        let usernameapplybuttonButton = app.buttons["userNameApplyButton"]
        let userNameTextField = app.textFields["userNameTextField"]
        let inputName = "김지수"
        
        /// 아무것도 입력 안한 상태라면, 버튼이 비활성화 되어야 함,
        /// 뷰가 안열렸다면 여기서 Fail
        XCTAssertFalse(
            usernameapplybuttonButton.isEnabled,
            "버튼 Enable 조건 Fail"
        )
        
        userNameTextField.tap()
        userNameTextField.typeText(inputName)
        
        // 입력한 상태라면 버튼 활성화 되어야 함
        XCTAssertTrue(
            usernameapplybuttonButton.isEnabled,
            "버튼 Enable 조건 Fail"
        )
        
        usernameapplybuttonButton.tap()
        
        // 이름 입력 이후의 Assert
        XCTAssertTrue(greetingText.label == "\(inputName)님, 안녕하세요")
        XCTAssertTrue(actionButton.label == "✍️ 수정하러 가기")
    }
}
