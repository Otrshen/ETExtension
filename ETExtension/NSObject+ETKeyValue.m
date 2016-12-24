//
//  NSObject+ETKeyValue.m
//  SecureDoc
//
//  Created by syn on 16/4/28.
//  Copyright © 2016年 syn. All rights reserved.
//

#import "NSObject+ETKeyValue.h"
#import <objc/runtime.h>
#import "DDXML.h"
#import "ETProperty.h"
#import "ETPropertyType.h"
#import "ETFoundation.h"
#import "SDSMacro.h"

@implementation NSObject (ETKeyValue)

+ (instancetype)objectWithXMLData:(id)xmlData
{
    ETAssert2([xmlData isKindOfClass:[NSData class]], nil);
    
    NSError *error = nil;
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    NSArray *subject = [[xmlDoc rootElement] children];
    return [self objectWithXMLArr:subject];
}

+ (instancetype)objectWithXMLString:(id)xmlStr
{
    ETAssert2([xmlStr isKindOfClass:[NSString class]], nil);
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc]initWithXMLString:xmlStr options:0 error:nil];
    NSArray *subject = [[xmlDoc rootElement] children];
    return [self objectWithXMLArr:subject];
}

+ (instancetype)objectWithXMLArr:(NSArray *)xmlArr;
{
    id model = [[self alloc] init];
    return [model et_setXML:xmlArr];
}

- (instancetype)et_setXML:(NSArray *)xml
{
    NSArray *arr = [self getProperties];
    
    // 遍历各个字段
    for (ETProperty *property in arr) {
        // 遍历xml的各个节点
        for (DDXMLElement *ele in xml) {

            ETPropertyType *type = property.type;
            Class typeClass = type.typeClass;
            
            id value = NULL;
            if (!type.isFromFoundation && typeClass) { // 模型属性
                // 判断当前节点和对象是否是一样的类型
                if ([[ele name] isEqualToString:property.propertyName]) {
                    value = [typeClass objectWithXMLArr:[ele children]];
                    
                    if (value != NULL) {
                        [self setValue:value forKey:property.propertyName];
                        break;
                    }
                }
            } else if (typeClass == [NSMutableArray class]) { // 模型数组
                
                Class objectClass = [property objectClassInArrayFromClass:[self class]];
                if (objectClass && [[ele name] isEqualToString:property.propertyName]) {
                    // 处理数组里面有模型的情况
                    value = [objectClass keyValuesArrayWithObjectArray:[ele children] objectClass:objectClass];
                    if (value != NULL) {
                        [self setValue:value forKey:property.propertyName];
                    }
                }
            } else if ([[ele name] isEqualToString:property.propertyName]){ // 一层节点的属性
                value = [ele stringValue];
                if (value != NULL) {
                    [self setValue:value forKey:property.propertyName];
                }
            }
        }
    }
    
    return self;
}

+ (NSArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray objectClass:(Class)objectClass
{
    NSMutableArray *keyValuesArray = [NSMutableArray array];
    for (DDXMLElement *ele in objectArray) {
        id cl = [[objectClass alloc] init];
        [keyValuesArray addObject:[cl et_setXML:[ele children]]];
    }
    return keyValuesArray;
}

// 获取该对象的属性名及属性类型
- (NSMutableArray *)getProperties
{
    NSMutableArray *mArr = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *cName = ivar_getName(ivar);
        const char *cType = ivar_getTypeEncoding(ivar);
        NSString *proName = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSString *type = [NSString stringWithCString:cType encoding:NSUTF8StringEncoding];

        ETProperty *pro = [[ETProperty alloc] initWithPropertyName:proName type:type];
        [pro setObjectClassInArray:[self et_ObjectClassInArray:pro.propertyName] forClass:[self class]];
        [mArr addObject:pro];
    }
    
    free(ivars);
    return mArr;
}

// 根据属性名称获取该属性的Class
- (Class)et_ObjectClassInArray:(NSString *)propertyName
{
    if ([[self class] respondsToSelector:@selector(objectClassInArray)]) {
        return [[self class] objectClassInArray][propertyName];
    }
    return nil;
}

@end
