//
//  ETProperty.h
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETPropertyType;

@interface ETProperty : NSObject

/** 成员属性名 */
@property (nonatomic, copy, readonly) NSString *propertyName;
/** 成员变量的类型 */
@property (nonatomic, strong, readonly) ETPropertyType *type;

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NSString *)type;

/** 模型数组中的模型类型 */
- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c;

- (Class)objectClassInArrayFromClass:(Class)c;
@end
