//
//  MainTabBarViewController.m
//  ZTEInfo
//
//  Created by Haochen Wang on 12/6/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillLayoutSubviews
{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 40;
    tabFrame.origin.y = self.view.frame.size.height - 40;
    self.tabBar.frame = tabFrame;
}


@end
