//
//  ZJAddressModel.m
//  LocationPicker
//
//  Created by 郑键 on 2017/7/12.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "ZJAddressModel.h"

@implementation ZJAddressModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
