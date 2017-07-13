//
//  ZJAddressModel.h
//  LocationPicker
//
//  Created by 郑键 on 2017/7/12.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJAddressModel : NSObject

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * sheng;
@property (nonatomic,copy) NSString * di;
@property (nonatomic,copy) NSString * xian;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,assign) BOOL  isSelected;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
