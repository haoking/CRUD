//
//  ADDViewController.m
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "ADDViewController.h"

@interface ADDViewController ()

@property (nonatomic, strong) WHCTextField *firstNameTextField;
@property (nonatomic, strong) WHCTextField *lastNameTextField;
@property (nonatomic, strong) WHCTextField *phoneTextField;
@property (nonatomic, strong) WHCTextField *birthTextField;
@property (nonatomic, strong) WHCTextField *zipTextField;
@property (nonatomic, strong) WHCButton *addbtn;
@property (nonatomic, strong) WHCLabel *tipLabel;

@end

@implementation ADDViewController

#pragma mark -- init --

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
    {
        return nil;
    }
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:IMAGE(@"add") tag:0];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

    return self;
}

+(instancetype)addViewControllerCreate
{
    return [[self alloc] initWithNibName:nil bundle:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = IndigoColor;
    self.navigationItem.title = @"ADD";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:IndigoColor}];
    [self configConstraints];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self reloadAllTextField];
}

#pragma mark -- componentLoad --

-(WHCTextField *)firstNameTextField
{
    if (!_firstNameTextField)
    {
        _firstNameTextField = [WHCTextField textFieldCreateWithPlaceHolder:@"FirstName"];
        [self.view addSubview:_firstNameTextField];
        _firstNameTextField.backgroundColor = SnowColor;
    }
    return _firstNameTextField;
}

-(WHCTextField *)lastNameTextField
{
    if (!_lastNameTextField)
    {
        _lastNameTextField = [WHCTextField textFieldCreateWithPlaceHolder:@"LastName"];
        [self.view addSubview:_lastNameTextField];
        _lastNameTextField.backgroundColor = SnowColor;
    }
    return _lastNameTextField;
}

-(WHCTextField *)phoneTextField
{
    if (!_phoneTextField)
    {
        _phoneTextField = [WHCTextField textFieldCreateWithPlaceHolder:@"Phone"];
        [self.view addSubview:_phoneTextField];
        _phoneTextField.backgroundColor = SnowColor;
    }
    return _phoneTextField;
}

-(WHCTextField *)birthTextField
{
    if (!_birthTextField)
    {
        _birthTextField = [WHCTextField textFieldCreateWithPlaceHolder:@"Birth"];
        [self.view addSubview:_birthTextField];
        _birthTextField.backgroundColor = SnowColor;
    }
    return _birthTextField;
}

-(WHCTextField *)zipTextField
{
    if (!_zipTextField)
    {
        _zipTextField = [WHCTextField textFieldCreateWithPlaceHolder:@"Zip-code"];
        [self.view addSubview:_zipTextField];
        _zipTextField.backgroundColor = SnowColor;
    }
    return _zipTextField;
}

-(WHCButton *)addbtn
{
    if (!_addbtn)
    {
        @WeakObj(self);
        _addbtn = [WHCButton buttonWithTitle:@"ADD" image:nil handler:^(UIButton *sender) {
            @StrongObj(self);
            if ([self.firstNameTextField.text isEqualToString:@""] ||
                [self.lastNameTextField.text isEqualToString:@""] ||
                [self.phoneTextField.text isEqualToString:@""] ||
                [self.birthTextField.text isEqualToString:@""] ||
                [self.zipTextField.text isEqualToString:@""])
            {
                TOASTShown(@"Every Field cannot be empty.");
            }
            else
            {
                [[WHCDBEngine sharedWHCDBEngine] addUserWithFirstName:self.firstNameTextField.text
                                                         withLastName:self.lastNameTextField.text
                                                            withPhone:self.phoneTextField.text
                                                            withBirth:self.birthTextField.text
                                                              withZip:self.zipTextField.text];
                TOASTShown(@"Add success!");
                [self reloadAllTextField];
            }
        }];
        [self.view addSubview:_addbtn];
        _addbtn.titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
        _addbtn.backgroundColor = DenimColor;
        _addbtn.layer.borderWidth = 1.0f;
        _addbtn.layer.cornerRadius = 6.0f;
        _addbtn.layer.borderColor = ClearColor.CGColor;
        [_addbtn setTitleColor:SnowColor forState:UIControlStateNormal];
    }
    return _addbtn;
}

-(WHCLabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [WHCLabel labelCreateText:@"© 2016-2017, CRUD.com, Inc. or its affiliates." textCor:SnowColor textSize:nil];
        [self.view addSubview:_tipLabel];
    }
    return _tipLabel;
}

#pragma mark -- configConstraints --

-(void)configConstraints
{

    [self.firstNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MARGINS);
        make.right.equalTo(self.view).offset(-MARGINS);
        make.height.equalTo(@(MARGINS*2));
        make.top.equalTo(self.view).offset(MARGINS+Bar_Height);
    }];

    [self.lastNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstNameTextField);
        make.top.equalTo(self.firstNameTextField.mas_bottom).offset(MARGINS);
    }];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.lastNameTextField);
        make.top.equalTo(self.lastNameTextField.mas_bottom).offset(MARGINS);
    }];

    [self.birthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(MARGINS);
    }];

    [self.zipTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.birthTextField);
        make.top.equalTo(self.birthTextField.mas_bottom).offset(MARGINS);
    }];

    [self.addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.zipTextField);
        make.top.equalTo(self.zipTextField.mas_bottom).offset(MARGINS);
    }];

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.addbtn);
        make.top.equalTo(self.addbtn.mas_bottom);
    }];
}

#pragma mark -- Extra methods --

-(void)keyboardHidden
{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.birthTextField resignFirstResponder];
    [self.zipTextField resignFirstResponder];
}

-(void)reloadAllTextField
{
    [self keyboardHidden];
    [self.firstNameTextField reloadTextField];
    [self.lastNameTextField reloadTextField];
    [self.phoneTextField reloadTextField];
    [self.birthTextField reloadTextField];
    [self.zipTextField reloadTextField];
}

@end
