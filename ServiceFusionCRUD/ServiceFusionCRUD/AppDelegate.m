//
//  AppDelegate.m
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "AppDelegate.h"
#import "ADDViewController.h"
#import "DELETEViewController.h"
#import "UPDATEViewController.h"
#import "SELECTViewController.h"
#import "MainTabBarViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) ADDViewController *addViewController;
@property (nonatomic, strong) DELETEViewController *deleteViewController;
@property (nonatomic, strong) UPDATEViewController *updateViewController;
@property (nonatomic, strong) SELECTViewController *selectViewController;
@property (nonatomic, strong) NSMutableArray *controllersArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [NSThread sleepForTimeInterval:2.0];//stop at launchscreen

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.addViewController = [ADDViewController addViewControllerCreate];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:self.addViewController];

    self.selectViewController = [SELECTViewController selectViewControllerCreate];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:self.selectViewController];

    self.deleteViewController = [DELETEViewController deleteViewControllerCreate];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:self.deleteViewController];

    self.updateViewController = [UPDATEViewController updateViewControllerCreate];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:self.updateViewController];

    UITabBarController *tabBarController =[[MainTabBarViewController alloc] init];

    self.controllersArray = [[NSMutableArray alloc] initWithCapacity:4];
    NSArray *array = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    [self.controllersArray addObjectsFromArray:array];
    [tabBarController setViewControllers:self.controllersArray];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
