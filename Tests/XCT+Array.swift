//
//  XCT+Array.swift
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

import XCTest

public func XCTAssertEqual<T>(_ array1: [T],
                              _ array2: [T],
                              accuracy: T) where T: FloatingPoint
{
    guard array1.count == array2.count else {
        XCTFail("array sizes don't match")
        return
    }
    
    (0..<array1.count).forEach {
        let value1 = array1[$0]
        let value2 = array2[$0]
        XCTAssertEqual(value1, value2, accuracy: accuracy)
    }
}
