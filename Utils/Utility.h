//
//  Utility.h
//  LeheB
//
//  Created by zhangluyi on 11-5-4.
//  Copyright 2011年 Lehe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HolyHelper.h"

@interface Utility : NSObject {
    
}

+ (void)removeShadow:(UIView *)view;
+ (void)addShadowUp:(UIView *)view;
+ (void)addShadowByLayer:(UIView *)view;
+ (void)addShadow:(UIView *)view;
+ (void)addShadow:(UIView *)view withColor:(UIColor *)color width:(CGFloat)width;
+ (void)addBorderColor:(UIView *)imageView;
+ (void)clearBorderColor:(UIView *)imageView;
+ (void)addRoundCornerToView:(UIView *)view;

+ (NSString *)codeOfString:(NSString*)string;

+ (void)doAnimationFromLeft:(BOOL)leftDir
                   delegate:(id)_delegate 
                       view:(UIView *)_view 
                   duration:(CGFloat)duration;

+ (BOOL)isCharacterChinese:(unichar)ch;
char indexTitleOfString(unsigned short string);
+ (BOOL)isCharacter:(unichar)ch;
+ (CGFloat)getFloatRandom;
+ (NSInteger)getIntegerRandomWithInMax:(NSInteger)max;

+ (UIAlertView *)startWebViewMaskWithMessage:(NSString *)_message;

+ (void)disMissMaskView:(UIAlertView **)_alertView;

+ (NSMutableString *)URLStringMakeWithDict:(NSDictionary *)dict;

+ (void)setWebView:(UIWebView *)webView withId:(NSInteger)webId;

+ (void)changeNavigation:(UINavigationItem *)navItem Title:(NSString *)title;

+ (BOOL)isValidLatLon:(double)lat Lon:(double)lon;
+ (NSString*)getPhotoDownloadURL:(NSString*)currentURLString sizeType:(NSString*)sizetype;

+ (NSMutableDictionary *)datasourceFromListArray:(NSArray *)array;
+ (void)addRoundCornerToView:(UIView *)view radius:(NSInteger)radius borderColor:(UIColor *)color;
+ (void)addRoundCornerToView:(UIView *)view radius:(NSInteger)radius;
+ (void)addBorderView:(UIView *)view withColor:(UIColor *)color width:(CGFloat)width;
+ (NSString *)descriptionForDistance:(NSInteger)distance;
+ (NSString *)item:(NSString *)name descriptionWithCount:(NSInteger)count;

#pragma mark - date

+ (NSString *)descriptionForDateInterval:(NSString *)timeIntervalStr;
+ (NSString *)abbrdescriptionForDateInterval:(NSString *)timeIntervalStr;
+ (NSString *)date:(NSDate *)date descriptorWithFormate:(NSString *)dateFormat;
+ (NSDate *)dateStr:(NSString *)dateStr withFormate:(NSString *)formate;
+ (NSDictionary *)parseByDate:(NSDate *)date;
+ (NSDictionary *)intervalForDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSString *)timeIntervalFromDate:(NSString *)date withFormate:(NSString *)formate;

#pragma mark - save & read image

+ (void)saveImage:(UIImage *)image toDiskWithName:(NSString *)name;
+ (UIImage *)readImageFromDisk:(NSString *)path;
+ (void)saveImage:(UIImage *)image toDiskWithName:(NSString *)imageName atDirectory:(NSString *)dir;
+ (UIImage *)readImageFromDisk:(NSString *)imageName atDirectory:(NSString *)dir;

+ (void)drawLineFromPoint:(CGPoint )startPoint toPoint:(CGPoint)endPoint inContext:(CGContextRef)context withColor:(UIColor *)color;
+ (void)verticalizeButton:(UIButton *)button withSpace:(CGFloat)space;

#pragma mark - 

+ (BOOL)deviceCanCall;

@end
