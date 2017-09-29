//
//  InviteViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteBannerTableViewCell.h"
#import "InviteSendTableViewCell.h"
#import "InviteStrategyTableViewCell.h"
#import "InvitePeopleAndRuleTableViewCell.h"
#import "InvitePeopleContentTableViewCell.h"
#import "InvitePeopleBottomTableViewCell.h"
#import "RedBagService.h"
#import "InviteRuleTableViewCell.h"

@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource,InvitePeopleAndRuleDelegate,InviteSendDelegate>
{
    DataResult*  inviteResult;
    NSInteger currentSegIndex;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"InviteRuleTableViewCell" bundle:nil] forCellReuseIdentifier:@"InviteRuleTableViewCell"];
    
    [self getUserRedBagRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewdatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section<3) {
        return 1;
    }else{
        if (currentSegIndex ==0) {
            return [inviteResult.detailinfo getDataItemArray:@"list"].size+1;

        }else{
            return 2;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 200;
    }else if (indexPath.section==1){
        return 180;
    }else if (indexPath.section ==2){
        return  (Main_Screen_Width-24)/231*128 +8;
    }else{
        if (indexPath.row ==0) {
            return 44;
        }else{
            if (currentSegIndex==0) {
                return 44;
            }else{
                return  [tableView fd_heightForCellWithIdentifier:@"InviteRuleTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                    [self configCell:cell IndexPath:indexPath];
                }];
            }
        }
        
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        InviteBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteBannerTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section==1){
        InviteSendTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteSendTableViewCell" owner:self options:nil].firstObject;
        if (inviteResult) {
            [cell setupInviteTotal:inviteResult];
        }
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==2){
        InviteStrategyTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteStrategyTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else{
        
        if (indexPath.row ==0) {
            InvitePeopleAndRuleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleAndRuleTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            cell.segmentedControl.selectedSegmentIndex =currentSegIndex;
            return cell;
        }else{
            if (currentSegIndex ==0) {
                if (indexPath.row ==[inviteResult.detailinfo getDataItemArray:@"list"].size) {
                    InvitePeopleBottomTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleBottomTableViewCell" owner:self options:nil].firstObject;
                    [cell bingdingViewModel:[[inviteResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row-1]];
                    
                    return cell;
                }else{
                    InvitePeopleContentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleContentTableViewCell" owner:self options:nil].firstObject;
                    [cell bingdingViewModel:[[inviteResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row-1]];
                    return cell;
                }
            }else{
                InviteRuleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteRuleTableViewCell" owner:self options:nil].firstObject;
                [self configCell:cell IndexPath:indexPath];
                return cell;
            }

        }
    }
}

-(void)configCell:(InviteRuleTableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    [cell bingdingViewModel];
}

#pragma mark - InviteSendDelegate

-(void)shareInvite:(id)sender{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType];
        
    }];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ShareInviteTitle descr:nil thumImage:[UIImage imageNamed:@"GroupCourseShare"]];
    
    shareObject.webpageUrl =[NSString stringWithFormat:@"http://apphtml.ings.org.cn/inviteFriend/html/getRedBag.html?userId=%@",[UserInfo sharedUserInfo].userID];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


#pragma mark - InvitePeopleAndRuleDelegate

-(void)changeSeg:(NSInteger)segInedx{
    currentSegIndex = segInedx;
    if (segInedx==0) {
        [self getUserRedBagRequest];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - NetWorkrequest

-(void)getUserRedBagRequest{
    [[RedBagService sharedRedBagService] getUserRedBagInfoWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        inviteResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
