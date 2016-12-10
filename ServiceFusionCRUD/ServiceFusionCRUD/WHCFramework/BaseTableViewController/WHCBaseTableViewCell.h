//
//  WHCBaseTableViewCell.h
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCBaseView.h"

@interface WHCBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id data;

+ (NSString *)WHCReuseIdentifier;

    // subclass override
+ (CGFloat)height;
+ (CGFloat)heightWithData:(id)data;
- (void)configCell;

@end
