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
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 34, Main_Screen_Width, 186)];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([item getDouble:@"Y"], [item getDouble:@"X"]);
    
    self.mapView.delegate = self;
    
    [self.mapView setZoomLevel:15];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([item getDouble:@"Y"], [item getDouble:@"X"])];
    
    
    pointAnnotation.title = [item getString:@"OrganizationName"];
    [self.mapView  addAnnotation:pointAnnotation];
    
    [self.mapView selectAnnotation:pointAnnotation animated:YES];
    
    [self.contentView addSubview:self.mapView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}
@end
