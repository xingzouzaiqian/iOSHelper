//
//  NSArray+Helper.m
//  Utility
//
//  Created by LiuYue on 8/31/13.
//  Copyright (c) 2013 LiuYue. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (EnumExtension)

- (NSString*)stringWithEnum:(NSUInteger) enumVal
{
    return [self objectAtIndex:enumVal];
}

- (NSUInteger)enumFromString:(NSString*)strVal default:(NSUInteger)def
{
    NSUInteger n = [self indexOfObject:strVal];
    if(n == NSNotFound) n = def;
    return n;
}

- (NSUInteger)enumFromString:(NSString*) strVal
{
    return [self enumFromString:strVal default:0];
}

@end
