//
//  ETPropertyType.m
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import "ETPropertyType.h"
#import "ETFoundation.h"

@implementation ETPropertyType

- (instancetype)initWithType:(NSString *)type
{
    if (self = [super init]) {
        if (type.length > 3 && [type hasPrefix:@"@\""]) {
            type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
        }
        _typeClass = NSClassFromString(type);
        _fromFoundation = [ETFoundation isClassFromFoundation:_typeClass];
    }
    return self;
}

@end
