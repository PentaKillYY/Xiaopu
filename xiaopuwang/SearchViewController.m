//
//  SearchViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/13.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SearchViewController.h"
#import "PopViewController.h"
#import "OrginizationService.h"
#import "SchoolService.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()<UIPopoverPresentationControllerDelegate,PopSelectDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    PopViewController   *_popVC;
    UIButton* _selectButton;
    UIBarButtonItem* _selectItem;
    UIImageView * _arrowMark;
    NSInteger searchfilterIndex;
    DataResult* orgResult;
    DataResult* schoolResult;
    DataResult* chinaSchoolResult;
    DataResult* courseRequest;
    NSInteger selectIndex;
}
@property (nonatomic,strong) UIButton* rightButton;
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,strong)UITextField* textfield;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavTitleView];
    
    orgResult = [DataResult new];
    schoolResult = [DataResult new];
    chinaSchoolResult = [DataResult new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavTitleView{
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, Main_Screen_Width, 28)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.clipsToBounds = NO;
    [titleView.layer setCornerRadius:3.0];

    
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setFrame:CGRectMake(0, 0, 65, 28)];
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _selectButton.titleLabel.font    = [UIFont systemFontOfSize:13.f];
    _selectButton.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _selectButton.selected           = NO;
    _selectButton.backgroundColor    = [UIColor whiteColor];
    _selectItem = [[UIBarButtonItem alloc] initWithCustomView:_selectButton];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(_selectButton.frame.size.width - 15, 0, 9, 9)];
    _arrowMark.center = CGPointMake(_selectButton.frame.size.width, _selectButton.frame.size.height/2);
    _arrowMark.image  = [UIImage imageNamed:@"dropdownMenu_cornerIcon.png"];
    [_selectButton addSubview:_arrowMark];

    
    [titleView addSubview:_selectButton];
    
    _textfield =[[UITextField alloc] initWithFrame:CGRectMake(78, 0, Main_Screen_Width, 28)];
    _textfield.borderStyle= UITextBorderStyleNone;
    _textfield.tintColor = MAINCOLOR;
    _textfield.font = [UIFont systemFontOfSize:13];
    [titleView addSubview:_textfield];
    
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 10;
    
    self.navigationItem.rightBarButtonItems = @[rightItem,negativeSpacer];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"SearchToOrg"])    {
        id theSegue = segue.destinationViewController;
        if (searchfilterIndex ==0) {
            DataItem * item= [[orgResult.detailinfo getDataItemArray:@"orglist"] getItem:selectIndex];
            [theSegue setValue:[item getString:@"OrganizationName"] forKey:@"searchName"];
        }else{
            DataItem * item= [[courseRequest.detailinfo getDataItemArray:@"orglist"] getItem:selectIndex];
            [theSegue setValue:[item getString:@"OrganizationName"] forKey:@"searchName"];
        }
       
    }else if ([segue.identifier isEqualToString:@"SearchToSchool"]){
        id theSegue = segue.destinationViewController;

        DataItem * item= [[schoolResult.detailinfo getDataItemArray:@"list"] getItem:selectIndex];
        [theSegue setValue:[item getString:@"ChineseName"] forKey:@"searchName"];
    }else if ([segue.identifier isEqualToString:@"SearchToChinaSchool"]){
        id theSegue = segue.destinationViewController;
        DataItem* item =[[chinaSchoolResult.detailinfo getDataItemArray:@"ChinaSchoolList"] getItem:selectIndex-[schoolResult.detailinfo getInt:@"TotalCount"]];
        [theSegue setValue:[item getString:@"SchoolName"] forKey:@"searchName"];
    }
}


