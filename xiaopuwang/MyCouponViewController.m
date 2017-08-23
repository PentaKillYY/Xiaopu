//
//  MyCouponViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyCouponViewController.h"
#import "MyCouponTableViewCell.h"
#import "MyCouponDetailTableViewCell.h"
#import "MyService.h"
@interface MyCouponViewController ()<UITableViewDelegate,UITableViewDataSource,CouponDetailDelegate,MyCouponDetailDelegate>
{
    NSMutableArray* showArray;
    DataResult* couponResult;
    NSInteger currentCoupon;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation MyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的优惠券";
    
    showArray = [NSMutableArray new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCouponDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCouponDetailTableViewCell"];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:nil];

    self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;

    self.tableView.hidden = YES;
    
    [self getMyCOuponListRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CouponToGive"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [couponResult.items getItem:currentCoupon];
        [theSegue setValue:item forKey:@"couponItem"];
    }
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return couponResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([showArray containsObject:@(section)]){
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (Main_Screen_Width-32)/672.0*194.0+8;
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"MyCouponDetailTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
           [self configCell:cell IndexPath:indexPath];
            
        }];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MyCouponTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyCouponTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        cell.couponDetail.tag = indexPath.section;
        if ([showArray containsObject:@(indexPath.section)]) {
            cell.couponDetail.selected = YES;
            cell.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            cell.couponDetail.selected = NO;
            cell.arrowImage.transform =  CGAffineTransformMakeRotation(2*M_PI);
        }
        [cell bingdingViewModel:[couponResult.items getItem:indexPath.section]];
        return cell;
    }else{
        MyCouponDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyCouponDetailTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [self configCell:cell IndexPath:indexPath];
        cell.giveToAnother.tag = indexPath.section;
        return cell;
    }
    
}

-(void)configCell:(MyCouponDetailTableViewCell*)cell IndexPath:(NSIndexPath*)path{
    [cell bingdingViewModel:CouponIntro];
}

#pragma mark - CouponDetailDelegate

-(void)changeDetailShowDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.selected) {
        if (![showArray containsObject:@(button.tag)]) {
            [showArray addObject:@(button.tag)];
        }
    }else{
        [showArray removeObject:@(button.tag)];
    }
    
    NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:button.tag];//刷新第二个section
    
    [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -  MyCouponDetailDelegate

-(void)giveAnotherDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentCoupon = button.tag;
    [self performSegueWithIdentifier:@"CouponToGive" sender:self];
}

#pragma mark - NetworkRequest
-(void)getMyCOuponListRequest{
    [[MyService sharedMyService] getUserCouponListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        couponResult = json;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end

