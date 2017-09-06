//
//  MainMoreTypeViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/5.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainMoreTypeViewController.h"
#import "OrginizationService.h"
#import "SearchTableViewCell.h"

@interface MainMoreTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult* courseTypeResult;
    DataResult* groupTypeResult;
    NSString* courseValue;
    
    NSInteger leftIndex;
    
    NSString* chinaSchoolType;
    NSString* schoolType;
    NSString* orgType;
    NSString* orgKind;
}
@property(nonatomic,weak)IBOutlet UITableView* leftTableView;
@property(nonatomic,weak)IBOutlet UITableView* rightTableView;

@end

@implementation MainMoreTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    courseValue = @"1";
    self.title = @"全部科目";
    
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getCourseTypeList];
    [self getGroupList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainMoreToOrg"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:orgType forKey:@"orgType"];
        [theSegue setValue:orgKind forKey:@"orgKind"];
    }
    else if ([segue.identifier isEqualToString:@"MainMoreToSchool"] ){
        id theSegue = segue.destinationViewController;
        [theSegue  setValue:schoolType forKey:@"schoolCountryName"];
    }else if ([segue.identifier isEqualToString:@"MainMoreToChinaSchool"]){
        id theSegue = segue.destinationViewController;
        [theSegue  setValue:chinaSchoolType forKey:@"chinaType"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 10;
    }else{
         if ([courseValue intValue] == 80) {
             return 6;
         }else if ([courseValue intValue] == 90){
             return 6;
         }else{
             return groupTypeResult.items.size;
         }
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil].firstObject;
    if (tableView == self.leftTableView) {
        cell.searchName.text = [[courseTypeResult.items getItem:indexPath.row] getString:@"Text"];
        if (indexPath.row == 8) {
            cell.searchName.text  = @"国际学校";
        }else if (indexPath.row ==9){
            cell.searchName.text  = @"海外学校";
        }
        
        if (indexPath.row == leftIndex) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            cell.contentView.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
        }
        
    }else{
        if ([courseValue intValue] == 80) {
            cell.searchName.text = InterSchoolTitle[indexPath.row];
        }else if ([courseValue intValue] == 90){
            cell.searchName.text = OverSeaSchoolTitle[indexPath.row];
        }else{
            cell.searchName.text = [[groupTypeResult.items getItem:indexPath.row] getString:@"Text"];
        }
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        leftIndex = indexPath.row;
        
        if (indexPath.row < 8) {
            courseValue = [[courseTypeResult.items getItem:indexPath.row] getString:@"Value"];
            orgType = [[courseTypeResult.items getItem:indexPath.row] getString:@"Text"];
            [self getGroupList];
        }else{
            courseValue = [NSString stringWithFormat:@"%ld",indexPath.row*10];
            [self.rightTableView reloadData];
        }
        
        [self.leftTableView reloadData];
    }else{
        if ([courseValue intValue] == 80) {
            chinaSchoolType = InterSchoolTitle[indexPath.row];
            [self performSegueWithIdentifier:@"MainMoreToChinaSchool" sender:self];
        }else if ([courseValue intValue] == 90){
            schoolType = OverSeaSchoolTitle[indexPath.row];
            [self performSegueWithIdentifier:@"MainMoreToSchool" sender:self];
        }else{
            
            orgKind = [[groupTypeResult.items getItem:indexPath.row] getString:@"Text"];
            [self performSegueWithIdentifier:@"MainMoreToOrg" sender:self];
        }
    }
}

-(void)getCourseTypeList{
    [[OrginizationService sharedOrginizationService] getCoursetypeParameters:@{@"courseType":@"CourseType"} onCompletion:^(id json) {
        courseTypeResult = json;
        orgType = [[courseTypeResult.items getItem:0] getString:@"Text"];

        [self.leftTableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getGroupList{
    [[OrginizationService sharedOrginizationService] getGroupTypeParameters:@{@"courseType":@"CourseType",@"value":courseValue} onCompletion:^(id json) {
        groupTypeResult = json;
        [self.rightTableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}


@end
