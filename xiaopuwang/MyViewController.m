//
//  MyViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyViewController.h"
#import "MyBannerCell.h"
#import "MyTableCell.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hideNavigationBar:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MyBannerCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyBannerCell" owner:self options:nil].firstObject;
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:V_IMAGE(@"top")];
        return cell;
    }else {
        MyTableCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil].firstObject;
        cell.cellTitle.text = MyCellTitle[indexPath.section-1][indexPath.row];
        NSString* imageName = [NSString stringWithFormat:@"My-%ld-%ld",indexPath.section,indexPath.row];
        
        
        cell.cellImage.image = V_IMAGE(imageName);
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.cellDetail.text = @"0.00元";
        }else if (indexPath.section == 2 && indexPath.row == 1){
            cell.cellDetail.text = @"0张";
        }else if (indexPath.section == 2 && indexPath.row == 2){
            cell.cellDetail.text = @"0.00元";
        }else{
            cell.cellDetail.text = @"";
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Main_Screen_Width/1080*533;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// kvo





@end
