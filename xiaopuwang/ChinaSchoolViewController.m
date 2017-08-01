//
//  ChinaSchoolViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/1.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ChinaSchoolViewController.h"
#import "ChinaSchoolBannerTableViewCell.h"
#import "SchoolTableViewCell.h"
#import "DOPDropDownMenu.h"
@interface ChinaSchoolViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DOPDropDownMenu *menu;
@end

@implementation ChinaSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"中国学校";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ChinaSchoolBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ChinaSchoolBannerTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else{
        SchoolTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolTableViewCell" owner:self options:nil].firstObject;
//        [self configCell:cell indexpath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else{
        return 100;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section == 0) {
        return 0;
    }else{
        return 50.0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        if (!_menu) {
            DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 181) andHeight:50 andWidth:Main_Screen_Width];
            menu.delegate = self;
            menu.dataSource = self;
            _menu = menu;
            _menu.type = 1;
            _menu.menuWidth = Main_Screen_Width;
            
            [_menu selectDefalutIndexPath];
        }
        return _menu;
        
    }
}

@end
