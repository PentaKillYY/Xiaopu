//
//  SchoolViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolViewController.h"
#import "SchoolTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DOPDropDownMenu.h"
#import "SchoolBannerTableViewCell.h"
#import "SchoolService.h"

@interface SchoolViewController ()<UISearchBarDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource,BannerDelegate>
{
    NSInteger currentIndex;
    NSInteger totalCount;
    
    DataItemArray* schoolListArray;
    
    NSString* schoolCountry;
    NSString* schoolProvince;
    NSString* schoolCity;
    
    DataResult* countryResult;
    DataResult* provinceResult;
    DataResult* cityResult;
    DataResult* typeResult;
    DataResult* natureResult;
    
    NSString* selectCountryId;
    NSString* selectProvinceId;
    
    NSString* schoolType;
    NSString* schoolNature;
    
    NSInteger currentSelectRow;
}

@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,weak)IBOutlet UITableView* tableView;
@property (nonatomic, strong) DOPDropDownMenu *menu;
@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    schoolListArray = [DataItemArray new];
    
    [self addNavTitleView];
    [self loadFilter];
    
    [self getSchoolCountryListRequest];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolTableViewCell"];
    
    
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
    
//    [self loadDropMenuData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SchoolToDetail"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        
         DataItem* item =[schoolListArray getItem:currentSelectRow];
        
        [theSegue setValue:[item getString:@"School_BasicInfo_ID"] forKey:@"basicID"];
        [theSegue setValue:[item getString:@"School_Application_ID"] forKey:@"applicationID"];
    }
}

- (void)addNavTitleView{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-20, 44)];
    UIImage* clearImg = [SchoolViewController imageWithColor:[UIColor clearColor] andHeight:44.0f];
    [_searchBar setBackgroundImage:clearImg];
    _searchBar.placeholder = @"请输入机构、学校、课程名称 ";
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.titleView = _searchBar;
}

+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)loadFilter{
    if (self.schoolCountryName.length) {
       schoolCountry = self.schoolCountryName;
    }else{
        schoolCountry = @"";
    }
    
    if (self.schoolTypeName.length) {
        schoolType = self.schoolTypeName;
    }else{
        schoolType = @"";
    }
    
    schoolProvince = @"";
    schoolCity = @"";
    
    schoolNature = @"";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return schoolListArray.size;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SchoolBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolBannerTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else{
        SchoolTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolTableViewCell" owner:self options:nil].firstObject;
        [self configCell:cell indexpath:indexPath];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"SchoolTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configCell:cell indexpath:indexPath];
        }];

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentSelectRow = indexPath.row;
    
    [self performSegueWithIdentifier:@"SchoolToDetail" sender:self];
}

