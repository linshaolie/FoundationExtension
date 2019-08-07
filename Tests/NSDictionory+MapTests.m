//
//  NSDictionory+MapTests.m
//  Tests
//
//  Created by shaolie on 2019/8/7.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+Map.h"

@interface NSDictionory_MapTests : XCTestCase

@end

@implementation NSDictionory_MapTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testToArray {
    NSDictionary<NSString *, id> *dic = @{@"name": @"linshaolie", @"age": @27};
    NSArray *rst = [dic toArray:^id(id key, id obj) {
        return obj;
    }];
    NSArray *expectedRst = @[@"linshaolie", @27];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [dic toArray:^id(id key, id obj) {
        return [obj isKindOfClass:[NSNumber class]] ? nil : obj;
    }];
    expectedRst = @[@"linshaolie"];
    XCTAssertEqualObjects(expectedRst, rst);
    
    NSDictionary *rstDic = [dic map:^NSDictionary *(NSString *key, id obj) {
        if ([key isEqualToString:@"name"]) {
            return @{@"username": obj};
        }
        return @{key: obj};
    }];
    NSDictionary *expectedDic = @{@"username": @"linshaolie", @"age": @27};
    XCTAssertEqualObjects(expectedDic, rstDic);
}


@end
