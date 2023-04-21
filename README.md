# SwiftRegressor

A linear regression tool that’s flexible and easy to use.

Available as an open source Swift library to be incorporated in other apps.

_SwiftRegressor_ is part of the [OpenAlloc](https://github.com/openalloc) family of open source Swift software tools.

## Regressor

```swift
let points: [BaseRegressor<Double>.Point] = [
    Point(x: 0, y: 0),
    Point(x: 1, y: 1),
    Point(x: 2, y: 4),
    Point(x: 3, y: 9),
    Point(x: 4, y: 16),
    Point(x: 5, y: 25),
    Point(x: 6, y: 36),
]

let lr = LinearRegressor(points: points)!

print(String(format: "Intercept: %.1f", lr.intercept))
=> "Intercept: -5.0"

print(String(format: "Slope: %.1f", lr.slope))
=> "Slope: 6.0"

print(String(format: "y @ x=4.5: %.1f", lr.yRegression(x: 4.5)))
=> "y @ x=4.5: 22.0"

print(String(format: "x @ y=30: %.1f", lr.xEstimate(y: 30)))
=> "x @ y=30: 5.8"

print(String(format: "r^2: %.3f", lr.rSquared))
=> "r^2: 0.923"
```

## Types

The `Point` type is declared within `BaseRegressor`, where `T` is your `BinaryFloatingPoint` data type:

```swift
public struct Point: Equatable {
    public let x, y: T
    public init(x: T, y: T) {
        self.x = x
        self.y = y
    }
}
```

It's often convenient to declare your own derivative type:

```swift
typealias MyPoint = BaseRegressor<Float>.Point
```

## Initialization

Both the base and linear regressor share the same initialization:

- `init?(points: [BaseRegressor<T>.Point])`

Initialization will fail and return `nil` if provided nonsense parameters, such as no points provided.

The initialization values are also available as properties:

- `let points: [BaseRegressor<T>.Point]`: the points in the source data set

## Instance Properties and Methods

Computed properties are lazy, meaning that they are only calculated when first needed.

#### Base Regressor

The base regressor offers functionality common to different types of regressions.

- `var count: T`: the count of points in the data set

- `var mean: BaseRegressor<T>.Point`: the mean values along both axes

- `var summed: BaseRegressor<T>.Point`: the sum of values along both axes

- `func xEstimates(y: T) -> [T]`: estimate real-number x-value solutions from a y-value

- `func yRegression(x: T) -> T`: estimate a y-value from an x-value

- `var resultPoints: [BaseRegressor<T>.Point]`: the resulting points for each x-value in the source data set 

- `var resultValuesY: [T]`: the resulting y-values for each x-value in the source data set 

#### Linear Regressor

The linear regressor inherits all the properties and methods of the base regressor.

- `func xEstimate(y: T) -> T`: estimate an x-value from a y-value

- `var intercept: T`:  Intercept (a)

- `var pearsonsCorrelation: T`: Pearson’s Correlation (r)

- `var rSquared: T`: A measure of error in the regression (1.0 means zero error)

- `var sampleStandardDeviation: BaseRegressor<T>.Point`: the calculated standard deviation along both axes

- `var slope: T`: Slope (b)

- `var ssRegression: T`: sum squared regression error

- `var ssTotal: T`: sum squared total error

- `var summedSquareError: BaseRegressor<T>.Point`: sum squared error along both axes

## See Also

This library is a member of the _OpenAlloc Project_.

* [_OpenAlloc_](https://openalloc.github.io) - product website for all the _OpenAlloc_ apps and libraries
* [_OpenAlloc Project_](https://github.com/openalloc) - Github site for the development project, including full source code

## License

Copyright 2021, 2022 OpenAlloc LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Contributing

The contributions of other regressors, such as a polynominal regressor, would be most welcome!

Other contributions are welcome too. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.

Contributions should ultimately have adequate test coverage. See tests for current entities to see what coverage is expected.
