//
//  WHCAlertView.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCAlertView.h"
#import <objc/runtime.h>

const char *WHC_alertView_Block = "WHC_alertView_Block";

@interface UIAlertView(WHCAlertView)

-(void)setClickBlock:(ClickAtIndexBlock)block;
-(ClickAtIndexBlock)clickBlock;

@end

@implementation UIAlertView(WHCAlertView)

-(void)setClickBlock:(ClickAtIndexBlock)block
{
    objc_setAssociatedObject(self, WHC_alertView_Block, block, OBJC_ASSOCIATION_COPY);
}

-(ClickAtIndexBlock)clickBlock
{
    return objc_getAssociatedObject(self, WHC_alertView_Block);
}
@end

@interface WHCAlertView ()<UIAlertViewDelegate>

@end

@implementation WHCAlertView

+(instancetype)alertCreateWithTitle:(NSString*)title message:(NSString *)messge cancelButtonTitle:(NSString *)cancelButtonTitle OtherButtonsArray:(NSArray*)otherButtons clickAtIndex:(ClickAtIndexBlock) clickAtIndex
{
    WHCAlertView  *al = [[super alloc] initWithTitle:title message:messge delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    al.clickBlock = clickAtIndex;
    for (NSString *otherTitle in otherButtons) {
        [al addButtonWithTitle:otherTitle];
    }
    [al show];
    return al;
}

#pragma mark   UIAlertViewDelegate
+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.clickBlock) {

        alertView.clickBlock(buttonIndex);
    }
}

@end
