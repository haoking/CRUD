//
//  WHCTextField.h
//  DESSS
//
//  Created by Haochen Wang on 12/3/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WHCTextField;

typedef NS_ENUM(NSInteger, WHCTextFieldStyle)
{
    WHCTextFieldStyleEmail,          //Default placeholder: 'Email';   Default validation: email validation regular expression
    WHCTextFieldStylePhone,          //Default placeholder: 'Phone';   Default format: '###-###-####'
    WHCTextFieldStylePassword,       //Default placeholder: 'Password; Default: secure text entry
    WHCTextFieldStyleNone,           //Default style
};

@interface WHCTextField : UITextField

+(instancetype)textFieldCreateWithPlaceHolder:(NSString *)placeHolder;

+(instancetype)textFieldCreateWithStyle:(WHCTextFieldStyle)style;

-(void)reloadTextField;

-(void)uploadWithText:(NSString *)text;

@end
