//
//  NSArray+Map.m
//  FoundationExtension
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (BOOL)nonempty {
    return self.count > 0;
}

- (void)forEach:(void(^)(NSInteger idx, id obj))callback {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        callback(idx, obj);
    }];
}

- (NSArray *)filter:(BOOL(^)(NSInteger idx, id obj))callback {
    NSMutableArray *rst = [NSMutableArray new];
    [self forEach:^void(NSInteger idx, id  _Nonnull obj) {
        if(callback(idx, obj)) {
            [rst addObject:obj];
        }
    }];
    return [rst copy];
}

- (NSArray *)map:(id(^)(NSInteger idx, id obj))callback {
    NSMutableArray *rst = [NSMutableArray new];
    [self forEach:^void(NSInteger idx, id  _Nonnull obj) {
        id callbackObj = callback(idx, obj);
        if (callbackObj) {
            [rst addObject:callbackObj];
        }
    }];
    return [rst copy];
}

- (NSDictionary<id,id> *)toDictionary:(NSDictionary<id,id> * _Nullable (^)(NSInteger, id _Nonnull))callback {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self forEach:^void(NSInteger idx, id  _Nonnull obj) {
        NSDictionary<NSString *, id> *callbackObj = callback(idx, obj);
        if (callbackObj) {
            [dict addEntriesFromDictionary:callbackObj];
        }
    }];
    return [dict copy];
}

- (NSArray *)minusArray:(NSArray *)array byRules:(BOOL(^)(id obj1, id obj2))rules {
    rules = rules ?: ^BOOL(id obj1, id obj2) {
        return obj1 == obj2;
    };
    if (![self nonempty]) {
        return @[];
    }
    if (![array nonempty]) {
        return [self copy];
    }
    
    return [self filter:^BOOL(NSInteger idx, id obj) {
        for (id arrayObj in array) {
            if (rules(obj, arrayObj)) {
                return NO;
            }
        }
        return YES;
    }];
}

- (NSArray *)intersectArray:(NSArray *)array byRules:(BOOL(^)(id obj1, id obj2))rules {
    rules = rules ?: ^BOOL(id obj1, id obj2) {
        return obj1 == obj2;
    };
    if (![self nonempty] || ![array nonempty]) {
        return @[];
    }
    
    return [self filter:^BOOL(NSInteger idx, id obj) {
        for (id arrayObj in array) {
            if(rules(obj, arrayObj)) {
                return YES;
            };
        }
        return NO;
    }];
}

- (NSArray *)unionArray:(NSArray *)array byRules:(BOOL (^)(id _Nonnull, id _Nonnull))equals {
    if (![self nonempty]) {
        return [array copy] ?: @[];
    }
    if (![array nonempty]) {
        return [self copy];
    }
    
    equals = equals ?: ^BOOL(id obj1, id obj2) {
        return obj1 == obj2;
    };
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:self];
    [array forEach:^void(NSInteger idx, id  _Nonnull obj1) {
        BOOL flag = YES;
        for (id obj2 in self) {
            if (equals(obj1, obj2)) {
                flag = NO;
                break;
            }
        }
        if (flag) {
            [resultArray addObject:obj1];
        }
    }];
    return [resultArray copy];
}

@end
