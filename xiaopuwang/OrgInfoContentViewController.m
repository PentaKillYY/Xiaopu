//
//  OrgInfoContentViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgInfoContentViewController.h"
#import "OrgContentTableViewCell.h"
@interface OrgInfoContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgInfoContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"机构信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgContent"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  [tableView fd_heightForCellWithIdentifier:@"OrgContent" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell Index:indexPath];
    }];
}

-(void)configCell:(OrgContentTableViewCell*)cell Index:(NSIndexPath*)indexPath{
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[self.orgContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    cell.orgContent.attributedText = attrStr;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrgContentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgContentTableViewCell" owner:self options:nil].firstObject;
    [self configCell:cell Index:indexPath];
    return cell;

}


@end
