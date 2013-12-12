//
//  NSString+Helpers.h

//
//  Created by Reejo Samuel on 8/2/13.
//  Copyright (c) 2013 Reejo Samuel | m[at]reejosamuel.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)MD5;
- (NSString *)sha1;
- (NSString *)reverse;
- (NSString *)URLEncode;
- (NSString *)URLDecode;
- (NSString *)stringByStrippingWhitespace;
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)CapitalizeFirst:(NSString *)source;
- (NSString *)UnderscoresToCamelCase:(NSString*)underscores;
- (NSString *)CamelCaseToUnderscores:(NSString *)input;
- (NSInteger)hexInt;

- (NSUInteger)countWords;

- (BOOL)contains:(NSString *)string;
- (BOOL)isBlank;
- (BOOL)isValid;
- (BOOL)isNumberString;

#pragma mark - value
- (NSString *)validString;
- (NSString *)removeNewLine;
- (NSString *)stringValue;
- (NSString *)removeSpace;
- (NSString *)trimTagCode;
- (NSString *)removeSpaceAndNewLine;

#pragma mark - mobile num in China
- (NSString *)getCorrectMobileNumber;
- (BOOL)isMobileNumber;
- (BOOL)isValidEmail;

#pragma mark - base64

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;


@end
