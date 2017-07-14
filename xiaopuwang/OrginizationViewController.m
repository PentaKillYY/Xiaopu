//
//  OrginizationViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationViewController.h"
#import "OrginizationTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "OrgCollectionCell.h"
#import "DOPDropDownMenu.h"

@interface OrginizationViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
{
    NSArray* orgDistrictAry;
    NSArray* orgTypeAry;
    NSArray* orgSortAry;
    NSArray* orgDistanceFilterAry;
    NSArray* orgTypeDetailAry;
    
}
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) IBOutlet UITableView* tableView;
@property (nonatomic,strong) IBOutlet UICollectionView* collctionView;
@property (nonatomic,strong) IBOutlet UILabel* topSep;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@end

@implementation OrginizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavTitleView];
    
    [self loadFilterSortData];
    self.topSep.backgroundColor = [UIColor colorWithRed:219.0/255 green:224.0/255 blue:228.0/255 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrginizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgCell"];
    
    [self.collctionView registerNib:[UINib nibWithNibName:@"OrgCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"OrgCollectionCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadNewData];
    }];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadNewData];

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
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 181) andHeight:50];
    menu.delegate = self;
    menu.dataSource = self;
    
    [self.view addSubview:menu];
    _menu = menu;
    
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];

}

- (void)loadNewData{
    sleep(2);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrginizationTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrginizationTableViewCell" owner:self options:nil].firstObject;
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"OrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDataSource
// 指定Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

// 指定section中的collectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

// 配置section中的collectionViewCell的显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrgCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrgCollectionCell" forIndexPath:indexPath];
    cell.orgtitle.text = OrginizationTypeAry[indexPath.section*4+indexPath.row];
    cell.orgimg.image = V_IMAGE(OrginizationImageAry[indexPath.section*4+indexPath.row]);
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Main_Screen_Width-10)/4, 86);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
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

@end
