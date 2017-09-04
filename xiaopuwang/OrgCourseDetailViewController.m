//
//  OrgCourseDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgCourseDetailViewController.h"
#import "CourseDetailInfoTableViewCell.h"
#import "CourseDetailContentTableViewCell.h"
#import "CouseDetailImageTableViewCell.h"
#import "OrginizationService.h"
@interface OrgCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult* detailResult;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDetailContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgDetailContent"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDetailInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CourseDetailInfo"];
    
    [self getCourseDEtailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return Main_Screen_Width /37 *24.0;
        }else{
            return  [tableView fd_heightForCellWithIdentifier:@"CourseDetailInfo" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configTagCell:cell TagIndex:indexPath];
            }];
        }
    }else{
        return  [tableView fd_heightForCellWithIdentifier:@"OrgDetailContent" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configCell:cell indexpath:indexPath];
        }];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CouseDetailImageTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CouseDetailImageTableViewCell" owner:self options:nil].firstObject;
            
            [cell bingdingViewModel:detailResult];
            return cell;
        }else{
            CourseDetailInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CourseDetailInfoTableViewCell" owner:self options:nil].firstObject;
            
            [self configTagCell:cell TagIndex:indexPath];
            return cell;
        }
    }else{
        CourseDetailContentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CourseDetailContentTableViewCell" owner:self options:nil].firstObject;
        [self configCell:cell indexpath:indexPath];
        return cell;
    }
}

- (void)configCell:(CourseDetailContentTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    
    [cell bingdingViewModel:detailResult];

}

-(void)configTagCell:(CourseDetailInfoTableViewCell*)cell TagIndex:(NSIndexPath *)tagindexpath{
    
    
    [cell.courseTagView removeAllTags];
        
    [cell bingdingViewModel:detailResult];
    
    cell.courseTagView.preferredMaxLayoutWidth = Main_Screen_Width-16;
    
    cell.courseTagView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.courseTagView.lineSpacing = 5;
    cell.courseTagView.interitemSpacing = 5;
    cell.courseTagView.singleLine = NO;
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if ([detailResult.detailinfo getString:@"CourseType"]) {
        [array addObject:[detailResult.detailinfo getString:@"CourseType"]];
    }
    
    if ([detailResult.detailinfo getString:@"CourseKind"]) {
        [array addObject:[detailResult.detailinfo getString:@"CourseKind"]];
    }
    
    [array enumerateObjectsUsingBlock:^(NSString* text, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SKTag *tag = [[SKTag alloc] initWithText:text];
        
        tag.font = [UIFont systemFontOfSize:12];
        tag.textColor = [UIColor lightGrayColor];
        tag.bgColor =[UIColor whiteColor];
        tag.borderColor = [UIColor lightGrayColor];
        tag.borderWidth = 1.0;
        tag.cornerRadius = 3;
        tag.enable = NO;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.courseTagView addTag:tag];
    }];

}

-(void)getCourseDEtailRequest{
    [[OrginizationService sharedOrginizationService] getOrgCourseDetailWithParameters:@{@"courseId":self.courseId} onCompletion:^(id json) {
        detailResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
