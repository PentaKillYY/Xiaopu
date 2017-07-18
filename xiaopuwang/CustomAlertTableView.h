//
//  CustomAlertTableView.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RowSelectDelegate <NSObject>

-(void)selectRow:(NSInteger)rowIndex;

@end

@interface CustomAlertTableView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* tableView;
    
}

@property NSInteger rowCount;
@property(nonatomic,assign)id<RowSelectDelegate>delegate;
@property(nonatomic,copy)NSString* tableTitle;

-(instancetype)initWithFrame:(CGRect)frame rowCount:(NSInteger)count title:(NSString*)title;
-(void)show:(UIView*)changeOutView dur:(CFTimeInterval)dur;
-(void)dismiss;

@end

