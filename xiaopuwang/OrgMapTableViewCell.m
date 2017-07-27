//
//  OrgMapTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMapTableViewCell.h"


@implementation OrgMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    
    if (self.mapView) {
        [self.mapView removeFromSuperview];
        self.mapView = nil;
    }
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 34, Main_Screen_Width, 186)];
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([item getDouble:@"Y"], [item getDouble:@"X"]);
    
    self.mapView.delegate = self;
    
    [self.mapView setZoomLevel:15];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([item getDouble:@"Y"], [item getDouble:@"X"])];
    
    
    pointAnnotation.title = [item getString:@"OrganizationName"];
    [self.mapView  addAnnotation:pointAnnotation];
    
    [self.mapView selectAnnotation:pointAnnotation animated:YES];
    
    [self.contentView addSubview:self.mapView];
}

@end
