//
//  UserData.h
//  ServiceFusionCRUD
//
//  Created by Haochen Wang on 12/9/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

/**
 *  @brief _id
 */
@property (nonatomic, assign) int ID;

/**
 *  @brief firstName
 */
@property (nonatomic, strong) NSString *firstName;

/**
 *  @brief lastName
 */
@property (nonatomic, strong) NSString *lastName;

/**
 *  @brief phone
 */
@property (nonatomic, strong) NSString *phone;

/**
 *  @brief birth
 */
@property (nonatomic, strong) NSString *birth;

/**
 *  @brief zip
 */
@property (nonatomic, strong) NSString *zip;

+(instancetype)userDataCreate;


@end
