//
//  NSDictionary+Map.h
//  FoundationExtension
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType, ObjectType> (Map)

- (NSArray *)toArray:(id(^)(KeyType key, ObjectType obj))callback;

- (NSDictionary *)map:(NSDictionary *(^)(KeyType key, ObjectType obj))callback;
@end
