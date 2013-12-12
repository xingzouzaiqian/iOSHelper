//
//  NSDictionary+Helper.m
//  Utility
//
//  Created by LiuYue on 8/31/13.
//  Copyright (c) 2013 LiuYue. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

- (id)objForKeyPath:(NSString *)key {
    id ret = nil;
	id tmpSelf = nil;
	if ([self isKindOfClass:[NSArray class]])
	{
		if ([(NSArray*)self count]==1) {
			tmpSelf = [(NSArray*)self objectAtIndex:0];
		}else {
			return nil;
		}
	}
    
    @try {
        if (tmpSelf) {
            ret = [tmpSelf valueForKeyPath:key];
        }
        else{
            ret = [self valueForKeyPath:key];
        }
        
        
    }
    @catch (NSException *exception) {
        ret = nil;
    }
    
    if (!ret || [(NSNull *)ret isEqual:[NSNull null]]) {
        return nil;
    } else {
        return ret;
    }
}

@end
