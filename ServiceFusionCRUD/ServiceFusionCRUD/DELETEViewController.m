//
//  DELETEViewController.m
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "DELETEViewController.h"
#import "DeleteData.h"
#import "DeleteCell.h"

@interface DELETEViewController ()

@property (nonatomic, strong) WHCTextField *firstNameTextField;
@property (nonatomic, strong) WHCButton *addbtn;
@property (nonatomic, strong) WHCLabel *tipLabel;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation DELETEViewController

#pragma mark -- init --

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
    {
        return nil;
    }
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:IMAGE(@"delete") tag:2];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

    return self;
}

+(instancetype)deleteViewControllerCreate
{
    return [[self alloc] initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = IndigoColor;
    self.navigationItem.title = @"DELETE";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:IndigoColor}];
    [self reqestDidFinished];
    [self configConstraints];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self reqestDidFinished];
    self.dataArray = [NSMutableArray array];
    [self.tableView reloadData];
    [self reloadAllTextField];
}

-(void)setupTableView
{
    [super setupTableView];
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = IndigoColor;
}

#pragma mark -- componentLoad --

-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray)
    {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSourceArray;
}

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

-(WHCButton *)addbtn
{
    if (!_addbtn)
    {
        @WeakObj(self);
        _addbtn = [WHCButton buttonWithTitle:@"SELECT & DELETE" image:nil handler:^(UIButton *sender) {
            @StrongObj(self);
            if ([self.firstNameTextField.text isEqualToString:@""])
            {
                TOASTShown(@"First Name cannot be empty.");
            }
            else
            {

                [[WHCDBEngine sharedWHCDBEngine] selectUserWithFirstName:self.firstNameTextField.text withSuccess:^(NSMutableArray *resultArray) {

                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self reloadAllTextField];
                        if (resultArray.count == 0)
                        {
                            TOASTShown(@"0 results!");
                        }
                        else
                        {
                            TOASTShown(([NSString stringWithFormat:@"%ld results!", resultArray.count]));
                        }
                        self.dataSourceArray = resultArray;
                        [self reqestDidFinished];
                        [self.tableView reloadData];
                    });


                } withFail:^{

                    TOASTShown(@"Select fail!");
                }];
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
        _tipLabel = [WHCLabel labelCreateText:@"Left slider to delete" textCor:SnowColor textSize:nil];
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

    [self.addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.firstNameTextField);
        make.top.equalTo(self.firstNameTextField.mas_bottom).offset(MARGINS);
    }];

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.addbtn);
        make.top.equalTo(self.addbtn.mas_bottom);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tipLabel);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(MARGINS);
        make.bottom.equalTo(self.view).offset(-40);
    }];
}

#pragma mark - UITableViewDelegate

- (void)reqestDidFinished
{
    self.dataArray = [NSMutableArray array];
    for (UserData *data in self.dataSourceArray)
    {
        DeleteData *deleteData = [DeleteData deleteDataCreate];
        deleteData.ID = data.ID;
        deleteData.firstName = data.firstName;
        deleteData.lastName = data.lastName;
        deleteData.phone = data.phone;
        deleteData.birth = data.birth;
        deleteData.zip = data.zip;
        [self.dataArray addObject:deleteData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [WHCAlertView alertCreateWithTitle:@"Delete" message:@"Do you want to delete this data for sure? \nThen this data will be permanently deleted." cancelButtonTitle:@"Cancel" OtherButtonsArray:@[@"ok"] clickAtIndex:^(NSInteger buttonIndex) {

            if (buttonIndex == 1)
            {
                [[WHCDBEngine sharedWHCDBEngine] deleteUserWithID:[self.dataArray[indexPath.row] ID]];
                [self.dataArray removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                TOASTShown(@"Delete success!");
            }
            [self setEditing:NO animated:YES];
        }];
    }
}

#pragma mark -- Extra methods --

-(void)keyboardHidden
{
    [self.firstNameTextField resignFirstResponder];
}

-(void)reloadAllTextField
{
    [self keyboardHidden];
    [self.firstNameTextField reloadTextField];
}


@end
