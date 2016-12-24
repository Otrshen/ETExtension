//
//  ETProperty.m
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import "ETProperty.h"
#import "ETPropertyType.h"

@interface ETProperty ()

@property (strong, nonatomic) NSMutableDictionary *objectClassInArrayDict;
@end

@implementation ETProperty

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NSString *)type
{
    if (self = [super init]) {
        [self et_setProName:propertyName type:type];
    }
    return self;
}

- (void)et_setProName:(NSString *)proName type:(NSString *)type
{
    // 去掉属性前面的"_"
    if ([proName hasPrefix:@"_"]) {
        proName = [proName substringFromIndex:1];
    }
    _propertyName = proName;
    
    _type= [[ETPropertyType alloc] initWithType:type];
}

/** 模型数组中的模型类型 */
- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c
{
    if (!objectClass) return;
    self.objectClassInArrayDict[NSStringFromClass(c)] = objectClass;
}

- (Class)objectClassInArrayFromClass:(Class)c
{
    return self.objectClassInArrayDict[NSStringFromClass(c)];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)objectClassInArrayDict
{
    if (!_objectClassInArrayDict) {
        self.objectClassInArrayDict = [NSMutableDictionary dictionary];
    }
    return _objectClassInArrayDict;
}
@end
