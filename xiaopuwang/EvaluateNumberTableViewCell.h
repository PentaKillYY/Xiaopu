//
//  EvaluateNumberTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DLStarRatingControl.h"

@protocol EvaluateNumberCellDelegate <NSObject>

-(void)evaluateNumberChange:(NSString*)number;

@end

@interface EvaluateNumberTableViewCell : BaseTableViewCell<DLStarRatingDelegate>
{
    float rate;
}

@property(nonatomic,weak)IBOutlet UILabel* rateText;
@property(nonatomic,assign)id<EvaluateNumberCellDelegate>delegate;

@end

