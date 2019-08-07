//
//  NSArray+Map.h
//  FoundationExtension
//
//  Created by shaolie on 2019/8/6.
//  Copyright © 2019 shaolie. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Map)


/**
 判断数组非空

 @return 是否非空
 */
- (BOOL)nonempty;


/**
 遍历数组

 @param callback 回调函数
 */
- (void)forEach:(void(^)(NSInteger idx, ObjectType obj))callback;


/**
 过滤数组

 @param callback 回调函数
 @return 过滤后的数组
 */
- (NSArray *)filter:(BOOL(^)(NSInteger idx, ObjectType obj))callback;


/**
 映射到新的数组

 @param callback 回调函数
 @return 映射后的数组
 */
- (NSArray *)map:(_Nullable id(^)(NSInteger idx, ObjectType obj))callback;


/**
 将数组转化为字典，为每一个元素添加自定义的key

 @param callback 回调函数
 @return 结果字典
 */
- (NSDictionary<id, id> *)toDictionary:(NSDictionary<id, id> * _Nullable (^)(NSInteger idx, ObjectType obj))callback;

/**
   两个数组相减
 
   @param array 被减的数组
   @param rules 规则block， 返回 YES，则会减去当前对象，返回 NO，则保存当前对象,如果未实现block，则根据地址判断是否相同
 
   @return 相减后的数组
 */
- (NSArray *)minusArray:(NSArray * __nullable)array byRules:(BOOL(^ _Nullable)(id obj1, id obj2))rules;

/**
 *  求两个数组交集
 *
 *  @param array 相交数组
 *  @param rules 规则block， 返回 YES，则代表相交，如果未实现block，则根据地址判断是否相同
 *
 *  @return 相交的结果数组
 */
- (NSArray *)intersectArray:(NSArray * __nullable)array byRules:(BOOL(^ _Nullable)(id obj1, id obj2))rules;

/**
 *  求两个数组并集
 *
 *  @param array 相并数组
 *  @param rules 规则block， 返回 YES，则代表相交，如果未实现block，则根据地址判断是否相同
 *
 *  @return 相并的结果数组
 */
- (NSArray<ObjectType> *)unionArray:(NSArray<ObjectType> * __nullable)array byRules:(BOOL(^ _Nullable)(ObjectType obj1, ObjectType obj2))rules;

@end

NS_ASSUME_NONNULL_END
