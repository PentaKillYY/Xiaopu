//
//  CommunityDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "CommunityDetailCell.h"
#import "CommunityReplyCell.h"
#import "CommunityService.h"
#import "CCTextView.h"
#import "PostImageCollectionViewCell.h"
#import "ZLPhotoActionSheet.h"
#import <Photos/Photos.h>
#import "MyService.h"

static NSString *identify = @"CommunityDetailCell";
static NSString *replyidentify = @"CommunityReplyCell";
@interface CommunityDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CommunityDetailCellDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PostImageDelegate,UITextViewDelegate>
{
    DataResult* detailResult;
    
    NSInteger currentIndex;
    NSInteger totalCount;
    NSInteger currentSegIndex;
    NSInteger selectIndex;
    DataItemArray* communityReplyListArray;
    BOOL isCollect;
    CGFloat _keyBoardHeight;
    
    UIView* addImageBG;
    UILabel* imageNumberLabel;
    NSInteger selectImageNumber;
    UICollectionView* imageCollectionView;
    NSMutableArray* selectImageArray;
    NSString* replyName;
    NSString* parentUserId;
    NSString* parentUserName;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet UIButton* sendButton;
@property(nonatomic,weak)IBOutlet UIButton* showReplyButton;
@property(nonatomic,weak)IBOutlet CCTextView* replyTextView;
@property(nonatomic,weak)IBOutlet UIView* replyBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyBGHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyBGBottom;
@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    replyName = @"回复楼主:";
    
    self.title = @"帖子全文";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                          initWithImage:V_IMAGE(@"arrow-back-blue") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:rightItm];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];
    
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    [self.tableView registerNib:[UINib nibWithNibName:replyidentify bundle:nil] forCellReuseIdentifier:replyidentify];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    detailResult = [DataResult new];
    
    communityReplyListArray = [DataItemArray new];
    currentIndex = 1;
    
    [self getCommunityDetaiRequest];
    [self getCommunityReplyListRequest];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex ++;
        [self getCommunityReplyListRequest];
        
    }];
    
    [self showReplyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    //打开键盘事件相应
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭键盘事件相应
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self userBrowseCommunityRequest];
}

-(void)showReplyUI{
    selectImageArray = [[NSMutableArray alloc] init];
    
    [self.sendButton.layer setCornerRadius:3.0];
    [self.sendButton.layer setBorderWidth:0.5];
    [self.sendButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.sendButton.layer setMasksToBounds:YES];
    
    self.replyTextView.delegate = self;
    [self.replyTextView.layer setCornerRadius:3.0];
    [self.replyTextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.replyTextView.layer setBorderWidth:0.5];
    [self.replyTextView.layer setMasksToBounds:YES];
    
//    self.replyTextView.placeholder = @"我也说一句...";
//    [self.replyTextView setPlaceholderOpacity:.5];
//    [self.replyTextView setPlaceholderColor:[UIColor lightGrayColor]];
//    [self.replyTextView setPlaceholderFont:[UIFont boldSystemFontOfSize:14]];
    self.replyTextView.text = replyName;
    [self.replyTextView setFont:[UIFont systemFontOfSize:14]];
    self.replyTextView.shouldAutoUpdateHeight = YES;
    
    [self.replyTextView TextViewDidUpdateHeightEvent:^(CCTextView *textView) {
        NSLog(@"CCTextView更新高度了%f",textView.frame.size.height);
        if (textView.frame.size.height>45) {
            self.replyBGHeight.constant = textView.frame.size.height+16;
        }else{
            self.replyBGHeight.constant = 45;
        }
    }];
}

- (void)keyboardWillShow:(NSNotification*)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyBoardHeight = keyboardRect.size.height;
    CGRect beginUserInfo = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey]   CGRectValue];
    if (beginUserInfo.size.height <=0) {//!!搜狗输入法弹出时会发出三次UIKeyboardWillShowNotification的通知,和官方输入法相比,有效的一次为dUIKeyboardFrameBeginUserInfoKey.size.height都大于零时.
        return;
    }
}

- (void)keyboardWillHide:(NSNotification*)notification{
    self.replyBGBottom.constant = 0;
}

