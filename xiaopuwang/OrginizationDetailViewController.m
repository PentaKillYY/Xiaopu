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

@interface OrginizationDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger currentSegIndex;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet HMSegmentedControl *segmentedControl;
@property(nonatomic,weak)IBOutlet UIButton* followButton;
@property(nonatomic,weak)IBOutlet UIButton* contactButton;

@end

@implementation OrginizationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构详情";
    
    [self setupBottomView];
    [self setupInfoSeg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 1;
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrgInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgInfoTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else if (indexPath.section == 1){
        OrgHouseRateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgHouseRateTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else if (indexPath.section == 2){
        OrgProportionTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgProportionTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else if (indexPath.section == 6){
        OrgMapTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgMapTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else{
        OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
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
@end
