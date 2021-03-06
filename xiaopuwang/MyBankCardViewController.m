//
//  MyBankCardViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyBankCardViewController.h"
#import "MyService.h"
#import "MyCardTableViewCell.h"
#import "MyWalletViewController.h"
@interface MyBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,DeleteCardDelegate,UINavigationControllerDelegate>
{
    DataResult* cardRequest;
    NSInteger selectCardIndex;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的银行卡";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addCardRequest)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = rightItm;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self getCardListRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cardRequest.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCardTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyCardTableViewCell" owner:self options:nil].firstObject;
    cell.delegate = self;
    cell.cancelButton.tag = indexPath.section;
    [cell bingdingViewModel:[cardRequest.items getItem:indexPath.section]];
    return cell;
}

#pragma mark - DeleteCardDelegate

-(void)deleteCard:(id)sender{
    UIButton* button = (UIButton*)sender;
    selectCardIndex = button.tag;
    [self deleteCardRequest];
}

-(void)getCardListRequest{
    [[MyService sharedMyService] getUserBankCardWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        cardRequest = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)addCardRequest{
    [self performSegueWithIdentifier:@"BankCardToAddCard" sender:self];
}


-(void)deleteCardRequest{
    [[MyService sharedMyService] deleteBankcardWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"cardNum":[[cardRequest.items getItem:selectCardIndex] getString:@"CardNum"]} onCompletion:^(id json) {
        
        [self getCardListRequest];
    } onFailure:^(id json) {
        
    }];
}


@end
