//
//  Const.h
//  DreamFactory
//
//  Created by  on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568 )
#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IOS7_ORLATER (SYSTEM_VERSION >= 7.0)
#define SYSTEM_CALL(TEL) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", (TEL)]]])

#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define NavigationBar_HEIGHT 44
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// Client Version
#define kClientVersion  [[[NSBundle mainBundle] infoDictionary] objForKey:@"CFBundleVersion"]
#define kDeviceUuid     [[UIDevice currentDevice] uniqueDeviceIdentifier]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define DB_SAVE() ([[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait])

#define PERFORM_SELECTOR(a, b) \
do { \
if([a respondsToSelector:b]) { \
    [a performSelector:b]; \
} \
} while (0)

#define PERFORM_SELECTOR_WITH_OBJECT(a, b, c) \
do { \
if([a respondsToSelector:b]) { \
[a performSelector:b withObject:c]; \
} \
} while (0)

#define APP_DEBUG

//Debug
#ifdef APP_DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define LOG_NETWORK(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"network",level,__VA_ARGS__)
    #define LOG_GENERAL(...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,[[NSString stringWithUTF8String:__FILE__] lastPathComponent],1,__VA_ARGS__)
    #define LOG_GRAPHICS(level, ...)   LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"graphics",level,__VA_ARGS__)
#else
    #define DLog(...)
    #define LOG_NETWORK(...)    do{}while(0)
    #define LOG_GENERAL(...)    do{}while(0)
    #define LOG_GRAPHICS(...)   do{}while(0)
#endif

#define HTTP_PREFIX (@"http://")



