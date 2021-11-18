//
// LinearRegressorTests.swift
//
// Copyright 2021 FlowAllocator LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

@testable import Regressor
import XCTest

class LinearRegressorTests: XCTestCase {
    let epsilon3 = 0.001
    
    typealias Point = BaseRegressor<Double>.Point
    
    // this example verified in Numbers
    func test1() {
        let points: [Point] = [
            Point(x: 0 , y: 1  ),
            Point(x: 9 , y: -7 ),
            Point(x: 13, y: 6  ),
            Point(x: 15, y: 12 ),
            Point(x: 19, y: -4 ),
            Point(x: 20, y: -12),
            Point(x: 26, y: -2 ),
            Point(x: 26, y: 13 ),
            Point(x: 29, y: 23 ),
            Point(x: 30, y: 30 ),
        ]
        
        let lr = LinearRegressor(points: points)
        XCTAssertEqual(-7.709, lr.intercept, accuracy: epsilon3)
        XCTAssertEqual(0.733, lr.slope, accuracy: epsilon3)
        
        let expected: [Double] = [-7.709,
                                  -1.111,
                                  1.821,
                                  3.288,
                                  6.220,
                                  6.953,
                                  11.352,
                                  11.352,
                                  13.551,
                                  14.284]
        let actual = lr.resultValuesY
        XCTAssertEqual(expected, actual, accuracy: epsilon3)
    }
    
    // this example verified via _Linear Regression And Correlation, A Beginner’s Guide_ By Scott Hartshorn
    func test2() {
        let points: [BaseRegressor<Double>.Point] = [
            Point(x: 0, y: 0),
            Point(x: 1, y: 1),
            Point(x: 2, y: 4),
            Point(x: 3, y: 9),
            Point(x: 4, y: 16),
            Point(x: 5, y: 25),
            Point(x: 6, y: 36),
        ]
        
        let lr = LinearRegressor(points: points)
        XCTAssertEqual(22.0, lr.yRegression(x: 4.5), accuracy: epsilon3)
        XCTAssertEqual(5.833, lr.xEstimate(y: 30)!, accuracy: epsilon3)
        XCTAssertEqual(7, lr.count)
        XCTAssertEqual(21.0, lr.summed.x, accuracy: epsilon3)
        XCTAssertEqual(91.0, lr.summed.y, accuracy: epsilon3)
        XCTAssertEqual(3.0, lr.mean.x, accuracy: epsilon3)
        XCTAssertEqual(13.0, lr.mean.y, accuracy: epsilon3)
        XCTAssertEqual(28.0, lr.summedSquareError.x, accuracy: epsilon3)
        XCTAssertEqual(1092.0, lr.summedSquareError.y, accuracy: epsilon3)
        XCTAssertEqual(2.160, lr.sampleStandardDeviation.x, accuracy: epsilon3)
        XCTAssertEqual(13.491, lr.sampleStandardDeviation.y, accuracy: epsilon3)
        XCTAssertEqual(0.961, lr.pearsonsCorrelation, accuracy: epsilon3)
        XCTAssertEqual(6.0, lr.slope, accuracy: epsilon3)
        XCTAssertEqual(-5.0, lr.intercept, accuracy: epsilon3)
        XCTAssertEqual(1092.0, lr.ssTotal, accuracy: epsilon3)
        XCTAssertEqual(84.0, lr.ssRegression, accuracy: epsilon3)
        XCTAssertEqual(0.923, lr.rSquared, accuracy: epsilon3)

        let expectedResultValuesY: [Double] = [-5.0,
                                                1.0,
                                                7.0,
                                                13.0,
                                                19.0,
                                                25.0,
                                                31.0]
        XCTAssertEqual(expectedResultValuesY, lr.resultValuesY, accuracy: 0.001)
        
        //print(String(format: "Intercept: %.1f", lr.intercept))
        //print(String(format: "Slope: %.1f", lr.slope))
        //print(String(format: "y @ x=4.5: %.1f", lr.yRegression(x: 4.5)))
        //print(String(format: "x @ y=30: %.1f", lr.xEstimate(y: 30)!))
        //print(String(format: "r^2: %.3f", lr.rSquared))
    }
}
