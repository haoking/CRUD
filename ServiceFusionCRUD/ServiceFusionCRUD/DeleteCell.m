//
//  DeleteCell.m
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/10/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "DeleteCell.h"
#import "DeleteData.h"

@interface DeleteCell ()

@property (nonatomic, strong) WHCLabel *nameLabel;
@property (nonatomic, strong) WHCLabel *phoneLabel;
@property (nonatomic, strong) WHCLabel *birthLabel;
@property (nonatomic, strong) WHCLabel *zipLabel;

@end

@implementation DeleteCell

+ (CGFloat)heightWithData:(id)data;
{
    return SCREEN_WIDTH/3;
}

- (void)configCell;
{
    [super configCell];
    [self loadContent];
    [self configConstraints];
    self.backgroundColor = SnowColor;
}

-(void)loadContent
{
    [self.nameLabel setText:[NSString stringWithFormat:@"%@, %@", [self.data firstName], [self.data lastName]]];
    [self.phoneLabel setText:[NSString stringWithFormat:@"Phone: %@", [self.data phone]]];
    [self.birthLabel setText:[NSString stringWithFormat:@"Birth: %@", [self.data birth]]];
    [self.zipLabel setText:[NSString stringWithFormat:@"Zip-code: %@", [self.data zip]]];
}

- (void)prepareForReuse
{
    [super prepareForReuse];

}

#pragma mark - componentLoad

-(WHCLabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [WHCLabel labelCreateText:[NSString stringWithFormat:@"%@, %@", [self.data firstName], [self.data lastName]] textCor:IndigoColor textSize:NameFont];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

-(WHCLabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [WHCLabel labelCreateText:[NSString stringWithFormat:@"Phone: %@", [self.data phone]] textCor:IndigoColor textSize:nil];
        [self.contentView addSubview:_phoneLabel];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}

-(WHCLabel *)birthLabel
{
    if (!_birthLabel)
    {
        _birthLabel = [WHCLabel labelCreateText:[NSString stringWithFormat:@"Birth: %@", [self.data birth]] textCor:IndigoColor textSize:nil];
        [self.contentView addSubview:_birthLabel];
        _birthLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _birthLabel;
}

-(WHCLabel *)zipLabel
{
    if (!_zipLabel)
    {
        _zipLabel = [WHCLabel labelCreateText:[NSString stringWithFormat:@"Zip-code: %@", [self.data zip]] textCor:IndigoColor textSize:nil];
        [self.contentView addSubview:_zipLabel];
        _zipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _zipLabel;
}

#pragma mark - configConstraints

-(void)configConstraints
{

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MARGINS);
        make.right.equalTo(self.contentView).offset(-MARGINS);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@(SCREEN_WIDTH/3 * 2/5));
    }];

    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@(SCREEN_WIDTH/3 * 1/5));
    }];

    [self.birthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.phoneLabel.mas_bottom);
        make.height.equalTo(@(SCREEN_WIDTH/3 * 1/5));
    }];

    [self.zipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.birthLabel.mas_bottom);
        make.height.equalTo(@(SCREEN_WIDTH/3 * 1/5));
    }];
}

#pragma mark -- Extra methods --



@end
