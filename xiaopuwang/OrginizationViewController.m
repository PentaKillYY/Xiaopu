//
//  OrginizationViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationViewController.h"
#import "OrginizationTableViewCell.h"

#import "DOPDropDownMenu.h"
#import "OrginizationBannerTableViewCell.h"

#import "OrginizationService.h"

@interface OrginizationViewController ()<UISearchBarDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource,BannerDelegate>
{
    NSArray* orgDistrictAry;
    NSArray* orgTypeAry;
    NSArray* orgSortAry;
    NSArray* orgDistanceFilterAry;
    NSArray* orgTypeDetailAry;
    
    NSInteger currentPage;
    NSInteger size;
    NSInteger totalCount;
    
    DataItemArray* orgListArray;
    
    NSString* selectCourseType;
    NSString* selectCourseKind;
    NSString* selectArea;
    
    NSMutableDictionary* tagDic;
    
    NSString* orgTypeName;
    NSString* orgGroupName;
    
    DataResult* courseTypeResult;
//    DataResult* groupTypeResult;
    
    DataResult* courseGroupTypeResult;
    
//    NSMutableDictionary* groupDic;
    
    NSInteger selectIndex;
    
    NSInteger selectColumn;
    NSInteger selectRow;
    BOOL needRefresh;
}

@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) DOPDropDownMenu *menu;

@property (nonatomic,strong) NSMutableDictionary *dataSource;

@end

@implementation OrginizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    size = 10;
    currentPage = 1;
    orgListArray = [DataItemArray new];
    
    tagDic = [[NSMutableDictionary alloc] init];
    
    [self setUpSearchFilter];
    
    
    [self addNavTitleView];
    
    [self loadFilterSortData];
    
    
    [self getCourseList];
    [self getCourseTypeAndGroupRequest];
    [self getCourseTypeList];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrginizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoSearchDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoSearchDataTableViewCell"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage = 1;
        [orgListArray clear];
        [tagDic removeAllObjects];
        [self getCourseList];
    }];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage +=1;
        
        [self getCourseList];

    }];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)setUpSearchFilter{
    if (self.orgType.length) {
       orgTypeName =self.orgType;
    }else{
       orgTypeName = @"";
    }
    
    if (self.orgKind.length) {
        orgGroupName = self.orgKind;
    }else{
        orgGroupName = @"";
    }
    
    selectArea = @"";
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
    if([segue.identifier isEqualToString:@"OrginizationDetail"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [orgListArray getItem:selectIndex];
        [theSegue setValue:[item getString:@"Organization_Application_ID"] forKey:@"orgID"];
    }
}


-(void)loadFilterSortData{
    orgDistrictAry = OrginizationDistrictFilter;
    orgTypeAry = OrginizationTypeFilter;
    orgSortAry = OrginizationSort;
    orgDistanceFilterAry = OrgDistanceFilter;
}

- (void)addNavTitleView{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-20, 44)];
    UIImage* clearImg = [OrginizationViewController imageWithColor:[UIColor clearColor] andHeight:44.0f];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        if (orgListArray.size) {
            return orgListArray.size;
        }else{
            return 1;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
      OrginizationBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrginizationBannerTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else{
        if (orgListArray.size) {
            OrginizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrgCell" forIndexPath:indexPath];
            
            [self configCell:cell indexpath:indexPath];
            
            return cell;
        }else{
            NoSearchDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoSearchDataTableViewCell" forIndexPath:indexPath];
            
            return cell;
        }
        
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        
        if (!_menu || needRefresh) {
            // 添加下拉菜单
            DOPDropDownMenu*menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 181) andHeight:50 andWidth:Main_Screen_Width];
            menu.delegate = self;
            menu.dataSource = self;
            _menu = menu;
            
            _menu.menuWidth = Main_Screen_Width;
            CATextLayer* title = [[CATextLayer alloc] init];
            title.string = @[orgDistrictAry,orgTypeAry,orgSortAry][selectColumn][selectRow];
        }

        return _menu;

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


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180.0;
    }else{
        if (orgListArray.size) {
            return  [tableView fd_heightForCellWithIdentifier:@"OrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configCell:cell indexpath:indexPath];
            }];
        }else{
            return 240;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectIndex = indexPath.row;
    [self performSegueWithIdentifier:@"OrginizationDetail" sender:self];
}

