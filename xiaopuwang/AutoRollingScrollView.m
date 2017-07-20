//
//  AutoRollingScrollView.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "AutoRollingScrollView.h"

@implementation AutoRollingScrollView

- (id)init{
    self = [super init];
    if (self) {
        [self DataSource];
        [self UserInterface];
        
    }
    return self;
}

//初始化数据源
-(void)DataSource{
    _totalImage = 6;
    _currentIndex =0;
    
    _imageNameList = [[NSMutableArray alloc]init];
    
    //初始化图片
    for(NSInteger i=0;i<_totalImage;i++){
        NSString *imageName = @"在线咨询可获得1%~100%随机学费补贴  138****9999用户于2017-3获得3250补贴";
        [_imageNameList addObject:imageName];
    }
}



//初始化用户界面
-(void)UserInterface{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat VIEW_H =39;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, Main_Screen_Width-62, VIEW_H)];
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(Main_Screen_Width-62,VIEW_H*3)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentOffset:CGPointMake(0,VIEW_H)];
    _scrollView.userInteractionEnabled = NO;
   
    
    
    //初始化三个UIImageView，并固定他们位于_scrollView中的位置
    _leftImageView = [[UITextView alloc]initWithFrame:CGRectMake(0,0, Main_Screen_Width-62, VIEW_H)];
    _leftImageView.font = [UIFont systemFontOfSize:11];
    _leftImageView.backgroundColor = [UIColor clearColor];
    _leftImageView.userInteractionEnabled = NO;
    
    _currentImageView = [[UITextView alloc]initWithFrame:CGRectMake(0,VIEW_H, Main_Screen_Width-62, VIEW_H)];
    _currentImageView.font = [UIFont systemFontOfSize:11];
    _currentImageView.userInteractionEnabled = NO;
     _currentImageView.backgroundColor = [UIColor clearColor];
    
    _rightImageView = [[UITextView alloc]initWithFrame:CGRectMake(0,VIEW_H*2, Main_Screen_Width-62, VIEW_H)];
    _rightImageView.font = [UIFont systemFontOfSize:11];
    _rightImageView.userInteractionEnabled = NO;
    _rightImageView.backgroundColor = [UIColor clearColor];
    //用UIImage的图像来初始化三个ImageView;
    [self initImages];
    
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_currentImageView];
    [_scrollView addSubview:_rightImageView];
    
     [self addSubview:_scrollView];
    
    //实例化_timer;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(processTimer) userInfo:nil repeats:YES];
    
}




-(void)initImages{
    //根据当前的_currentIndex（当前需要显示的索引）来初始化三个ImageView对应的图片
    
    [_leftImageView setText:_imageNameList[(_currentIndex-1+_totalImage)%_totalImage]];
    
    [_currentImageView setText:_imageNameList[_currentIndex]];
    [_rightImageView setText:_imageNameList[(_currentIndex+1)%_totalImage]];
}




-(void)updateUI{//核心函数
    
    CGFloat VIEW_H =39;
    
    CGFloat Offset_y =_scrollView.contentOffset.y;
    //判断是否需要更新界面
    BOOL isUpdate =NO;
    
    
    if(Offset_y==2*VIEW_H){
        isUpdate = YES;
        _currentIndex = (_currentIndex+1)%_totalImage;
    }
    else if(Offset_y==0){
        isUpdate = YES;
        _currentIndex = (_currentIndex-1+_totalImage)%_totalImage;
    }
    
    else if (Offset_y<=0.5*VIEW_H){
       
    }
    else if (Offset_y>=1.5*VIEW_H){
        //_pageControll更新到下一页
        //        [_pageControll setCurrentPage:(_currentIndex+1)%totalImage];
    }
    

    else{
    }
    
    
    
    if(!isUpdate){
        return;
    }
    
    [self initImages];
    [_scrollView setContentOffset:CGPointMake(0,VIEW_H)];
    
    
}

-(void)processTimer{
    [_scrollView setContentOffset:CGPointMake(0,2*CGRectGetHeight(self.bounds))animated:YES];
    
}



//实现代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateUI];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate distantFuture]];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}


@end
