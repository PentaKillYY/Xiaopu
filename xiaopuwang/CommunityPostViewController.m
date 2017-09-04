//
//  CommunityPostViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityPostViewController.h"
#import "PostCommunityTitleCell.h"
#import "PostCommunityContentCell.h"
#import "PostCommunityImageCell.h"
#import "PostCommunityTypeCell.h"
#import "ZLPhotoActionSheet.h"
#import "CommunityLocationViewController.h"
#import "CommunityService.h"
#import "MyService.h"
#import <Photos/Photos.h>
@interface CommunityPostViewController ()<UITableViewDelegate,UITableViewDataSource,AddPostCommunityDelegate,UITextFieldDelegate,UITextViewDelegate>{
    DataResult*communityTypeResult;
    NSMutableArray* imageUploadArray;
    NSInteger selectImageCount;
    
    NSString* comTitle;
    NSString* comContent;
    NSString* comImage;
    NSString* comAddress;
    NSString* comType;
    
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation CommunityPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑内容";
    imageUploadArray = [[NSMutableArray alloc] init];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(postCommunity)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithImage:V_IMAGE(@"close") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:rightItm];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor darkGrayColor]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getCommunityTypeRequest];
}

-(void)setupParameter{
    comTitle = @"";
    comContent = @"";
    comImage = @"";
    comAddress = @"";
    comType = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *typeIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    NSIndexPath *locationIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:typeIndexPath,locationIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

}

-(void)popBack{
    UserInfo* info = [UserInfo sharedUserInfo];
    info.address = @"";
    info.communityType = @"";
    [info synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)postCommunity{
    [self postCommunityRequest];
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 140;
    }else if (indexPath.row==2) {
        return 120.0;
    }else{
        return 44.0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3){
        [self performSegueWithIdentifier:@"PostCommunityToType" sender:self];
    }else if (indexPath.row==4){
        [self performSegueWithIdentifier:@"PostCommunityToLocation" sender:self];
    }
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        PostCommunityTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PostCommunityTitleCell" owner:self options:nil].firstObject;
        cell.communityTitle.delegate = self;
        
        return cell;
    }else if (indexPath.row ==1){
        PostCommunityContentCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PostCommunityContentCell" owner:self options:nil].firstObject;
        cell.contentTextView.delegate = self;
        return cell;
    }else if (indexPath.row==2){
        PostCommunityImageCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PostCommunityImageCell" owner:self options:nil].firstObject;
        cell.delegate =self;
        [cell bingdingViewModel:imageUploadArray];
        
        comImage = [imageUploadArray componentsJoinedByString:@","];
        return cell;
    }else {
        PostCommunityTypeCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PostCommunityTypeCell" owner:self options:nil].firstObject;
        if (indexPath.row==3) {
            cell.typeImage.image = V_IMAGE(@"ht");
            cell.typeName.text = @"选择分类";
            
            if ([UserInfo sharedUserInfo].communityType.length) {
                cell.typeDetail.text = [[communityTypeResult.items getItem:[[UserInfo sharedUserInfo].communityType integerValue]] getString:@"TypeName"];
                
                comType = [[communityTypeResult.items getItem:[[UserInfo sharedUserInfo].communityType integerValue]] getString:@"Id"];
            }else{
                cell.typeDetail.text = @"请选择标签";
                comType = @"";
            }
            
        }else{
            cell.typeImage.image = V_IMAGE(@"postIoaction");
            if ([UserInfo sharedUserInfo].address.length) {
                cell.typeName.text = [UserInfo sharedUserInfo].address;
                comAddress = cell.typeName.text ;
            }else{
                cell.typeName.text = @"不显示位置";
                comAddress = @"";
            }
            
            cell.typeDetail.text = @"";
        }
        return cell;
    }
}

-(void)addImageDelegate{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9-imageUploadArray.count;
    actionSheet.sender = self;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        
        selectImageCount += images.count;
        
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

-(void)deleteImageDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    selectImageCount -= 1;
    [imageUploadArray removeObjectAtIndex:button.tag];
}

#pragma UITextfieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    comTitle = textField.text;
}

#pragma UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    comContent = textView.text;
}

#pragma mark - Networkrequest

-(void)getCommunityTypeRequest{
    [[CommunityService sharedCommunityService] getCommunityTypeWithParameters:nil onCompletion:^(id json) {
        communityTypeResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUserHeadRequest:(UIImage*)image ImageName:(NSString*)imgname{
    [[MyService  sharedMyService] uploadFileInfoWithImage:image Parameters:imgname onCompletion:^(id json) {
        DataResult* uploadResult = json;
        [imageUploadArray addObject:[uploadResult.detailinfo getString:@"UrlPath"]];
        if (imageUploadArray.count == selectImageCount) {
            NSIndexPath *imageIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:imageIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
  
        }
    } onFailure:^(id json) {
        
    }];
}

-(void)postCommunityRequest{
    if (comTitle.length == 0 ) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCommunityTitle];
    }else if (comType.length == 0){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCommunityType];
    }else if (comContent.length ==0 && comImage.length ==0){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCommunityContentOrImage];
    }else{
        [[CommunityService sharedCommunityService] UserPostCommunityWithParameters:@{
                                                                                     @"Title":comTitle,
                                                                                     @"Content":comContent,
                                                                                     @"ImageUrl":comImage,
                                                                                     @"UserId":[UserInfo sharedUserInfo].userID,
                                                                                     @"CommunityTypeId":comType,
                                                                                     @"Address":comAddress,
                                                                                     @"UserName":[UserInfo sharedUserInfo].username
                                                                                     } onCompletion:^(id json) {
                                                                                         [self.navigationController popViewControllerAnimated:YES];
                                                                                         
                                                                                     } onFailure:^(id json) {
                                                                                         
                                                                                     }];
    
    }
    
}
@end