#pragma mark - UITableViedatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return communityReplyListArray.size;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(CommunityDetailCell *cell) {
            
            [self configCell:cell IndexPath:indexPath];
            
        }];
 
    }else{
        return [tableView fd_heightForCellWithIdentifier:replyidentify cacheByIndexPath:indexPath configuration:^(CommunityReplyCell *cell) {
            
            [self configReplyCell:cell IndexPath:indexPath];
            
        }];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CommunityDetailCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityDetailCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [self configCell:cell IndexPath:indexPath];
        return cell;
    }else{
        CommunityReplyCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityReplyCell" owner:self options:nil].firstObject;
        [self configReplyCell:cell IndexPath:indexPath];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        DataItem* item = [communityReplyListArray getItem:indexPath.row];
        replyName = [NSString stringWithFormat:@"回复%@:",[item getString:@"UserName"]];
        if ([[item getString:@"UserName"] isEqualToString:[UserInfo sharedUserInfo].username]) {
           self.replyTextView.text = @"回复楼主:";
            parentUserId = @"";
            parentUserName = @"";
        }else{
            self.replyTextView.text = replyName;
            parentUserId = [item getString:@"UserId"];
            parentUserName = [item getString:@"UserName"];
        }
        
        
        [self showReplyAction];
    }
    
}

-(void)configCell:(CommunityDetailCell*)cell IndexPath:(NSIndexPath*)path{
    
    if ([detailResult.detailinfo getString:@"Id"].length) {
        [cell bingdingViewModel:detailResult.detailinfo];
        
        if ([[detailResult.detailinfo getString:@"UserId"] isEqualToString:[UserInfo sharedUserInfo].userID]) {
            cell.deleteCommunityHeight.constant = 27;
            cell.deleteCommunityButton.hidden = NO;
        }else{
            cell.deleteCommunityButton.hidden = YES;
            cell.deleteCommunityHeight.constant = 0;
        }
        
        if ([detailResult.detailinfo getString:@"ImageUrl"].length) {
            // img  九宫格图片，用collectionView做
            NSArray* imageArray = [[detailResult.detailinfo getString:@"ImageUrl"] componentsSeparatedByString:@","];
            
            cell.imageDatas = [[NSMutableArray alloc] initWithArray:imageArray];
        }else{
            cell.imageDatas = [[NSMutableArray alloc] initWithArray:@[]];;
        }
        
        
        [cell.imageCollectionView reloadData];
        
        CGFloat width = SCREEN_WIDTH - 64 - 20;
        // 没图片就高度为0 （约束是可以拖出来的哦哦）
        if ([NSArray isEmpty:cell.imageDatas])
        {
            cell.colletionViewHeight.constant = 0;
        }
        else
        {
            cell.colletionViewHeight.constant = ((cell.imageDatas.count - 1) / 3 + 1) * (width / 3) + (cell.imageDatas.count - 1) / 3 * 15;
        }

    }
    
}

-(void)configReplyCell:(CommunityReplyCell*)cell IndexPath:(NSIndexPath*)path{
    DataItem* item = [communityReplyListArray getItem:path.row];
    
    [cell bingdingViewModel:item];
}

-(void)collectCommunity{
    isCollect = !isCollect;
    if (isCollect) {
//        [self deleteCollectCommunityRequest];
    }else{
        [self collectCommunityRequest];
    }
}

#pragma mark - CommunityDetailCellDelegate
-(void)deleteCommunityDelegate:(id)sender{
    [self deleteCommunityRequest];
}

-(void)praiseCommunityDelegate:(id)sender{
    [self userGoodCommunityRequest];
}

