//
// BaseRegressor.swift
//
// Copyright 2021, 2022 OpenAlloc LLC
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

import Foundation
import Numerics

open class BaseRegressor<T: BinaryFloatingPoint & Real> {
    public struct Point: Equatable {
        public let x, y: T
        public init(x: T, y: T) {
            self.x = x
            self.y = y
        }
    }

    let pointZero = Point(x: T.zero, y: T.zero)

    /// the input values upon which we'll build our estimates
    public let points: [Point]

    internal init?(points: [Point]) {
        guard points.count > 0 else { return nil }
        self.points = points
    }

    /// should override this
    open func yRegression(x _: T) -> T {
        fatalError("Override yRegression() in your subclass")
    }

    /// should override this
    open func xEstimates(y _: T) -> [T] {
        fatalError("Override xEstimates() in your subclass")
    }

    public lazy var resultValuesY: [T] = points.map { yRegression(x: $0.x) }

    public lazy var resultPoints: [Point] = points.map { Point(x: $0.x,
                                                               y: yRegression(x: $0.x)) }

    public lazy var count: T = .init(points.count)

    public lazy var summed: Point = points.reduce(pointZero) { Point(x: $0.x + $1.x,
                                                                     y: $0.y + $1.y) }

    public lazy var mean: Point = .init(x: summed.x / count, y: summed.y / count)
}