- (void)configCell:(OrginizationTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {
    
    DataItem* item = [orgListArray getItem:indexpath.row];
    
    [cell bingdingViewModel:item] ;
    
    [cell.orgClassView removeAllTags];
    
    cell.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-121;
    
    cell.orgClassView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.orgClassView.lineSpacing = 5;
    cell.orgClassView.interitemSpacing = 5;
    cell.orgClassView.singleLine = NO;
    
    
    DataItemArray* itemArray =   [[DataItemArray alloc] init];
    [itemArray append:[tagDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexpath.row]]];
    NSArray* array =  [NSArray arrayWithArray:[itemArray toArray]] ;
    [array enumerateObjectsUsingBlock:^(DataItem* item, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SKTag *tag = [[SKTag alloc] initWithText:[item getString:@"CourseClassType"]];
        
        tag.font = [UIFont systemFontOfSize:12];
        tag.textColor = [UIColor lightGrayColor];
        tag.bgColor =[UIColor whiteColor];
        tag.borderColor = [UIColor lightGrayColor];
        tag.borderWidth = 1.0;
        tag.cornerRadius = 3;
        tag.enable = YES;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.orgClassView addTag:tag];
    }];
}

#pragma mark - KeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"OrginizationSearch" sender:self];
}

#pragma mark - DropDownMenuDatasource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return orgDistrictAry.count;
    }else if (column == 1){
        return orgTypeAry.count;
    }else {
        return orgSortAry.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return orgDistrictAry[indexPath.row];
    } else if (indexPath.column == 1){
        return orgTypeAry[indexPath.row];
    } else {
        return orgSortAry[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 1) {
            return orgDistanceFilterAry.count;
        }else {
            return 0;
        }
    } else if (column == 1) {
        if (row == 0) {
            return 0;
        } else {
            NSString* key = orgTypeAry[row];
            
            return  [[courseGroupTypeResult.detailinfo getDataItem:@"property_ConfigList"] getDataItemArray:key].size;
        };
        
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 1) {
            return orgDistanceFilterAry[indexPath.item];
        }  else {
            return 0;
        }
    } else if (indexPath.column == 1) {
        if (indexPath.row == 0) {
            return 0;
        } else {
            NSString* key = orgTypeAry[indexPath.row];
           return  [[[[courseGroupTypeResult.detailinfo getDataItem:@"property_ConfigList"] getDataItemArray:key] getItem:indexPath.item] getString:@"Text"];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath{
    selectColumn = indexPath.column;
    selectRow = indexPath.row;
    
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
           selectArea = @"";
            needRefresh = NO;
             [self.tableView.mj_header beginRefreshing];
        }else if (indexPath.row ==1){
            
        }else{
            selectArea = orgDistrictAry[indexPath.row];
            needRefresh = NO;
             [self.tableView.mj_header beginRefreshing];
        }
       
        
    }else if (indexPath.column == 1){
        if (indexPath.row == 0) {
            if (self.orgType.length) {
                orgTypeName = self.orgType;
            }else{
                orgTypeName = @"";
            }
            
            if (self.orgKind.length) {
                orgGroupName = self.orgKind;
            }else{
                orgGroupName = @"";
            }
            needRefresh = NO;
            [self.tableView.mj_header beginRefreshing];
        }else{
            orgTypeName = orgTypeAry[indexPath.row];
            
            if (indexPath.item == 0 || indexPath.item > 0) {
                NSString* key = orgTypeAry[indexPath.row];
                
                orgGroupName = [[[[courseGroupTypeResult.detailinfo getDataItem:@"property_ConfigList"] getDataItemArray:key] getItem:indexPath.item] getString:@"Text"];
                needRefresh = NO;
                [self.tableView.mj_header beginRefreshing];
            }
        }
    }else{
        needRefresh = NO;
        [self.tableView.mj_header beginRefreshing];
    }
    
}