#pragma mark - ReplyAction
-(IBAction)showReplyAction{
    NSInteger index1 =  [self.view.subviews indexOfObject:self.showReplyButton];
    NSInteger index2 =  [self.view.subviews indexOfObject:self.replyBGView];
    [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    self.replyTextView.text = replyName;
    [self.replyTextView becomeFirstResponder];
}

-(IBAction)showReplyImageAction:(id)sender{
    [self.replyTextView resignFirstResponder];
    self.replyBGBottom.constant = _keyBoardHeight;
    
    if (!addImageBG) {
        addImageBG = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height-_keyBoardHeight, Main_Screen_Width, _keyBoardHeight)];
        addImageBG.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(104, 104);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        
        imageCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake((Main_Screen_Width-104*3)/2, 60, 104*3, 104) collectionViewLayout:layout];
        imageCollectionView.backgroundColor = [UIColor clearColor];
        
        
        imageCollectionView.delegate = self;
        imageCollectionView.dataSource = self;
        imageCollectionView.scrollsToTop = NO;
        imageCollectionView.showsVerticalScrollIndicator = NO;
        imageCollectionView.showsHorizontalScrollIndicator = NO;
        
        [imageCollectionView registerNib:[UINib nibWithNibName:@"PostImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"kPostImageCollectionCell"];
        
        
        [addImageBG addSubview:imageCollectionView];
        
        imageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _keyBoardHeight-40, Main_Screen_Width, 20)];
        imageNumberLabel.text = [NSString stringWithFormat:@"已选%d张，还可以添加%d张",selectImageNumber,3-selectImageNumber];
        imageNumberLabel.textColor = [UIColor darkGrayColor];
        imageNumberLabel.font = [UIFont systemFontOfSize:13.0];
        imageNumberLabel.textAlignment = NSTextAlignmentCenter;
        [addImageBG addSubview:imageNumberLabel];
        
        
        [self.view addSubview:addImageBG];
        
    }
    
}

-(IBAction)sendReplyActopn:(id)sender{
    [self replyCommunityRequest];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_keyBoardHeight>0) {
        
        [self.replyTextView resignFirstResponder];
        
        NSInteger index1 =  [self.view.subviews indexOfObject:self.showReplyButton];
        NSInteger index2 =  [self.view.subviews indexOfObject:self.replyBGView];
        [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
        _keyBoardHeight = 0;

        self.replyBGBottom.constant = 0;

        if (addImageBG) {
            [addImageBG removeFromSuperview];
            addImageBG = nil;
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (selectImageArray.count == 3) {
        return 3;
    }else{
        return selectImageArray.count+1;
    }
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"kPostImageCollectionCell" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCollectionViewCell* collectionCell = (PostImageCollectionViewCell*)cell;
    collectionCell.deleteButton.tag = indexPath.row;
    collectionCell.delegate = self;
    if (selectImageArray.count == 3) {
        collectionCell.deleteButton.hidden=NO;
        [collectionCell configureCellWithImage:selectImageArray[indexPath.row]];
        
    }else{
        if (indexPath.row == selectImageArray.count) {
            collectionCell.deleteButton.hidden=YES;
            collectionCell.selectImage.image = V_IMAGE(@"add-pic");
        }else{
            collectionCell.deleteButton.hidden=NO;
            [collectionCell configureCellWithImage:selectImageArray[indexPath.row]];
        }
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self addImageDelegate];
}

-(void)deletePostImageDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    [selectImageArray removeObjectAtIndex:button.tag];
    [imageCollectionView reloadData];
    selectImageNumber -= 1;
    imageNumberLabel.text = [NSString stringWithFormat:@"已选%d张，还可以添加%d张",selectImageNumber,3-selectImageNumber];
}

-(void)addImageDelegate{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 10;
    //设置照片最大选择数
    actionSheet.maxSelectCount = 3-selectImageArray.count;
    actionSheet.sender = self;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        
        selectImageNumber += images.count;
        
        for (int i = 0; i<images.count; i++) {
            PHAsset*asset = assets[i];
            UIImage* image = images[i];
            
            NSString* assetID = [asset.localIdentifier substringToIndex:(asset.localIdentifier.length - 7)];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
            assetID = [assetID stringByAppendingString:strDate];
            [self updateUserHeadRequest:image ImageName:assetID];
            
        }
        
    }];
    
    [actionSheet showPhotoLibrary];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    DLog(@"%@",text);
    DLog(@"%d",textView.selectedRange.location);
    if (textView.selectedRange.location<replyName.length ) {
        return NO;
    }else{
        if (text.length ) {
            return YES;
        }else{
            if (textView.text.length >replyName.length) {
                return YES;
            }else{
                return NO;
            }
            
        }
        
    }
}

