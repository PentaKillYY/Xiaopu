//
//  OrgProportionTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgProportionTableViewCell.h"

@implementation OrgProportionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    if (item) {
        sourceitem = [[DataItem alloc] init];
        [sourceitem append:item];
        
        [self configChartUI];
    }
    
}

-(void)configChartUI{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 42, [UIScreen mainScreen].bounds.size.width-20, 150)
                                   dataSource:self
                                        style:UUChartStyleBar];
    
    [chartView showInView:self.contentView];

}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    NSArray *aArray = [[sourceitem getString:@"CoursePeople"] componentsSeparatedByString:@","];

    for (int i=0; i<num; i++) {
        NSRange range = [aArray[i] rangeOfString:@"|"];
        [xTitles addObject:[aArray[i] substringToIndex:range.location]];
    }
    return xTitles;
}

- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart{
    NSArray *aArray = [[sourceitem getString:@"CoursePeople"] componentsSeparatedByString:@","];
    return [self getXTitles:(int)aArray.count];
}

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *aArray = [[sourceitem getString:@"CoursePeople"] componentsSeparatedByString:@","];
    NSMutableArray* chartXArray = [[NSMutableArray alloc] init];
    
    for (NSString* string in aArray) {
        NSRange range = [string rangeOfString:@"|"];
        
        [chartXArray addObject:[string substringFromIndex:range.location+1]];
    }
    return @[chartXArray] ;
}

- (NSArray *)chartConfigColors:(UUChart *)chart
{
    
    return @[[UUColor mainColor]];
}

//显示数值范围
- (CGRange)chartRange:(UUChart *)chart{
    
     NSArray *aArray = [[sourceitem getString:@"CoursePeople"] componentsSeparatedByString:@","];
    
    NSMutableArray* chartYArray = [[NSMutableArray alloc] init];
    for (NSString* string in aArray) {
        NSRange range = [string rangeOfString:@"|"];
        
        [chartYArray addObject:[string substringFromIndex:range.location+1]];
    }

    NSNumber * max = [chartYArray valueForKeyPath:@"@max.intValue"];

    return CGRangeMake([max intValue], 0);
}
@end
