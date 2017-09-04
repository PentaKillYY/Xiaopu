//
//  SchoolGradeTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolGradeTableViewCell.h"
#define Space 35
@implementation SchoolGradeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    
    [self.gradeScrollView setContentSize:CGSizeMake(Space*18+20+20, 56.5)];
    self.gradeScrollView.showsVerticalScrollIndicator = NO;
    self.gradeScrollView.showsHorizontalScrollIndicator = NO;
    NSArray* gradeArray = [NSArray arrayWithArray:[[item getString:@"AcceptGrade"] componentsSeparatedByString:@","]];
    
    for (int i = 0 ; i<19; i++) {
        UILabel* pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+Space*i, 25, 5, 5)];
        
        pointLabel.backgroundColor = [UIColor lightGrayColor];
        [pointLabel.layer setCornerRadius:2.5];
        [pointLabel.layer setMasksToBounds:YES];
        
        UILabel* acceptLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+Space*i, 27, Space, 1)];
        acceptLabel.backgroundColor = [UIColor lightGrayColor];
        
        if (i%2) {
            UILabel* topGradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 21)];
            topGradeLabel.center = CGPointMake(17.5+Space*i, 10);
            topGradeLabel.textColor = [UIColor lightGrayColor];
            topGradeLabel.font = [UIFont systemFontOfSize:11];
            topGradeLabel.text = SchoolGrade[i];
            topGradeLabel.textAlignment = NSTextAlignmentCenter;
            
            if (i == 1 && [gradeArray containsObject:@"18"]) {
                topGradeLabel.textColor  = MAINCOLOR;
                pointLabel.backgroundColor = MAINCOLOR;
            }else if ([gradeArray containsObject:[NSString stringWithFormat:@"%d"
                                                  ,i-2]]){
                pointLabel.backgroundColor = MAINCOLOR;
                topGradeLabel.textColor  = MAINCOLOR;
            }
            
            [self.gradeScrollView addSubview:topGradeLabel];
        }else{
            UILabel* bottomGradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 21)];
            bottomGradeLabel.center = CGPointMake(17.5+Space*i, 45);
            bottomGradeLabel.textColor = [UIColor lightGrayColor];
            bottomGradeLabel.font = [UIFont systemFontOfSize:11];
            bottomGradeLabel.text = SchoolGrade[i];
            bottomGradeLabel.textAlignment = NSTextAlignmentCenter;
            
            if (i == 0 && [gradeArray containsObject:@"17"]) {
                bottomGradeLabel.textColor  = MAINCOLOR;
                pointLabel.backgroundColor = MAINCOLOR;
            }else if ([gradeArray containsObject:[NSString stringWithFormat:@"%d"
                                                  ,i-2]]){
                pointLabel.backgroundColor = MAINCOLOR;
                bottomGradeLabel.textColor  = MAINCOLOR;
            }

            
            [self.gradeScrollView addSubview:bottomGradeLabel];
        }
        [self.gradeScrollView addSubview:pointLabel];
        
        if (i == 0 && [gradeArray containsObject:@"17"]) {
            acceptLabel.backgroundColor = MAINCOLOR;
        }else if (i == 1 && [gradeArray containsObject:@"18"]){
            acceptLabel.backgroundColor = MAINCOLOR;
        }else if ([gradeArray containsObject:[NSString stringWithFormat:@"%d"
                                              ,i-2]]){
            acceptLabel.backgroundColor = MAINCOLOR;
        }
        
        if (i <18) {
            [self.gradeScrollView addSubview:acceptLabel];
        }
        
    }
}
@end
