//
//  GuideViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/24.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GuideViewController.h"
#import "WebViewJavascriptBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface GuideViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)IBOutlet UIWebView* webView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"newGuidance" ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];

    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_bridge setWebViewDelegate:self];
    
    [self registBackFunction];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registBackFunction
{
    [_bridge registerHandler:@"WebToNative" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}



@end
