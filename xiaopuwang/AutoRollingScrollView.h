//
//  AutoRollingScrollView.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AutoRollingScrollView : UIView<UIScrollViewDelegate>
@property NSInteger totalImage;
@property (nonatomic,strong,readwrite)UIScrollView *scrollView;
@property (nonatomic,strong,readwrite)NSMutableArray *imageNameList;
@property (nonatomic,assign,readwrite)NSInteger currentIndex;
//初始化三个UIImageView
@property (nonatomic,strong,readwrite)UITextView *leftImageView;
@property (nonatomic,strong,readwrite)UITextView *currentImageView;
@property (nonatomic,strong,readwrite)UITextView *rightImageView;

@property (nonatomic,strong,readwrite)NSTimer *timer;


//@property (nonatomic,strong,readwrite)NSMutableArray *
//初始化数据源
-(void)DataSource;
//初始化用户界面
-(void)UserInterface;

//初始化图片数据
-(void)initImages;

//当scrollViewDidScroll触发时，时刻更新UI,此函数是实现循环的关键
-(void)updateUI;


//Timer事件处理
-(void)processTimer;
@end
