//
//  WHCBaseTableViewController.m
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseTableViewController.h"

@interface WHCBaseTableViewController ()

@end

@implementation WHCBaseTableViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
    {
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.tableView.visibleCells count] == 0)
    {
        [self.tableView reloadData];
    }
    else
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    [self.tableView flashScrollIndicators];
}

#pragma mark - componentLoad

-(void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataArray = [NSMutableArray array];
}

#pragma mark - DPBaseTableViewDataSource

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath
{
    return self.dataArray[indexPath.row];
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath
{
    id data = [self dataForIndexPath:indexPath];
    Class dataClass = [data class];
    NSString *dataClassName = NSStringFromClass(dataClass);
    NSString *cellClassName = nil;
    if([dataClassName hasSuffix:@"Data"]) {
        cellClassName = [[dataClassName substringToIndex:dataClassName.length-@"Data".length] stringByAppendingString:@"Cell"];
    }
    Class cellClass = cellClassName ? NSClassFromString(cellClassName) : [WHCBaseTableViewCell class];
    return cellClass;
}

- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return [[self cellClassForIndexPath:indexPath] WHCReuseIdentifier];
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath
{
    Class class = [self cellClassForIndexPath:indexPath];
    id    data  = [self dataForIndexPath:indexPath];
    return [class heightWithData:data];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self rowCountInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [self reuseIdentifierForIndexPath:indexPath];
    Class class = [self cellClassForIndexPath:indexPath];
    WHCBaseTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
        //    else
        //    {
        //            //删除cell的所有子视图
        //        while ([cell.contentView.subviews lastObject] != nil)
        //        {
        //            UIView *view = (UIView*)[cell.contentView.subviews lastObject];
        //            [view removeFromSuperview];
        //            view= nil;
        //        }
        //    }
    cell.data = [self dataForIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self setEditing:YES animated:YES];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self setEditing:NO animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

-(void)dealloc
{
    NSLog(@"%@ dealloc", self);
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
