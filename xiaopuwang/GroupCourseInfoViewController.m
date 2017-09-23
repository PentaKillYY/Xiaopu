//
//  GroupCourseInfoViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseInfoViewController.h"

@interface GroupCourseInfoViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)IBOutlet UIWebView* webView;
@end

@implementation GroupCourseInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构信息";
    
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", self.courseContent];
    
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:0;font-size: %f;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",13.0,htmlcontent];
    
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [_webView loadHTMLString:BookStr baseURL:nil];
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

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
