//
//  OrgMapTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <MAMapKit/MAMapKit.h>

@interface OrgMapTableViewCell : BaseTableViewCell<MAMapViewDelegate>
@property(nonatomic,weak)IBOutlet MAMapView* mapView;

-(void)bingdingViewModel:(DataItem*)item;
@end
