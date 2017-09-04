//
//  SchoolIntroViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/3.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolIntroViewController.h"

@interface SchoolIntroViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)IBOutlet UIWebView* webView;
@end

@implementation SchoolIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校介绍";
    
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", self.intro];
    _webView.delegate = self;
    [_webView loadHTMLString:htmlcontent baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}


@end
