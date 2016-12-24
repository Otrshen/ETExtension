//
//  ETResultInfo.m
//  ETExtensionExample
//
//  Created by 申铭 on 16/12/24.
//  Copyright © 2016年 shenming. All rights reserved.
//

#import "ETResultInfo.h"
#import "ETPerson.h"

@implementation ETResultInfo

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"persons" : [ETPerson class]
             };
}
@end
