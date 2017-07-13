//
//  MainViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainViewController.h"
#import "MainCycleTableViewCell.h"
#import "MainRollingTableViewCell.h"
#import "MainServiceTableViewCell.h"
#import "MainActivityTableViewCell.h"
#import "MainPreferedTableViewCell.h"
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKMiddleAligning.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) UIButton* rightButton;
@property (nonatomic,strong) UIButton* leftButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self changeNavTitleView];
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

- (void)changeNavTitleView{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [_leftButton setTitle:@"无锡" forState:0];
    [_leftButton setImage:V_IMAGE(@"map") forState:0];
    [_leftButton jk_setImagePosition:2 spacing:0];
    
    NSString *content = _leftButton.titleLabel.text;
    UIFont *font = _leftButton.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, 44.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    if (buttonSize.width < 44 ) {
        [_leftButton setFrame:CGRectMake(0, 0, 44, 44)];
    }else if (buttonSize.width  > 50 ){
        [_leftButton setFrame:CGRectMake(0, 0, 50, 44)];
    }else{
        [_leftButton setFrame:CGRectMake(0, 0, buttonSize.width, 44)];
    }

    [_leftButton setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-88, 44)];
    UIImage* clearImg = [MainViewController imageWithColor:[UIColor clearColor] andHeight:44.0f];
    [_searchBar setBackgroundImage:clearImg];
    _searchBar.placeholder = @"请输入机构、学校、课程名称 ";
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightButton setImage:V_IMAGE(@"email") forState:0];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;

    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftItem];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightItem];
    
    self.navigationItem.titleView = _searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MainCycleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainCycleTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 1){
        MainRollingTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainRollingTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 2){
        MainServiceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainServiceTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 5){
        MainPreferedTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainPreferedTableViewCell" owner:self options:nil].firstObject;
        cell.atitleView.image = V_IMAGE(@"校谱优选");
        return cell;
    }else{
        MainActivityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainActivityTableViewCell" owner:self options:nil].firstObject;
        if (indexPath.section == 3) {
            cell.atitleImage.image = V_IMAGE(@"大额");
            cell.acontentImage.image = V_IMAGE(@"大额补贴");
        }else{
            cell.atitleImage.image = V_IMAGE(@"活动");
            cell.acontentImage.image = V_IMAGE(@"活动专区");
        }

        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (Main_Screen_Width/750)*452;
    }else if (indexPath.section == 1){
        return 44;
    }else if (indexPath.section == 2){
        return ((Main_Screen_Width-20)/2 *216)/342 +10;
    }else if (indexPath.section == 5){
        return (Main_Screen_Width-14)/3+30+(Main_Screen_Width/320)*10;
    }else {
        if (indexPath.section == 3) {
           return ((Main_Screen_Width-16)/1473)*540+30+ (Main_Screen_Width/320)*10;
        }else{
            return ((Main_Screen_Width-16)/1920)*648+30+ (Main_Screen_Width/320)*10;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)leftItemAction:(id)sender{
    
}

- (void)rightItemAction:(id)sender{

}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"MainSearch" sender:self];
}
@end
