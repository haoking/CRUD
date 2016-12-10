//
//  UPDATEViewController.m
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "UPDATEViewController.h"
#import "SelectData.h"
#import "UpdateDetailViewController.h"

@interface UPDATEViewController ()

@property (nonatomic, strong) WHCTextField *firstNameTextField;
@property (nonatomic, strong) WHCTextField *lastNameTextField;
@property (nonatomic, strong) WHCTextField *phoneTextField;
@property (nonatomic, strong) WHCTextField *birthTextField;
@property (nonatomic, strong) WHCTextField *zipTextField;
@property (nonatomic, strong) WHCButton *addbtn;
@property (nonatomic, strong) WHCLabel *tipLabel;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation UPDATEViewController

#pragma mark -- init --

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
    {
        return nil;
    }
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:IMAGE(@"update") tag:3];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    self.isUpload = UpdateNone;
    return self;
}

+(instancetype)updateViewControllerCreate
{
    return [[self alloc] initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = IndigoColor;
    self.navigationItem.title = @"UPDATE";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:IndigoColor}];
    [self reqestDidFinished];
    [self configConstraints];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isUpload == UpdateEnd)
    {
        [self.dataArray replaceObjectAtIndex:self.uploadIndexPath.row withObject:self.uploadData];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.uploadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    self.isUpload = UpdateNone;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self reqestDidFinished];
    if (self.isUpload == UpdateNone)
    {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
        [self reloadAllTextField];
    }
}

-(void)setupTableView
{
    [super setupTableView];
    [self.view addSubview:self.tableView];
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
        _addbtn = [WHCButton buttonWithTitle:@"SELECT & UPDATE" image:nil handler:^(UIButton *sender) {
            @StrongObj(self);
            if ([self.firstNameTextField.text isEqualToString:@""])
            {
                TOASTShown(@"First Name cannot be empty.");
            }
            else
            {
                [self keyboardHidden];

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

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstNameTextField);
        make.top.equalTo(self.addbtn.mas_bottom).offset(MARGINS);
        make.bottom.equalTo(self.view).offset(-40);
    }];
}

#pragma mark - UITableViewDelegate

- (void)reqestDidFinished
{
    self.dataArray = [NSMutableArray array];
    for (UserData *data in self.dataSourceArray)
    {
        SelectData *selectData = [SelectData selectDataCreate];
        selectData.ID = data.ID;
        selectData.firstName = data.firstName;
        selectData.lastName = data.lastName;
        selectData.phone = data.phone;
        selectData.birth = data.birth;
        selectData.zip = data.zip;
        [self.dataArray addObject:selectData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    UpdateDetailViewController *updateDetailViewController = [UpdateDetailViewController updateDetailViewControllerCreate];
    updateDetailViewController.data = self.dataArray[indexPath.row];
    updateDetailViewController.updateIndexpath = indexPath;
    updateDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateDetailViewController animated:YES];
    self.isUpload = UpdateBegin;
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"",@"") style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    self.navigationItem.backBarButtonItem = back;

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
