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
#import "SchoolService.h"

@interface ChinaSchoolViewController ()<UITableViewDelegate,UITableViewDataSource,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,ChinaBannerDelegate>{
    NSInteger currentIndex;
    NSInteger totalCount;
    
    DataItemArray* schoolListArray;
    DataResult* provinceResult;
    DataResult* cityResult;

    
    NSString* schoolProvince;
    NSString* schoolCity;
    NSString* schoolType;
    NSString* schoolNature;
    
    NSString* selectProvinceId;
    
    NSInteger currentSelectSchoolIndex;
}
@property (nonatomic, strong) DOPDropDownMenu *menu;
@property (nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation ChinaSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"中国学校";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    schoolListArray = [DataItemArray new];
    
    [self loadFilter];
    [self getSchoolProvinceListRequest];

    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoSearchDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoSearchDataTableViewCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        currentIndex = 1;
        [schoolListArray clear];
        [self getSchoolListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex ++;
        [self getSchoolListRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadFilter{
    if (self.chinaType.length) {
       schoolType = self.chinaType;
    }else{
        schoolType = @"";
    }
    
    
    
    schoolProvince = @"";
    schoolCity = @"";
    
    schoolNature = @"";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ChinaSchoolToDetail"])
    {
        id theSegue = segue.destinationViewController;
        
        DataItem* item =[schoolListArray getItem:currentSelectSchoolIndex];
        
        [theSegue setValue:[item getString:@"Id"] forKey:@"schoolID"];
    }
}


#pragma mark - UItableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (schoolListArray.size) {
            return schoolListArray.size;
        }else{
            return 1;
        }
        
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ChinaSchoolBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ChinaSchoolBannerTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        
        return cell;
    }else{
        if (schoolListArray.size) {
            SchoolTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolTableViewCell" owner:self options:nil].firstObject;
            [self configCell:cell indexpath:indexPath];
            return cell;
        }else{
            NoSearchDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoSearchDataTableViewCell" forIndexPath:indexPath];
            
            return cell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else{
        if (schoolListArray.size) {
            return [tableView fd_heightForCellWithIdentifier:@"SchoolTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // configurations
                [self configCell:cell indexpath:indexPath];
            }];
  
        }else{
            return 240;
        }
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
            _menu.typeArray = ChinaSchoolType;
            _menu.natureArray = ChinaSchoolNature;
            
            [_menu selectDefalutIndexPath];
        }
        return _menu;
        
    }
}

- (void)configCell:(SchoolTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {
    
    [cell.orgClassView removeAllTags];
    DataItem* item =[schoolListArray getItem:indexpath.row];
    
    [cell bingdingViewModel:item];
    
    [@[[item getString:@"CollegeNature"], [item getString:@"CollegeType"]] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = [UIColor grayColor];
        tag.cornerRadius = 3;
        tag.fontSize = 12;
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 0.5;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.orgClassView addTag:tag];
    }];
    cell.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-111;
    
    cell.orgClassView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.orgClassView.interitemSpacing = 5;
    cell.orgClassView.lineSpacing = 5;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentSelectSchoolIndex = indexPath.row;
    [self performSegueWithIdentifier:@"ChinaSchoolToDetail" sender:self];
}

#pragma mark - DropDownMenuDatasource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        if (provinceResult) {
            return provinceResult.items.size+1;
        }else{
            return 1;
        }
        
    }
    return 1;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return @"不限";
        }else{
            if (provinceResult) {
                return [[provinceResult.items getItem:indexPath.row-1] getString:@"text"];
            }else{
                return nil;
            }
        }
    }else{
        return @"类别";
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return 0;
        }else{
            if (cityResult) {
                return cityResult.items.size+1;
            }else{
                return 1;
            }
            
        }
    }
    return 1;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.item == 0) {
            return @"不限";
        }else{
            if (cityResult) {
                return [[cityResult.items getItem:indexPath.item-1] getString:@"text"];
            }else{
                return nil;
            }
            
        }
    }else{
        return @"";
    }
}

