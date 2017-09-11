//
//  MyOrderViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyOrderViewController.h"
#import "SGTopTitleView.h"
#import "AllOrderViewController.h"
#import "OrderAppointViewController.h"
#import "OrderPayViewController.h"
#import "OrderEvaluateViewController.h"

@interface MyOrderViewController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
{
    NSInteger currentVCIndex;
}
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部订单";
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    

    self.titles = @[ @"已咨询", @"下单待支付", @"已付待评价",@"全部"];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    //    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.titleAndIndicatorColor = MAINCOLOR;
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];

    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 64+44, Main_Screen_Width,Main_Screen_Height-64-44);
    _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    OrderAppointViewController *oneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderAppoint"];
    [self.mainScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    
    oneVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64-44);
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * Main_Screen_Width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    currentVCIndex = index;
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * Main_Screen_Width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, Main_Screen_Width, Main_Screen_Height-44-64);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    
    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    // 3.让选中的标题居中
    //    [self.topTitleView scrollTitleLabelSelectededCenter:selLabel];
    currentVCIndex = index;
}

// 添加所有子控制器
- (void)setupChildViewController {

    OrderAppointViewController *oneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderAppoint"];
    [self addChildViewController:oneVC];

    OrderPayViewController *twoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderPay"];
    [self addChildViewController:twoVC];

    OrderEvaluateViewController *threeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderEvaluate"];
    [self addChildViewController:threeVC];
    
    AllOrderViewController *fourVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AllOrder"];
    [self addChildViewController:fourVC];
}

@end