#pragma mark - UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchfilterIndex == 0) {
        NSInteger totalCount =[orgResult.detailinfo getInt:@"TotalCount"];
        return totalCount;
    }else if (searchfilterIndex == 1){
        NSInteger schoolTotalCount = [schoolResult.detailinfo getInt:@"TotalCount"];
        NSInteger chinaSchoolTotalCount = [chinaSchoolResult.detailinfo getInt:@"TotalCount"];
        return schoolTotalCount+chinaSchoolTotalCount;
    }else{
        NSInteger totalCount =[courseRequest.detailinfo getInt:@"TotalCount"];
        return totalCount;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil].firstObject;
    if (searchfilterIndex == 0) {
        DataItem * item= [[orgResult.detailinfo getDataItemArray:@"orglist"] getItem:indexPath.row];
        cell.searchName.text  = [item getString:@"OrganizationName"];
    }else if (searchfilterIndex == 1){
        if (indexPath.row < [schoolResult.detailinfo getInt:@"TotalCount"]) {
            DataItem * item= [[schoolResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row];
            cell.searchName.text  = [item getString:@"ChineseName"];
        }else{
            DataItem* item =[[chinaSchoolResult.detailinfo getDataItemArray:@"ChinaSchoolList"] getItem:indexPath.row-[schoolResult.detailinfo getInt:@"TotalCount"]];
            cell.searchName.text  = [item getString:@"SchoolName"];
        }
        
    }else{
        DataItem * item= [[courseRequest.detailinfo getDataItemArray:@"orglist"] getItem:indexPath.row];
        cell.searchName.text  = [item getString:@"OrganizationName"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    
    if (searchfilterIndex == 0) {
        [self performSegueWithIdentifier:@"SearchToOrg" sender:self];
    }else if (searchfilterIndex ==1){
        if (indexPath.row < [schoolResult.detailinfo getInt:@"TotalCount"]) {
            [self performSegueWithIdentifier:@"SearchToSchool" sender:self];
        }else{
            [self performSegueWithIdentifier:@"SearchToChinaSchool" sender:self];
        }
        
    }else{
        [self performSegueWithIdentifier:@"SearchToOrg" sender:self];
    }
}

-(void)popView{
    
    _popVC = [[PopViewController alloc] init];
    
    
    _popVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //设置依附的按钮
    _popVC.popoverPresentationController.barButtonItem = _selectItem;
    
    //可以指示小箭头颜色
    _popVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //content尺寸
    _popVC.preferredContentSize = CGSizeMake(65, 35*3);
    
    //pop方向
    _popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //delegate
    _popVC.popoverPresentationController.delegate = self;
    _popVC.delegate = self;
    [self presentViewController:_popVC animated:YES completion:nil];
}

//代理方法 ,点击即可dismiss掉每次init产生的PopViewController
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

-(void)selectIndexDelegate:(NSInteger)index{
    searchfilterIndex = index;
    [_selectButton setTitle:SearchFilter[searchfilterIndex] forState:UIControlStateNormal];
    [_popVC dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)searchAction{
    if (_textfield.text.length==0) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptySearch];
    }else{
        if (searchfilterIndex == 0) {
            [self orgPreSearch];
        }else if (searchfilterIndex == 1){
            [self schoolPreSearch];
        }else{
            [self coursePreSearch];
        }
    }
}



#pragma mark - NetWorkrequest

-(void)orgPreSearch{

    NSDictionary* parameters = @{@"Org_Application_Id":@"",@"CourseName":_textfield.text,@"CourseType":@"",@"CourseKind":@"",@"City":@"",@"Field":@"",@"CourseClassCharacteristic":@"",@"CourseClassType":@"",@"OrderType":@(0)};
    [[OrginizationService sharedOrginizationService] postGetOrginfoWithPage:1 Size:1000 Parameters:parameters onCompletion:^(id json) {
        orgResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];

}

-(void)schoolPreSearch{
    [[SchoolService sharedSchoolService] getSchoolListWithPage:1 Size:1000 Parameters:@{@"ChineseName":_textfield.text,@"Country":@"",@"Province":@"",@"City":@"",@"CollegeNature":@"",@"CollegeType":@"",@"TestScore":@"",@"TuitionBudget":@"",@"MinimumAverage":@""} onCompletion:^(id json) {
        
        schoolResult = json;
        [self chinaSchoolPreSearch];
        
    } onFailure:^(id json) {
        
    }];

}

-(void)chinaSchoolPreSearch{
    [[SchoolService sharedSchoolService] postChinaSchoolListWithPage:1 Size:1000 Parameters:@{@"SchoolName":_textfield.text,@"Province":@"",@"City":@"",@"CollegeNature":@"",@"CollegeType":@"",@"Area":@"",@"X":@(0),@"Y":@(0)} onCompletion:^(id json) {
        
        chinaSchoolResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];

}

-(void)coursePreSearch{
    [[OrginizationService sharedOrginizationService] getOrgLisyByClassWithParameters:@{@"courseName":_textfield.text,@"pageIndex":@(1),@"pageSize":@(1000)} onCompletion:^(id json) {
        courseRequest = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
