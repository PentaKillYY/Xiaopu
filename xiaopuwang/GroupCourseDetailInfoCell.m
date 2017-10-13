//
//  GroupCourseDetailInfoCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailInfoCell.h"

@implementation GroupCourseDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.webView.scrollView.scrollEnabled = NO;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)detailItem{
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[detailItem getString:@"OrgLogo"]]] placeholderImage:nil];
    [self.orgLogo.layer setCornerRadius:12.5];
    [self.orgLogo.layer setMasksToBounds:YES];
    
    self.orgName.text = [detailItem getString:@"OrgName"];
    
    if ([detailItem getString:@"VideoURL"].length) {
        self.sepHeight.constant = 8;
        self.videoHeight.constant = (Main_Screen_Width-16)/2;
        self.playImg.hidden = NO;
        [self.playVideoButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[detailItem getString:@"VideoPictureUrl"]]]  forState:UIControlStateNormal];
    }else{
        self.videoHeight.constant = 0;
        self.sepHeight.constant = 0;
        self.playImg.hidden = YES;
    }
    
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", [detailItem getString:@"FightCourseIntroduction"]];
    
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:0;font-size: %f;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",13.0,htmlcontent];
    
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    
    [self.webView loadHTMLString:BookStr baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 16];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEW_HEIGHT" object:@{@"WEBVIEW_HEIGHT":@(height)} userInfo:nil];
}


-(IBAction)goToOrgAction:(id)sender{
    [self.delegate groupCourseToOrgDelegate:sender];
}

-(IBAction)playVideoAction:(id)sender{
    [self.delegate groupCoursePlayVideoDelegate:sender];
}
@end
