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

@interface SchoolViewController ()<UISearchBarDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray* countryAry;
    NSArray* provinceAry;
    NSArray* cityAry;
    
}

@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,weak)IBOutlet UITableView* tableView;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavTitleView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolTableViewCell"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadNewData];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self loadDropMenuData];
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

- (void)loadNewData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    });
    
}

- (void)loadDropMenuData{
    countryAry = @[@"不限", @"中国",@"美国",@"加拿大",@"澳大利亚"];
    provinceAry = @[@"全部", @"江苏", @"浙江",@"广东",@"福建",@"新疆"];
    cityAry = @[@"全部", @"南京", @"无锡",@"苏州",@"盐城",@"常州",@"徐州"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 10;
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
        // 添加下拉菜单
        DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 181) andHeight:50 andWidth:Main_Screen_Width];
        menu.delegate = self;
        menu.dataSource = self;
        _menu = menu;
        _menu.menuWidth = Main_Screen_Width;
        //        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu.type = 1;
        [menu selectDefalutIndexPath];
        return menu;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SchoolBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolBannerTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else{
        SchoolTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolTableViewCell" owner:self options:nil].firstObject;
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
        }];

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        return countryAry.count;
    }
    return 1;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
         return countryAry[indexPath.row];
    }
    return @"类别";
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        NSInteger count =provinceAry.count;
        return 3;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return provinceAry[indexPath.item];
    }
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfUnitsInItem:(NSInteger)item row:(NSInteger)row column:(NSInteger)column {
    if (column == 0) {
        NSInteger count =cityAry.count;
        return 3;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForUnitsInItemAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return cityAry[indexPath.unit];
    }
    return nil;
}
@end
