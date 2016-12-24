//
//  NSObject+ETKeyValue.h
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETKeyValue <NSObject>
@optional

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
+ (NSDictionary *)objectClassInArray;

@end


/** 数组中需要转换的模型类 */
typedef NSDictionary * (^ETObjectClassInArray)();

@interface NSObject (ETKeyValue)

/**
 *  传入 NSData 类型的XML
 */
+ (instancetype)objectWithXMLData:(id)xmlData;

/**
 *  传入 NSString 类型的XML
 */
+ (instancetype)objectWithXMLString:(id)xmlStr;

/**
 *  传入 KissXML的NSArray 来创建一个模型
 *  @return 新建的对象
 */
+ (instancetype)objectWithXMLArr:(NSArray *)xmlArr;

/**
 *  将XML转成模型属性
 */
- (instancetype)et_setXML:(id)xml;

@end
