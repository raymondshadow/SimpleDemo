//
//  Person.h
//  SimpleModel
//
//  Created by wuyp on 16/8/19.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Optional <NSObject>

@end

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phoneNum;

- (void)test;

@end
