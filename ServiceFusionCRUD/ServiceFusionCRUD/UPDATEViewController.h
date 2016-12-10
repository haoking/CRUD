//
//  UPDATEViewController.h
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCBaseTableViewController.h"
#import "UserData.h"

typedef NS_ENUM(NSInteger, Update) {
    UpdateNone = 200,
    UpdateBegin = 180,
    UpdateEnd = 150,
};

@interface UPDATEViewController : WHCBaseTableViewController



@property (nonatomic, assign) Update isUpload;
@property (nonatomic, strong) NSIndexPath *uploadIndexPath;
@property (nonatomic, strong) UserData *uploadData;

+(instancetype)updateViewControllerCreate;

@end
