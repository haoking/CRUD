//
//  WHCBaseView.m
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseView.h"

@implementation WHCBaseView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    self.multipleTouchEnabled = NO;
    self.clipsToBounds = YES;
    return self;
}

+(instancetype)viewCreate
{
    return [[self alloc] initWithFrame:CGRectZero];
}

@end
