//
//  NSDictionary+Map.h
//  FoundationExtension
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType, ObjectType> (Map)

/**
 转换成数组

 @param callback 回调函数
 @return 结果数组
 */
- (NSArray *)toArray:(id(^)(KeyType key, ObjectType obj))callback;


/**
 映射成另一个字典

 @param callback 回调函数
 @return 结果字典
 */
- (NSDictionary *)map:(NSDictionary *(^)(KeyType key, ObjectType obj))callback;

@end
