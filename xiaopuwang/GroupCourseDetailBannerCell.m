//
//  GroupCourseDetailBannerCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailBannerCell.h"

@implementation GroupCourseDetailBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)detailItem{
    self.courseNameLabel.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.courseNameLabel.numberOfLines = 0;
    
    [self.bannerLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[detailItem getString:@"CourseImage"]]] placeholderImage:nil];
    self.courseNameLabel.text = [detailItem getString:@"CourseName"];
    self.groupPeopleLabel.text = [NSString stringWithFormat:@"已有%d/%d人参与拼课",[detailItem getInt:@"FightCourseIsSignPeopleCount"],[detailItem getInt:@"FightCoursePeopleCount"]];
    
    NSString*endTime =[[detailItem getString:@"EndDate"] stringByReplacingOccurrencesOfString:@"T"withString:@" "];

    NSTimeInterval timeInterval =  [self calculateTimeInterval:endTime];
    nowTimeInterval = timeInterval;

    [self setupCourseState:detailItem];
}

-(void)setupCourseState:(DataItem*)item{
    if ([item getInt:@"FightCourseState"]==0) {
     //拼课未开始
        self.countHourLabel.text = @" 00 ";
        self.countMinLabel.text = @" 00 ";
        self.countSecondLabel.text = @" 00 ";
        self.countHourLabel.backgroundColor = GroupCourseRed;
        self.countMinLabel.backgroundColor = GroupCourseRed;
        self.countSecondLabel.backgroundColor = GroupCourseRed;
        self.courseStateLabel.text = @"未开始";
    }else if ([item getInt:@"FightCourseState"]==1){
    //拼课进行中
        
        int hour = (int)nowTimeInterval/3600;
        int minute = (int)(nowTimeInterval-3600*hour)/60;
        int second = (int)(nowTimeInterval-3600*hour-60*minute);

        if (hour<10) {
            self.countHourLabel.text = [NSString stringWithFormat:@" 0%d ",hour];
        }else{
            self.countHourLabel.text = [NSString stringWithFormat:@" %d ",hour];
        }
        
        if (minute<10) {
            self.countMinLabel.text = [NSString stringWithFormat:@" 0%d ",minute];
        }else{
            self.countMinLabel.text = [NSString stringWithFormat:@" %d ",minute];
        }
        
        if (second<10){
            self.countSecondLabel.text = [NSString stringWithFormat:@" 0%d ",second];
        }else{
            self.countSecondLabel.text = [NSString stringWithFormat:@" %d ",second];
        }
        
        self.countHourLabel.backgroundColor = GroupCourseRed;
        self.countMinLabel.backgroundColor = GroupCourseRed;
        self.countSecondLabel.backgroundColor = GroupCourseRed;
        
        self.courseStateLabel.text = @"后结束";
        //开始倒计时
        [self startTimer];
        
    }else if ([item getInt:@"FightCourseState"]==2){
    //拼课待开奖
        self.countHourLabel.text = @" 00 ";
        self.countMinLabel.text = @" 00 ";
        self.countSecondLabel.text = @" 00 ";
        self.countHourLabel.backgroundColor = [UIColor darkGrayColor];
        self.countMinLabel.backgroundColor = [UIColor darkGrayColor];
        self.countSecondLabel.backgroundColor = [UIColor darkGrayColor];
        
        self.courseStateLabel.text = @"已结束";
        
    }else{
    //拼课已开奖
        
        self.countHourLabel.text = @" 00 ";
        self.countMinLabel.text = @" 00 ";
        self.countSecondLabel.text = @" 00 ";
        self.countHourLabel.backgroundColor = [UIColor darkGrayColor];
        self.countMinLabel.backgroundColor = [UIColor darkGrayColor];
        self.countSecondLabel.backgroundColor = [UIColor darkGrayColor];
        self.courseStateLabel.text = @"已结束";
    }
}

-(void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(counttDown) userInfo:nil repeats:YES];
}

-(NSTimeInterval)calculateTimeInterval:(NSString*)endTime{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate * date1 = [NSDate date];
    NSDate * date2 = [df dateFromString:endTime];
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return time;
}

-(void)counttDown{
    nowTimeInterval-=1;
    int hour = (int)nowTimeInterval/3600;
    int minute = (int)(nowTimeInterval-3600*hour)/60;
    int second = (int)(nowTimeInterval-3600*hour-60*minute);
    
    if (hour<10) {
        self.countHourLabel.text = [NSString stringWithFormat:@" 0%d ",hour];
    }else{
        self.countHourLabel.text = [NSString stringWithFormat:@" %d ",hour];
    }
    
    if (minute<10) {
        self.countMinLabel.text = [NSString stringWithFormat:@" 0%d ",minute];
    }else{
        self.countMinLabel.text = [NSString stringWithFormat:@" %d ",minute];
    }
    
    if (second ==0 && minute ==0 && hour ==0) {
        [timer invalidate];
        self.countHourLabel.text = @" 00 ";
        self.countMinLabel.text = @" 00 ";
        self.countSecondLabel.text = @" 00 ";
        self.countHourLabel.backgroundColor = [UIColor darkGrayColor];
        self.countMinLabel.backgroundColor = [UIColor darkGrayColor];
        self.countSecondLabel.backgroundColor = [UIColor darkGrayColor];
    }else if (second<10){
        self.countSecondLabel.text = [NSString stringWithFormat:@" 0%d ",second];
    }else{
        self.countSecondLabel.text = [NSString stringWithFormat:@" %d ",second];
    }
    
    
}
@end
