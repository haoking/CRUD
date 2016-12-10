//
//  WHCAlertView.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHCAlertView : UIAlertView

typedef void (^ClickAtIndexBlock)(NSInteger buttonIndex);

+(instancetype)alertCreateWithTitle:(NSString*)title message:(NSString *)messge cancelButtonTitle:(NSString *)cancelButtonTitle OtherButtonsArray:(NSArray*)otherButtons clickAtIndex:(ClickAtIndexBlock) clickAtIndex;

@end
