//
//  ViewController.m
//  ETExtensionExample
//
//  Created by 申铭 on 16/12/24.
//  Copyright © 2016年 shenming. All rights reserved.
//

#import "ViewController.h"
#import "ETExtension.h"
#import "ETResultInfo.h"
#import "ETPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *xmlStr = @"<resultInfo><result>1</result><persons><person><name>xiaowang</name><age>18</age></person><person><name>dawang</name><age>20</age></person></persons></resultInfo>";
    
    ETResultInfo *info = [ETResultInfo objectWithXMLString:xmlStr];
    for (ETPerson *person in info.persons) {
        NSLog(@"person.age:%d",person.age);
        NSLog(@"person.name:%@",person.name);
    } 
}

@end
