//
//  ActivityViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityWebViewController.h"
@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentType;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动专区";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   }



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.activityArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil].firstObject;
    [cell bingdingViewModel:self.activityArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  (Main_Screen_Width-10)/2+31;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentType = indexPath.row;
    [self performSegueWithIdentifier:@"ActivityToWeb" sender:self];
}
@end
