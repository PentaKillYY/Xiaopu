//
//  OrgMapTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface OrgMapTableViewCell : BaseTableViewCell<BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView* mapView;

-(void)bingdingViewModel:(DataItem*)item;
@end
