//
//  ETPropertyType.h
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETPropertyType : NSObject

/** 对象类型（如果是基本数据类型，此值为nil） */
@property (nonatomic, assign, readonly) Class typeClass;

/** 类型是否来自于Foundation框架，比如NSString、NSArray */
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;

- (instancetype)initWithType:(NSString *)type;

@end
