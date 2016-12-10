//
//  WHCBaseTableViewCell.m
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseTableViewCell.h"

@implementation WHCBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    self.multipleTouchEnabled = NO;
    return self;
}

+ (NSString *)WHCReuseIdentifier;
{
    return NSStringFromClass([self class]);
}

+ (CGFloat)height;
{
    return [self heightWithData:nil];
}

+ (CGFloat)heightWithData:(id)data;
{
    return 44;
}

- (void)setData:(id)data
{
    _data = data;
    [self configCell];
}

- (void)configCell;
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
