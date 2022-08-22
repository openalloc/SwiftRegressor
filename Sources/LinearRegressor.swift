//
// LinearRegressor.swift
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

public final class LinearRegressor<T: BinaryFloatingPoint & Real>: BaseRegressor<T> {
    
    public override init?(points: [Point]) {
        super.init(points: points)
    }
    
    override public func yRegression(x: T) -> T {
        (slope * x) + intercept
    }
    
    override public func xEstimates(y: T) -> [T] {
        [(y - intercept) / slope]
    }

    public func xEstimate(y: T) -> T {
        xEstimates(y: y).first!
    }
    
    public lazy var summedSquareError: Point = {
        points.reduce(pointZero) {
            let ex = $1.x - mean.x
            let ey = $1.y - mean.y
            return Point(x: $0.x + (ex * ex),
                         y: $0.y + (ey * ey))
        }
    }()
    
    public lazy var sampleStandardDeviation: Point = {
        Point(x: sqrt(summedSquareError.x / (count - 1)),
              y: sqrt(summedSquareError.y / (count - 1)))
    }()
    
    /// Pearson's Correlation (r)
    public lazy var pearsonsCorrelation: T = {
        let numerator = points.reduce(T.zero) { $0 + (($1.x - mean.x) * ($1.y - mean.y)) }
        let denominator = (count - 1) * sampleStandardDeviation.x * sampleStandardDeviation.y
        return numerator / denominator
    }()
    
    /// Slope (b)
    public lazy var slope: T = {
        pearsonsCorrelation * sampleStandardDeviation.y / sampleStandardDeviation.x
    }()
    
    /// Intercept (a)
    public lazy var intercept: T = {
        mean.y - slope * mean.x
    }()
    
    public lazy var ssTotal: T = {
        summedSquareError.y
    }()
    
    public lazy var ssRegression: T = {
        points.reduce(T.zero) {
            let rye = $1.y - yRegression(x: $1.x)
            return $0 + (rye * rye)
        }
    }()
    
    public lazy var rSquared: T = {
        1 - (ssRegression / ssTotal)
    }()
}
