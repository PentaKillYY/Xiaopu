//
//  CustomAlertTableView.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CustomAlertTableView.h"
#import "SchoolTypeTableViewCell.h"

@implementation CustomAlertTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame rowCount:(NSInteger)count title:(NSString*)title;
{
    self = [super initWithFrame:frame];
    if (self) {
        _rowCount = count;
        
        self.tableTitle =title;
        
        UIView* bgView = [[UIView alloc] initWithFrame:frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.8;
        [self addSubview:bgView];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        
        bgView.userInteractionEnabled = YES;
        
        [bgView addGestureRecognizer:tap];
        
        if (count*44+44>Main_Screen_Height-214) {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 70+64, frame.size.width-50, Main_Screen_Height-214) style:UITableViewStylePlain];
        }else{
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 70+64, frame.size.width-50, count*44+44) style:UITableViewStylePlain];
        }
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
        [self show:tableView dur:0.3];
        
        [tableView.layer setCornerRadius:3.0];
        [tableView.layer setMasksToBounds:YES];
    }
    return self;
}

-(void)show:(UIView*)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation* animation;
    animation= [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration= dur;
    
    animation.removedOnCompletion= NO;
    
    animation.fillMode= kCAFillModeForwards;
    
    NSMutableArray*values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values= values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}

-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowCount;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolTypeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolTypeTableViewCell" owner:self options:nil].firstObject;
    if([self.tableTitle isEqualToString:@"选择身份"]){
        cell.typeName.text = UserIdentityType[indexPath.row];
        cell.typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",UserIdentityType[indexPath.row]]];
    }else if ([self.tableTitle isEqualToString:@"请选择学校类型"]) {
        cell.typeName.text = PersonChooseSchoolType[indexPath.row];
        cell.typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"personchoose-%ld",(long)indexPath.row]];
    }else{
        cell.typeName.text = self.cellTitleArray[indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-50, 44)];
    
    
    UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(44.5, 0, 200, 44)];
    header.font = [UIFont systemFontOfSize:13.0];
    header.textColor = [UIColor blackColor];
    header.text = self.tableTitle;
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:header];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectRow:indexPath.row];
}
@end
