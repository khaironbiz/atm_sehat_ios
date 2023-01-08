//
//  ELEightScaleRecordModel.m
//  Elink
//
//  Created by iot_user on 2020/6/9.
//  Copyright © 2020 iot_iMac. All rights reserved.
//

#import "ELEightScaleRecordModel.h"
#import <objc/runtime.h>

@implementation ELEightScaleRecordModel

- (NSString *)description{
    
    NSString * desc = @"\n";
    //获取obj的属性数目
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        //获取property的C字符串
        objc_property_t property = properties[i];
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString *prop = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n",prop,obj];
        }
    }
    
    free(properties);
    return desc;
}

@end
