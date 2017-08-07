//
//  ChinaShoolTeacherAndStudentViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/7.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ChinaShoolTeacherAndStudentViewController.h"
#import "SchoolService.h"
#import "ChinaTeacherAndSrudentCell.h"

@interface ChinaShoolTeacherAndStudentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult* teacherAndStudentResult;
    NSMutableArray* dataArray;

}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation ChinaShoolTeacherAndStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titlename;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChinaTeacherAndSrudentCell" bundle:nil] forCellReuseIdentifier:@"ChinaTeacherAndSrudentCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    dataArray = [NSMutableArray new];

    [self getSchoolTeacherAndStudentRequest];
    
    if (dataArray.count>0) {
        self.tableView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"ChinaTeacherAndSrudentCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
        [self configCell:cell indexpath:indexPath];
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChinaTeacherAndSrudentCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ChinaTeacherAndSrudentCell" owner:self options:nil].firstObject;
    [self configCell:cell indexpath:indexPath];
    return cell;
}

- (void)configCell:(ChinaTeacherAndSrudentCell *)cell indexpath:(NSIndexPath *)indexpath{
    cell.infoLabel.numberOfLines = 0;
    cell.infoLabel.preferredMaxLayoutWidth = SCREEN_WIDTH-88;
    
    [cell bingdingViewModel:dataArray[indexpath.row]];

}

-(void)getSchoolTeacherAndStudentRequest{
    [[SchoolService sharedSchoolService] getChinaSchoolTeacherAndStudentWithParameters:@{@"schoolId":self.schoolID} onCompletion:^(id json) {
        teacherAndStudentResult = json;
        
        for (int i = 0; i< teacherAndStudentResult.items.size; i++) {
            DataItem* item=  [teacherAndStudentResult.items getItem:i];
            int type = [item getInt:@"Type"];
            if (type == 1 && [self.titlename isEqualToString:@"优秀学生"]) {
                [dataArray addObject:item];
            }else if (type == 2 && [self.titlename isEqualToString:@"杰出校友"]){
                [dataArray addObject:item];
            }else if(type == 3 && [self.titlename isEqualToString:@"优秀老师"]){
                [dataArray addObject:item];
            }
        }

        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}


@end
