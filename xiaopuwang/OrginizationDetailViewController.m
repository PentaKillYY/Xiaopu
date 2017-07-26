//
//  OrginizationDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationDetailViewController.h"
#import "OrgInfoTableViewCell.h"
#import "OrgHouseRateTableViewCell.h"
#import "OrgProportionTableViewCell.h"
#import "OrgAlbumVideoTableViewCell.h"
#import "OrgMapTableViewCell.h"
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKMiddleAligning.h"
#import "HMSegmentedControl.h"
#import "OrginizationService.h"
#import "StarRatingView.h"

@interface OrginizationDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger currentSegIndex;
    
    DataResult* _detailInfoResult;
    DataResult* _albumRequest;
    DataResult* _videoRequest;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet HMSegmentedControl *segmentedControl;
@property(nonatomic,weak)IBOutlet UIButton* followButton;
@property(nonatomic,weak)IBOutlet UIButton* contactButton;

@property(nonatomic,weak)IBOutlet UIImageView* logoView;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet StarRatingView* ratingView;
@end

@implementation OrginizationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构详情";
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:233.0/255.0 alpha:1.0];
   
    [self setupBottomView];
    [self setupInfoSeg];
    
    [self getOrgDetailInfoRequest];
    [self gerOrgAlbumRequest];
    [self getVideoAlbumRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailToContent"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[_detailInfoResult.detailinfo getString:@"Introduction"] forKey:@"orgContent"];
    }
}


-(void)setupInfoView{
    [self.logoView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",IMAGE_URL,[_detailInfoResult.detailinfo getString:@"Logo"]] ] placeholderImage:nil];
    
    self.orgName.text = [_detailInfoResult.detailinfo getString:@"OrganizationName"];
    
    StarRatingViewConfiguration *conf = [[StarRatingViewConfiguration alloc] init];
    conf.rateEnabled = NO;
    conf.starWidth = 15.0f;
    conf.fullImage = @"fullstar.png";
    conf.halfImage = @"halfstar.png";
    conf.emptyImage = @"emptystar.png";
    
    _ratingView.configuration = conf;
    [_ratingView setStarConfiguration];
    
    [_ratingView setRating:4.5 completion:^{
        NSLog(@"rate done");
    }];

}

-(void)setupBottomView{
    [self.contactButton setBackgroundColor:MAINCOLOR];
    [self.contactButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contactButton.layer setCornerRadius:3.0];
    [self.contactButton.layer setMasksToBounds:YES];
    
    [self.followButton setTitle:@"关注" forState:0];
    [self.followButton setImage:V_IMAGE(@"unfollowed") forState:0];
    [self.followButton setImage:V_IMAGE(@"followed") forState:UIControlStateSelected];
    
    [self.followButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];

    [self.followButton jk_setImagePosition:2 spacing:0];
    [self.followButton jk_middleAlignButtonWithSpacing:0];
}

-(void)setupInfoSeg{
    self.segmentedControl.sectionTitles = @[@"简介", @"课程", @"老师", @"学生",@"评价"];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    self.segmentedControl.selectionIndicatorColor = MAINCOLOR;
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    [self.segmentedControl setSelectedSegmentIndex:currentSegIndex];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 2 || section == 6) {
        if (_detailInfoResult) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 3){
        if (_albumRequest.items.size) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 4){
        DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
        NSInteger number = 0;
        for (int i = 0; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"VideoType"] == 0) {
                number++;
            }
        }
        
        if (number > 0) {
            return 1;
        }else{
            return 0;
        }
    }else{
        
        
        DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
        NSInteger number = 0;
        for (int i = 0; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"VideoType"] == 1) {
                number++;
            }
        }
        
        if (number > 0) {
            return 1;
        }else{
            return 0;
        }

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 6) {
        return 5;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1){
        return 218;
    }else if (indexPath.section == 2){
        return 220;
    }else if (indexPath.section == 6){
        return 230.0;
    }else{
        return (Main_Screen_Width-14)/3+43;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrgInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgInfoTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section == 1){
        OrgHouseRateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgHouseRateTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section == 2){
        OrgProportionTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgProportionTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section == 6){
        OrgMapTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgMapTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else{
        OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
        if (indexPath.section == 3) {
            cell.orgTitle.text = @"相册";
            [cell setupUI:_albumRequest Type:0];
        }else if (indexPath.section == 4){
            cell.orgTitle.text = @"学校视频";
            [cell setupUI:_videoRequest Type:1];
        }else{
            cell.orgTitle.text = @"在线试听";
            [cell setupUI:_videoRequest Type:2];
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"DetailToContent" sender:self];
    }
}

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    
    [self.tableView reloadData];
}

-(IBAction)followOrginization:(id)sender{
    UIButton* currentButton = (UIButton*)sender;
    currentButton.selected = !currentButton.selected;
}

#pragma mark - NetWorkRequest

-(void)getOrgDetailInfoRequest{
    [[OrginizationService sharedOrginizationService] getOrgDetailInfoParameters:@{@"orgApplication_ID":self.orgID} onCompletion:^(id json) {
        _detailInfoResult = json;
        
        [self setupInfoView];
        
        [self.tableView reloadData];
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)gerOrgAlbumRequest{
    [[OrginizationService sharedOrginizationService] getAlbumWithParameters:@{@"orgId":self.orgID} onCompletion:^(id json) {
        _albumRequest = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getVideoAlbumRequest{
    [[OrginizationService sharedOrginizationService] getVideoWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(20)} onCompletion:^(id json) {
        _videoRequest = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
