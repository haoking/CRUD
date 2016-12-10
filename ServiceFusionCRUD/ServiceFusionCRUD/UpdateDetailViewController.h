//
//  UpdateDetailViewController.h
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/10/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseTableViewController.h"
#import "UserData.h"

@interface UpdateDetailViewController : WHCBaseTableViewController

@property (nonatomic, strong) NSIndexPath *updateIndexpath;

@property (nonatomic, strong) id data;

+(instancetype)updateDetailViewControllerCreate;

@end
