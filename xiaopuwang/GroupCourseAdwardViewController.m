//
//  GroupCourseAdwardViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseAdwardViewController.h"
#import "GroupCourseService.h"
#import "GroupCourseDetailTableViewCell.h"
#import "GroupCourseAdwardGradeCell.h"
#import "GroupCourseAdwardGradeTitleCell.h"
#import "GroupCourseAdwardInfoTableViewCell.h"

@interface GroupCourseAdwardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult* detailResult;
    DataResult* adwardResult;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation GroupCourseAdwardViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self gerGroupCourseDetailRequest];
    [self getAdwardListRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatesource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
    }else{
        return 2+[adwardResult.detailinfo getDataItemArray:@"Tow"].size;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 108;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        GroupCourseDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            GroupCourseAdwardGradeCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardGradeCell" owner:self options:nil].firstObject;
            cell.gradeLabel.text = @"一等奖名单";
            return cell;
        }else if (indexPath.row==1){
            GroupCourseAdwardGradeTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardGradeTitleCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            GroupCourseAdwardInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardInfoTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:[[adwardResult.detailinfo getDataItemArray:@"Tow"] getItem:indexPath.row-2]];
            return cell;
        }
    }else{
        if (indexPath.row==0) {
            GroupCourseAdwardGradeCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardGradeCell" owner:self options:nil].firstObject;
            cell.gradeLabel.text = @"二等奖名单";
            return cell;
        }else if (indexPath.row==1){
            GroupCourseAdwardGradeTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardGradeTitleCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            GroupCourseAdwardInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseAdwardInfoTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:[[adwardResult.detailinfo getDataItemArray:@"Tow"] getItem:indexPath.row-2]];
            return cell;
        }
    }
}


-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Networkrequest

-(void)gerGroupCourseDetailRequest{
    if ([UserInfo sharedUserInfo].userID.length) {
        [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
            
            detailResult = json;
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }else{
        [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId} onCompletion:^(id json) {
            
            detailResult = json;
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }
    
}

-(void)getAdwardListRequest{
    [[GroupCourseService sharedGroupCourseService] getAdwardListWithParameters:@{@"fightCourseId":self.courseId} onCompletion:^(id json) {
        
        adwardResult = json;
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}
@end
