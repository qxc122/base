//
//  DataModel.m
//  base
//
//  Created by 开发者最好的 on 2018/8/22.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "DataModel.h"
#import "MJExtension.h"
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
//+ (NSDictionary *)mj_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName;


/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property;
//    if ([property.name isEqualToString:@"publisher"]) {
//        if (oldValue == nil) return @"";
//    } else if (property.type.typeClass == [NSDate class]) {
//        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//        fmt.dateFormat = @"yyyy-MM-dd";
//        return [fmt dateFromString:oldValue];
//    }

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
//    return @{
//             @"contentA" : @"content",
//             @"pageableD" : @"pageable",
//             };
//}
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"contentA" : @"contentS",
//             };
//}

//MJExtensionCodingImplementation

@implementation DataModel

@end
