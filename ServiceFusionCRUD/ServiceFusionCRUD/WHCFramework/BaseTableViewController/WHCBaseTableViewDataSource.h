//
//  WHCBaseTableViewDataSource.h
//  WHCAPP
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WHCBaseTableViewDataSource <NSObject>

@optional
- (NSInteger)sectionCount; // Default is 1 if not implemented

@required
- (void)setupTableView;
- (NSInteger)rowCountInSection:(NSInteger)section;
- (id)dataForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath;

@optional
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

@end