#pragma mark - NetWorkRequest
-(void)getCommunityDetaiRequest{
    
    [[CommunityService sharedCommunityService] getCommunityDetailWithParameters:@{@"id":self.communityId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        DataResult* result = json;
        if ([result.detailinfo getString:@"Id"].length) {
            parentUserId =[result.detailinfo getString:@"UserId"];
            parentUserName = [result.detailinfo getString:@"UserName"];
            
            [detailResult append:result];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
            if ([detailResult.detailinfo getInt:@"IsCollection"]) {
                isCollect = YES;
                UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollected") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
                [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
                [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
                
            }else{
                isCollect = NO;
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
                UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
                [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
                [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
            }
  
        }else{
            [[AppCustomHud sharedEKZCustomHud] showTextHud:CommunityIsEmpty];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getCommunityReplyListRequest{
    [[CommunityService sharedCommunityService] getCommunityReplyListWithPage:currentIndex Size:10 Parameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        DataResult* result = json;
        
        [communityReplyListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        totalCount = [result.detailinfo getInt:@"TotalCount"];
        
        if (currentIndex*10 < totalCount) {
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

    } onFailure:^(id json) {
        
    }];
}

-(void)collectCommunityRequest{
    [[CommunityService sharedCommunityService] collectCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollected") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
        [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
        [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    } onFailure:^(id json) {
        
    }];
}

-(void)deleteCollectCommunityRequest{
    [[CommunityService sharedCommunityService] deleteCollectCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
        UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
         [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
        [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];

    } onFailure:^(id json) {
        
    }];
}

-(void)deleteCommunityRequest{
    [[CommunityService sharedCommunityService] deleteCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}

-(void)userBrowseCommunityRequest{
    [[CommunityService sharedCommunityService] userBrowseCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];

}

-(void)userGoodCommunityRequest{
    [[CommunityService sharedCommunityService] userGoodCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        [self getCommunityDetaiRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUserHeadRequest:(UIImage*)image ImageName:(NSString*)imgname{
    [[MyService  sharedMyService] uploadFileInfoWithImage:image Parameters:imgname onCompletion:^(id json) {
        DataResult* uploadResult = json;
        [selectImageArray addObject:[uploadResult.detailinfo getString:@"UrlPath"]];
        if (selectImageArray.count == selectImageNumber) {
            [imageCollectionView reloadData];
            imageNumberLabel.text = [NSString stringWithFormat:@"已选%d张，还可以添加%d张",selectImageNumber,3-selectImageNumber];
        }
    } onFailure:^(id json) {
        
    }];
}

-(void)replyCommunityRequest{
    if (self.replyTextView.text.length == replyName.length && selectImageArray.count ==0) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCommunityContentOrImage];
    }else{
        [[CommunityService sharedCommunityService] userReplyCommunityWithParameters:@{
                                                                            @"NoteId":self.communityId,
                                                                                      @"UserId":[UserInfo sharedUserInfo].userID,
                                                                                      @"ParentUserId":parentUserId,
                                                                                      @"Content":[self.replyTextView.text substringFromIndex:replyName.length],
                                                                                      @"ImageUrl":[selectImageArray componentsJoinedByString:@","],
                                                                                      @"UserName":[UserInfo sharedUserInfo].username,
                                                                                      @"ParentUserName":parentUserName} onCompletion:^(id json) {
                                                                                          currentIndex =1;
                                                      
                                                                                          [self.replyTextView resignFirstResponder];
                                                                                          
                                                                                          NSInteger index1 =  [self.view.subviews indexOfObject:self.showReplyButton];
                                                                                          NSInteger index2 =  [self.view.subviews indexOfObject:self.replyBGView];
                                                                                          [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
                                                                                          _keyBoardHeight = 0;
                                                                                          
                                                                                          self.replyBGBottom.constant = 0;
                                                                                          
                                                                                          if (addImageBG) {
                                                                                              [addImageBG removeFromSuperview];
                                                                                              addImageBG = nil;
                                                                                          }
                                 
                                                                                        [self getCommunityReplyListRequest];
                                    
                                                                                      } onFailure:^(id json) {
                                                                                          
                                                                                      }];
    }
    
    
}
@end
