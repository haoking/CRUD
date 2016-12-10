//
//  WHCBaseTableViewController.h
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseViewController.h"
#import "WHCBaseTableViewDataSource.h"
#import "WHCBaseTableViewCell.h"

@interface WHCBaseTableViewController : WHCBaseViewController <UITableViewDelegate, UITableViewDataSource, WHCBaseTableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)setupTableView;

#pragma mark - WHCTableViewDataSource
- (NSInteger)sectionCount;
- (NSInteger)rowCountInSection:(NSInteger)section;
- (id)dataForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UIViewControllerEditing
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
