//
//  ActivityWebViewController.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityWebViewController : UITableViewController<UITextFieldDelegate>
{
    UIDatePicker* picker;
    UIPickerView* singlePicker;
}
@property (nonatomic,weak) NSString* activityType;

@end