#pragma mark - NetWorkRequest
-(void)getCourseList{
    NSString* orgname;
    
    if (self.searchName.length>0) {
        orgname = self.searchName;
    }else{
        orgname = @"";
    }
    
    
    NSDictionary* parameters = @{@"Org_Application_Id":@"",@"CourseName":orgname,@"CourseType":orgTypeName,@"CourseKind":orgGroupName,@"City":@"",@"Field":selectArea,@"CourseClassCharacteristic":@"",@"CourseClassType":@"",@"OrderType":@(0)};
    
    [[OrginizationService sharedOrginizationService] postGetOrginfoWithPage:currentPage Size:size Parameters:parameters onCompletion:^(id json) {
        
    
        DataResult* result = json;
        
        [orgListArray append:[result.detailinfo getDataItemArray:@"orglist"]];
        
        totalCount =[result.detailinfo getInt:@"TotalCount"];
        
        int curretnIndex = (int)orgListArray.size - (int)[result.detailinfo getDataItemArray:@"orglist"].size;
        if (totalCount > 0 ) {
            
            for ( int i=curretnIndex ; i< orgListArray.size ; i++) {
                [self getCourseClassTypeWithindex:i];
                
            }
        }else{
            self.tableView.mj_footer.hidden = YES;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.tableView.mj_header endRefreshing];
            
            if (currentPage* size < totalCount) {
                [self.tableView.mj_footer endRefreshing];
                
            }else{
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
        
        
        
        
    } onFailure:^(id json) {
        
    }];
}

- (void)getCourseClassTypeWithindex:(NSInteger)index {
    DataItem* item = [orgListArray getItem:index];
    
    [[OrginizationService sharedOrginizationService] getCourseClassTypeWithParameters:@{@"orgId":[item getString:@"Organization_Application_ID"]} onCompletion:^(id json) {
                DataResult* result = json;
        
        
        [tagDic setObject:result.items forKey:[NSString stringWithFormat:@"%ld",(long)index]];
        
        if ([tagDic allKeys].count == orgListArray.size) {

            [self.tableView reloadData];
        }
        
        
        [self.tableView.mj_header endRefreshing];
        
        if (currentPage* size < totalCount) {
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.tableView.mj_footer.hidden = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        

    } onFailure:^(id json) {
        
    }];
}


- (NSMutableDictionary *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableDictionary alloc] initWithDictionary:tagDic];
    }
    return _dataSource;
}


-(void)getCourseTypeList{
    [[OrginizationService sharedOrginizationService] getCoursetypeParameters:@{@"courseType":@"CourseType"} onCompletion:^(id json) {
        courseTypeResult = json;
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseTypeAndGroupRequest{
    [[OrginizationService sharedOrginizationService] getCourseTypeBuGroupWithParameters:@{@"courseType":@"CourseType"} onCompletion:^(id json) {
        courseGroupTypeResult = json;
    } onFailure:^(id json) {
        
    }];
}

#pragma mark - BannerDelegate
-(void)bannerBubttonClicked:(id)sender{
    UIButton* button = (UIButton*)sender;
    
    if (button.tag == 2) {
        orgTypeName = [[courseTypeResult.items getItem:3] getString:@"Text"];
    }else if (button.tag == 3){
        orgTypeName = [[courseTypeResult.items getItem:2] getString:@"Text"];
    }else{
        orgTypeName = [[courseTypeResult.items getItem:button.tag] getString:@"Text"];
    }
    orgGroupName = @"";
    selectArea = @"";
    needRefresh = YES;
    [self.tableView.mj_header beginRefreshing];
}


@end
