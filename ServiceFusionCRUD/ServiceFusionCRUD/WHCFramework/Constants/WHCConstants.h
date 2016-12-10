//
//  WHCConstants.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/22/16.
//  Copyright © 2016 WHC. All rights reserved.
//


//
    //-------------------------------------extern define-------------------------------------
//UIKIT_EXTERN NSString * const DGBHttpURL;


    //-------------------------------------log define-------------------------------------
//#ifdef DEBUG
//#   define Debug_Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#   define Debug_Log(...)
//#endif

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...)
#endif

    //-------------------------------------__weak define-------------------------------------
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

    //-------------------------------------size define-------------------------------------
#define Status_Height ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define Nav_Height (self.navigationController.navigationBar.frame.size.height)
#define Bar_Height (Nav_Height+Status_Height)
//#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
//#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

#define MARGINS (SCREEN_WIDTH/20)
#define RoundCornerRadius (MARGINS*2.5/2)

    //-------------------------------------system define-------------------------------------
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define KEYWindow          [UIApplication sharedApplication].keyWindow


    //-------------------------------------singleton define-------------------------------------
// .h
#define SINGLETON_interface(className) + (className *)shared##className;

// .m
#define SINGLETON_implementation(className) \
+ (className *)shared##className { \
static className *_##className##_sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_##className##_sharedInstance = [[self alloc] init]; \
}); \
return _##className##_sharedInstance; \
}

    //-------------------------------------image define-------------------------------------
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]











