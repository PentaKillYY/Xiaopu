//
//  MyAboutViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyAboutViewController.h"
#import "MyAboutInfoTableViewCell.h"
#import "MyAboutDetailTableViewCell.h"
@interface MyAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MyAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAboutInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAboutInfoTableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"MyAboutInfoTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configCell:cell Index:indexPath];
            
        }];
    }else{
        return 93;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyAboutInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAboutInfoTableViewCell" owner:self options:nil].firstObject;
        [self configCell:cell Index:indexPath];
        return cell;
    }else{
        MyAboutDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAboutDetailTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }
    
}

-(void)configCell:(MyAboutInfoTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell setupCellContent];
}
@end
