//
//  AppDelegate.m
//  xiaopuwang
//
//  Created by TonyJiang on 17/7/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "OrginizationService.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];

    /* 设置高德key */
    [self configAmap];
    
    /* 设置百度地图key */
    [self configBaiduMap];
    
    /* 设置融云key */
    [self configRongCloud];
    
    [WXApi registerApp:WXAPIKEY enableMTA:YES];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:CM_FIRST_LAUNCHED]) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController* mainTab = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTab"];
        self.window.rootViewController = mainTab;
    }else{
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController* nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"SelectNav"];
        self.window.rootViewController = nav;
    }

    [defaults setValue:@"NO" forKey:CM_FIRST_LAUNCHED];
    [defaults synchronize];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)configAmap{
    [AMapServices sharedServices].apiKey = AMAPKEY;
    [AMapServices sharedServices].enableHTTPS = YES;

}

- (void)configBaiduMap{
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDUMAPKEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPIKEY appSecret:WXSECRET redirectURL:nil];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。

     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPIKEY   appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
   
    /* 设置新浪的appKey和appSecret
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINAAPPKEY  appSecret:SINASECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 移除多余的分享平台（QQ收藏、QQ空间）
     */
     [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}

- (void)configRongCloud{
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUDDISKEY];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
        //微信支付回调
        if ([[url absoluteString] rangeOfString:[NSString stringWithFormat:@"%@://pay",WXAPIKEY]].location == 0) {
            return [WXApi handleOpenURL:url delegate:self];
        }
        //支付宝回调
        if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"platformapi"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSString * aliPayResult;

                NSInteger resultCode = [[resultDic objectForKey:@"resultStatus"] intValue];
                if (resultCode == 9000 ) {
                    aliPayResult = @"success";
                }else {
                    aliPayResult = @"failure";
                }

                NSNotification * notification = [NSNotification notificationWithName:@"AliPay" object:aliPayResult];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
 
        }
        

    }
    return result;
}



- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    UserInfo* info =  [UserInfo sharedUserInfo];
    
    
    if ([userId isEqualToString:info.userID]) {
        RCUserInfo* rcinfo = [[RCUserInfo alloc] initWithUserId:userId name:info.username portrait:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,info.headPicUrl]];
        [[RCIM sharedRCIM] refreshUserInfoCache:rcinfo withUserId:userId];
    }else if ([userId isEqualToString:SchoolRongCloudId]){
        NSString *newPath=[[NSBundle mainBundle] pathForResource:@"ShareLogo" ofType:@"png"];
        RCUserInfo* rcinfo = [[RCUserInfo alloc] initWithUserId:userId name:@"留学顾问" portrait:newPath];
        [[RCIM sharedRCIM] refreshUserInfoCache:rcinfo withUserId:userId];
        
    }else if ([userId isEqualToString:ChinaSchoolRongCloudId]){
        NSString *newPath=[[NSBundle mainBundle] pathForResource:@"ShareLogo" ofType:@"png"];
        RCUserInfo* rcinfo = [[RCUserInfo alloc] initWithUserId:userId name:@"国际留学顾问" portrait:newPath];
        [[RCIM sharedRCIM] refreshUserInfoCache:rcinfo withUserId:userId];
    }else{
        [[RCIM sharedRCIM] getUserInfoCache:userId];
    }
}

-(void)onResp:(BaseResp*)resp{
    NSString * wxPayResult;

    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                wxPayResult = @"success";
                break;
            default:
                wxPayResult = @"failure";
                break;
        }
    }
    
    //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
    NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:wxPayResult];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


@end
