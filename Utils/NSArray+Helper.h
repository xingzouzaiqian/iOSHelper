//
//  NSArray+Helper.h
//  Utility
//
//  Created by LiuYue on 8/31/13.
//  Copyright (c) 2013 LiuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (EnumExtension)

- (NSString*)stringWithEnum:(NSUInteger)enumVal;
- (NSUInteger)enumFromString:(NSString*)strVal default:(NSUInteger) def;
- (NSUInteger)enumFromString:(NSString*)strVal;

@end