- (void)configCell:(SchoolTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {

    [cell.orgClassView removeAllTags];
    DataItem* item =[schoolListArray getItem:indexpath.row];

    [cell bingdingViewModel:item];
    
    [@[[item getString:@"CollegeNatureText"], [item getString:@"CollegeTypeText"]] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
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

#pragma mark - KeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"SchoolSearch" sender:self];
}

#pragma mark - DropDownMenuDatasource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        if (countryResult) {
            return countryResult.items.size+1;
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
            if (countryResult) {
                return [[countryResult.items getItem:indexPath.row-1] getString:@"text"];
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
            if (provinceResult) {
                return provinceResult.items.size+1;
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
            if (provinceResult) {
                return [[provinceResult.items getItem:indexPath.item-1] getString:@"text"];
            }else{
                return nil;
            }
            
        }
    }else{
        return @"";
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfUnitsInItem:(NSInteger)item row:(NSInteger)row column:(NSInteger)column {
    if (column == 0) {
        if (cityResult) {
            return cityResult.items.size+1;
        }else{
            return 1;
        }
    }
    return 1;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForUnitsInItemAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.unit == 0) {
            return @"不限";
        }else{
            if (cityResult) {
                return [[cityResult.items getItem:indexPath.unit-1] getString:@"text"];

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
        [self getSchoolCountryListRequest];
        
        if (indexPath.row == 0) {
            
            if (self.schoolCountryName.length) {
                schoolCountry = self.schoolCountryName;
            }else{
                schoolCountry = @"";
            }
            
            [self.tableView.mj_header beginRefreshing];
        }else if (indexPath.row == 1){
            [self.menu reloadData];
            [self pushToChinaSChool];
        }else{
            selectCountryId = [[countryResult.items getItem:indexPath.row-1] getString:@"value"];
            schoolCountry = [[countryResult.items getItem:indexPath.row-1] getString:@"text"];
            
            [self getSchoolTypeRequest];
            [self getSchoolNatureRequest];
            
            
            [self getSchoolProvinceListRequest];
            
            if (indexPath.item == 0) {
                schoolProvince = @"";
                [self.tableView.mj_header beginRefreshing];
            }else if(indexPath.item >0){
                
                selectProvinceId = [[provinceResult.items getItem:indexPath.item -1] getString:@"value"];
                schoolProvince = [[provinceResult.items getItem:indexPath.item -1] getString:@"text"];
                
                [self getSchoolCityLIstRequest];
                
                if (indexPath.unit == 0) {
                    schoolCity = @"";
                    [self.tableView.mj_header beginRefreshing];
                }else if (indexPath.unit >0){
                    schoolCity = [[cityResult.items getItem:indexPath.unit -1] getString:@"text"];
                    [self.tableView.mj_header beginRefreshing];
                }else{
                
                }
                
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
        
            schoolType = [[typeResult.items getItem:[[_menu.selectTypeArray firstObject] intValue]-1] getString:@"value"];
        }
    }
    
    if(_menu.selectNatureArray){
        if ([[_menu.selectNatureArray firstObject] intValue] == 0) {
            schoolNature = @"";
        }else{
        
            schoolNature = [[natureResult.items getItem:[[_menu.selectNatureArray firstObject] intValue]-1] getString:@"value"];
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
    
    [[SchoolService sharedSchoolService] getSchoolListWithPage:currentIndex Size:10 Parameters:@{@"ChineseName":schoolName,@"Country":schoolCountry,@"Province":schoolProvince,@"City":schoolCity,@"CollegeNature":schoolNature,@"CollegeType":schoolType,@"TestScore":@"",@"TuitionBudget":@"",@"MinimumAverage":@""} onCompletion:^(id json) {
                
        DataResult* result = json;
        
        [schoolListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        totalCount = [result.detailinfo getInt:@"TotalCount"];
        
        [self.tableView.mj_header endRefreshing];
        
        
        if (currentIndex*10 < totalCount) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolCountryListRequest{
    [[SchoolService sharedSchoolService] getSchoolCountryListonCompletion:^(id json) {
        countryResult = json;
            
        self.menu.dataSource = self;
        [self.menu reloadFirstTable];

    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolProvinceListRequest{
        [[SchoolService sharedSchoolService] getSchoolProvinceListWithParameters:@{@"countryId":selectCountryId} onCompletion:^(id json) {
            provinceResult = json;
            
            self.menu.dataSource = self;
            [self.menu reloadSecondTable];
            
        } onFailure:^(id json) {
            
        }];

}


-(void)getSchoolCityLIstRequest{
    [[SchoolService sharedSchoolService] getSchoolCityListWithParameters:@{@"provinceId":selectProvinceId} onCompletion:^(id json) {
        cityResult= json;
        self.menu.dataSource = self;
        [self.menu reloadThirdTable];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolTypeRequest{
    schoolType = @"";
    [[SchoolService sharedSchoolService] getSchoolTypeListWithParameters:@{@"countryName":schoolCountry} onCompletion:^(id json) {
        typeResult = json;
        
        NSMutableArray* typeName = [[NSMutableArray alloc] init];
        [typeName addObject:@"不限"];
        for (int i = 0; i<typeResult.items.size; i++) {
            DataItem* item = [typeResult.items getItem:i];
            [typeName addObject:[item getString:@"text"]];
        }
        
        _menu.typeArray = [NSArray arrayWithArray:typeName];
        [_menu reloadTagTable];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolNatureRequest{
    schoolNature = @"";
    [[SchoolService sharedSchoolService] getSchoolNatureListWithParameters:@{@"countryName":schoolCountry} onCompletion:^(id json) {
        natureResult= json;
        
        NSMutableArray* natureName = [[NSMutableArray alloc] init];
        [natureName addObject:@"不限"];
        for (int i =0; i<natureResult.items.size; i++) {
            DataItem* item = [natureResult.items getItem:i];
            [natureName addObject:[item getString:@"text"]];
        }
        
        _menu.natureArray = [NSArray arrayWithArray:natureName];
         [_menu reloadTagTable];
        
    } onFailure:^(id json) {
        
    }];
}

#pragma mark - BannerDelegate
-(void)bannerBubttonClicked:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag != 7 && button.tag !=0 ) {
        if (button.tag == 1) {
            schoolCountry = [[countryResult.items getItem:4] getString:@"text"];
        }else if (button.tag == 4){
            schoolCountry = [[countryResult.items getItem:5] getString:@"text"];
        }else if (button.tag == 5){
            schoolCountry = [[countryResult.items getItem:6] getString:@"text"];
        }else if (button.tag == 6){
            schoolCountry = [[countryResult.items getItem:1] getString:@"text"];
        }else{
            schoolCountry = [[countryResult.items getItem:button.tag] getString:@"text"];
        }
        [self getSchoolTypeRequest];
        [self getSchoolNatureRequest];
        
        
        [self.tableView.mj_header beginRefreshing];
    }else if (button.tag == 0){
        [self pushToChinaSChool];
    }
}

-(void)pushToChinaSChool{
    [self performSegueWithIdentifier:@"SchoolToChina" sender:self];
}
@end
