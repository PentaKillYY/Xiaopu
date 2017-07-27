//
//  AppDelegate.h
//  xiaopuwang
//
//  Created by TonyJiang on 17/7/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager* _mapManager; 
}
@property (strong, nonatomic) UIWindow *window;


@end

