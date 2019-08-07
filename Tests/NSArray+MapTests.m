//
//  NSArray+MapTests.m
//  Tests
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Map.h"

static NSArray<NSNumber *> *gArr;

@interface NSArray_MapTests : XCTestCase

@end

@implementation NSArray_MapTests

+ (void)initialize {
    gArr = @[@1, @2, @4, @3, @5];
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testForEach {
    __block int i = 0;
    [gArr forEach:^(NSInteger idx, id  _Nonnull obj) {
        i++;
    }];
    XCTAssertEqual(i, gArr.count);
}

- (void)testMap {
    NSArray *rst = [gArr map:^id _Nullable(NSInteger idx, NSNumber * _Nonnull obj) {
        return @([obj integerValue] + 1);
    }];
    NSArray *expectedRst = @[@2, @3, @5, @4, @6];
    XCTAssertEqualObjects(expectedRst, rst);
}

- (void)testNonempty {
    XCTAssertTrue([gArr nonempty]);
    NSArray *nilArr = @[];
    XCTAssertFalse([nilArr nonempty]);
    nilArr = nil;
    XCTAssertFalse([nilArr nonempty]);
}

- (void)testFilter {
    NSArray *rst = [gArr filter:^BOOL(NSInteger idx, NSNumber * _Nonnull obj) {
        return idx > 1;
    }];
    NSArray *expectedRst = @[@4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
}

- (void)testToDictinary {
    NSDictionary *rst = [gArr toDictionary:^NSDictionary<id, id> * _Nullable(NSInteger idx, NSNumber * _Nonnull obj) {
        return @{@(idx): obj};
    }];
    NSDictionary *expectedRst = @{@0: @1, @1: @2, @2: @4, @3: @3, @4: @5};
    XCTAssertEqualObjects(expectedRst, rst);
}

- (void)testMinusArray {
    NSArray *rst = [@[] minusArray:@[@1, @2] byRules:nil];
    NSArray *expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [@[] minusArray:nil byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:nil byRules:nil];
    expectedRst = @[@1, @2, @4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:@[] byRules:nil];
    expectedRst = @[@1, @2, @4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:@[@3, @1] byRules:nil];
    expectedRst = @[@2, @4, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:@[@6, @7] byRules:nil];
    expectedRst = @[@1, @2, @4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:@[@1, @2, @4, @3, @5, @6, @7] byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr minusArray:@[@0, @1, @2, @3, @4, @5] byRules:^BOOL(NSNumber * _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        // 对象相同并且小于删则过滤
        if (obj1 == obj2 && obj2.integerValue < 3) {
            return YES;
        }
        return NO;
    }];
    expectedRst = @[@4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
}

- (void)testIntersectArray {
    NSArray *rst = [@[] intersectArray:nil byRules:nil];
    NSArray *expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr intersectArray:nil byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr intersectArray:@[] byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr intersectArray:@[@8, @9] byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr intersectArray:@[@1, @5, @8, @9] byRules:nil];
    expectedRst = @[@1, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr intersectArray:@[@1, @5, @8, @9] byRules:^BOOL(NSNumber* _Nonnull obj1, NSNumber* _Nonnull obj2) {
        if (obj1 == obj2 && [obj2 integerValue] > 3) {
            return YES;
        }
        return NO;
    }];
    expectedRst = @[@5];
    XCTAssertEqualObjects(expectedRst, rst);
}

- (void)testUnionArray {
    NSArray *rst = [gArr unionArray:nil byRules:nil];
    NSArray *expectedRst = @[@1, @2, @4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [@[] unionArray:nil byRules:nil];
    expectedRst = @[];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr unionArray:@[] byRules:nil];
    expectedRst = @[@1, @2, @4, @3, @5];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr unionArray:@[@8, @9] byRules:nil];
    expectedRst = @[@1, @2, @4, @3, @5, @8, @9];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr unionArray:@[@1, @5, @8, @9] byRules:nil];
    XCTAssertEqualObjects(expectedRst, rst);
    
    rst = [gArr unionArray:@[@1, @5, @8, @9] byRules:^BOOL(NSNumber* _Nonnull obj1, NSNumber* _Nonnull obj2) {
        if (obj1 == obj2 && [obj2 integerValue] > 3) {
            return YES;
        }
        return NO;
    }];
    expectedRst = @[@1, @2, @4, @3, @5, @1, @8, @9];
    XCTAssertEqualObjects(expectedRst, rst);
    
}

@end