#pragma mark - DOPDropDownMenuDelegate

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath{
    if (indexPath.column == 0) {
        [self getSchoolProvinceListRequest];
        
        if (indexPath.row == 0) {
            schoolProvince = @"";
            [self.tableView.mj_header beginRefreshing];
        }else{
            selectProvinceId = [[provinceResult.items getItem:indexPath.row-1] getString:@"value"];
            schoolProvince = [[provinceResult.items getItem:indexPath.row-1] getString:@"text"];
            [self getSchoolCityLIstRequest];
            
            if (indexPath.item == 0) {
                schoolCity = @"";
                [self.tableView.mj_header beginRefreshing];
            }else if(indexPath.item >0){
                schoolCity = [[cityResult.items getItem:indexPath.item -1] getString:@"text"];
                [self.tableView.mj_header beginRefreshing];
            }else{
                
            }
        }
    }
    
}

-(void)resetTag{
    schoolType = @"";
    schoolNature = @"";
    
    [_menu reloadData];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)confirmTag{
    
    if (_menu.selectTypeArray) {
        if ([[_menu.selectTypeArray firstObject] intValue]==0) {
            schoolType = @"";
        }else{
            
            schoolType =  [ChinaSchoolType objectAtIndex:[[_menu.selectTypeArray firstObject] intValue] ] ;
        }
    }
    
    if(_menu.selectNatureArray){
        if ([[_menu.selectNatureArray firstObject] intValue] == 0) {
            schoolNature = @"";
        }else{
            
            schoolNature = [ChinaSchoolNature objectAtIndex:[[_menu.selectNatureArray firstObject] intValue]] ;

        }
    }

    
    [_menu reloadData];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - NetWorkRequest
-(void)getSchoolListRequest{
    NSString* schoolName;
    if (self.searchName.length) {
        schoolName = self.searchName;
    }else{
        schoolName = @"";
    }
    
    [[SchoolService sharedSchoolService] postChinaSchoolListWithPage:currentIndex Size:10 Parameters:@{@"SchoolName":schoolName,@"Province":schoolProvince,@"City":schoolCity,@"CollegeNature":schoolNature,@"CollegeType":schoolType,@"Area":@"",@"X":@(0),@"Y":@(0)} onCompletion:^(id json) {
        DataResult* result = json;
        
        [schoolListArray append:[result.detailinfo getDataItemArray:@"ChinaSchoolList"]];
        
        totalCount = [result.detailinfo getInt:@"TotalCount"];
        
        [self.tableView.mj_header endRefreshing];
        
        
        if (currentIndex*10 < totalCount) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (totalCount) {
            self.tableView.mj_footer.hidden = NO;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }else{
            self.tableView.mj_footer.hidden = YES;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        [self.tableView reloadData];
        
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolProvinceListRequest{
    [[SchoolService sharedSchoolService] getSchoolProvinceListWithParameters:@{@"countryId":@"1"} onCompletion:^(id json) {
        provinceResult = json;
        
        self.menu.dataSource = self;
        [self.menu reloadFirstTable];
        
    } onFailure:^(id json) {
        
    }];
    
}


-(void)getSchoolCityLIstRequest{
    [[SchoolService sharedSchoolService] getSchoolCityListWithParameters:@{@"provinceId":selectProvinceId} onCompletion:^(id json) {
        cityResult= json;
        self.menu.dataSource = self;
        [self.menu reloadSecondTable];
        
    } onFailure:^(id json) {
        
    }];
}


#pragma mark - ChinaBannerDelegate
-(void)bannerBubttonClicked:(id)sender{
    UIButton* button = (UIButton*)sender;
    schoolType = ChinaSchoolType[button.tag+1];
    [self.tableView.mj_header beginRefreshing];
}
@end
