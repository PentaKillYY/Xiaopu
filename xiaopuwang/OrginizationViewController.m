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
@interface OrginizationViewController ()<UISearchBarDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray* orgDistrictAry;
    NSArray* orgTypeAry;
    NSArray* orgSortAry;
    NSArray* orgDistanceFilterAry;
    NSArray* orgTypeDetailAry;
    
    NSInteger currentPage;
    NSInteger size;
    
    DataItemArray* orgListArray;
    
    NSString* selectCourseType;
    NSString* selectCourseKind;
    NSString* selectArea;
}

@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) IBOutlet UITableView* tableView;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@end

@implementation OrginizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    size = 10;
    orgListArray = [DataItemArray new];
    
    [self addNavTitleView];
    
    [self loadFilterSortData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrginizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage = 0;
        [self getCourseList];
    }];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage +=1;
        [self getCourseList];

    }];
    
    [self.tableView.mj_header beginRefreshing];
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
        return orgListArray.size;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
      OrginizationBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrginizationBannerTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else{
    
        OrginizationTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrginizationTableViewCell" owner:self options:nil].firstObject;
        DataItem* item = [orgListArray getItem:indexPath.row];
        [cell bingdingViewModel:item] ;
        [self configCell:cell indexpath:indexPath];
        return cell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        // 添加下拉菜单
        DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 181) andHeight:50 andWidth:Main_Screen_Width];
        menu.delegate = self;
        menu.dataSource = self;
        _menu = menu;
        
        _menu.menuWidth = Main_Screen_Width;
//        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        [menu selectDefalutIndexPath];
        
        return menu;

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

        return [tableView fd_heightForCellWithIdentifier:@"OrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            
            [self configCell:cell indexpath:indexPath];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"OrginizationDetail" sender:self];
}


- (void)configCell:(OrginizationTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {
    
    [cell.orgClassView removeAllTags];
    
    cell.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-103;
    cell.orgClassView.singleLine = NO;
    cell.orgClassView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.orgClassView.interitemSpacing = 5;
    cell.orgClassView.lineSpacing = 5;
    //Add Tags
    [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C", @"C", @"PHP"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [[SKTag alloc] initWithText:text];
        
        tag.textColor = [UIColor grayColor];
        tag.cornerRadius = 3;
        tag.fontSize = 12;
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 0.5;
       tag.padding = UIEdgeInsetsMake(3, 6, 3, 6);
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
            return arc4random()%10;
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
            return @"英语";
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row ==1){
        
        }else{
            selectArea = orgDistrictAry[indexPath.row];
        }
    }else if (indexPath.column == 1){
        if (indexPath.row == 0) {
            
        }else{
            selectCourseType = orgTypeAry[indexPath.row];
        }
    }else{
        
    }
 //   [self getCourseList];
    
}

-(void)getCourseList{
    NSDictionary* parameters = @{@"Org_Application_Id":@"",@"CourseName":@"",@"CourseType":@"",@"CourseKind":@"",@"City":@"",@"Field":@"",@"CourseClassCharacteristic":@"",@"CourseClassType":@"",@"OrderType":@(0)};
    
    [[OrginizationService sharedOrginizationService] postGetOrginfoWithPage:currentPage Size:size Parameters:parameters onCompletion:^(id json) {
        DataResult* result = json;
        
        [orgListArray append:[result.detailinfo getDataItemArray:@"orglist"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        if (currentPage* size < [result.detailinfo getInt:@"TotalCount"]) {
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } onFailure:^(id json) {
        
    }];
}

@end
