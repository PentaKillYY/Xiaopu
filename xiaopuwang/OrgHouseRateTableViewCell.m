//
//  OrgHouseRateTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgHouseRateTableViewCell.h"

@implementation OrgHouseRateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    
    self.totalLabel.text = [NSString stringWithFormat:@"总招生人数：%d人",[item getInt:@"SchoolScale"]];
    
    
    if (self.pieChart) {
        [self.pieChart removeFromSuperview];
    }
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:[item getInt:@"ReadPeople"] color:PNRed description:@"目前在读  "],
                       [PNPieChartDataItem dataItemWithValue:[item getInt:@"WillReadPeople"] color:PNBlue description:@"即将入读  "],
                       [PNPieChartDataItem dataItemWithValue:[item getInt:@"SchoolScale"]- [item getInt:@"ReadPeople"]-[item getInt:@"WillReadPeople"] color:PNDeepGreen description:@"剩余名额"],
                       ];

    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((Main_Screen_Width-120)/2, 54, 120, 120) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = YES;
    
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendItemStyleSerial;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [self.pieChart getLegendWithMaxWidth:Main_Screen_Width];
    [legend setFrame:CGRectMake(100, 194, legend.frame.size.width, legend.frame.size.height)];
    legend.center = CGPointMake(Main_Screen_Width/2, 204);
    
    [self.contentView  addSubview:legend];
    
    [self.contentView addSubview:self.pieChart];
}
@end
