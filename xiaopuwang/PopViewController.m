//
//  PopViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/24.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableVIew;
    NSArray *_dataArray;
    NSArray *_arr1;
}
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr1 = @[@"机构",@"学校",@"课程"];
    
    _tableVIew = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    _tableVIew.scrollEnabled = YES;
    _tableVIew.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableVIew];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr1.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = _arr1[indexPath.row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectIndexDelegate:indexPath.row];
}

//重置本控制器的大小
-(CGSize)preferredContentSize{
    
    if (self.popoverPresentationController != nil) {
        CGSize tempSize ;
        tempSize.height = self.view.frame.size.height;
        tempSize.width  = 155;
        CGSize size = [_tableVIew sizeThatFits:tempSize];  //返回一个完美适应tableView的大小的 size
        return size;
    }else{
        return [super preferredContentSize];
    }
    
}


@end
