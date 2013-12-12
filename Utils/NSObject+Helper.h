//
//  NSObject+Helper.h
//  ZSTXL
//
//  Created by LiuYue on 13-8-30.
//  Copyright (c) 2013年 com.zxcxco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Helper)

+ (NSArray *)propertyNames:(Class )klass;

@end
