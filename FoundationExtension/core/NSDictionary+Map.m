//
//  NSDictionary+Map.m
//  FoundationExtension
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import "NSDictionary+Map.h"

@implementation NSDictionary (Map)

- (NSArray *)toArray:(id(^)(id key, id obj))callback {
    NSMutableArray *rst = [NSMutableArray new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id callbackObj = callback(key, obj);
        if (callbackObj) {
            [rst addObject:callbackObj];
        }
    }];
    return [rst copy];
}

- (NSDictionary *)map:(NSDictionary * (^)(id key, id obj))callback {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSDictionary *callbackObj = callback(key, obj);
        [callbackObj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dic setObject:obj forKey:key];
        }];
    }];
    return dic;
}

@end
