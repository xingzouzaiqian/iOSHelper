//
//  UIImage+Helper.h
//  Utility
//
//  Created by LiuYue on 8/31/13.
//  Copyright (c) 2013 LiuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)stretchableImage:(NSString *)imageName leftCap:(NSInteger)leftCap topCap:(NSInteger)topCap;
+ (UIImage *)imageByName:(NSString *)name ofType:(NSString *)extension;
+ (UIImage *)imageByName:(NSString *)name;

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

@end
