//
//  EvaluateOrderTableViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "UserEvaluateOrderTableViewController.h"
#import "EvaluateTagTableViewCell.h"
#import "EvaluateNumberTableViewCell.h"
#import "EvaluateContentTableViewCell.h"
#import "EvaluatePicTableViewCell.h"
#import "UIActionSheet+Block.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "MyService.h"
@interface UserEvaluateOrderTableViewController ()<EvaluateTagCellDelegate,EvaluateNumberCellDelegate,EvaluatePicCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
    NSMutableString* uploadImageName;
    DataResult*uploadResult;
    
    NSString* uploadImageUrl;
    
    NSString* replyContent;
    NSString* replyTag;
    NSString* bewriteMatch;
}

@end

@implementation UserEvaluateOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表评论";
    
    uploadImageName = [NSMutableString new];
    [self loadParameter];
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(30, 5, Main_Screen_Width-60, 35);
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"发表评论" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundColor:MAINCOLOR];
    [sendButton addTarget:self action:@selector(postEvaluateRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
    [footerView addSubview:sendButton];
    
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadParameter{
    uploadImageUrl = @"";
    replyContent = @"";
    replyTag = @"好评";
    bewriteMatch = @"";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2 || indexPath.section==3) {
        return 100;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EvaluateTagTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"EvaluateTagTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        EvaluateNumberTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"EvaluateNumberTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section ==2){
        EvaluateContentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"EvaluateContentTableViewCell" owner:self options:nil].firstObject;
        UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
        customAccessoryView.barTintColor = [UIColor whiteColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissTextViewInput:)];
        finish.tag = indexPath.section;
        [customAccessoryView setItems:@[space,space,finish]];
        cell.contentTextView.inputAccessoryView =customAccessoryView;

        return cell;
    }else{
        EvaluatePicTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"EvaluatePicTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        
        if (uploadImageUrl.length) {
            [cell.leftButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,uploadImageUrl]]  forState:UIControlStateNormal placeholderImage:V_IMAGE(@"choosepic")];
            cell.leftDeleteButton.hidden = NO;
        }else{
            [cell.leftButton setImage:V_IMAGE(@"choosepic") forState:UIControlStateNormal];
            cell.leftDeleteButton.hidden = YES;
        }
        
        return cell;
    }
}

#pragma mark - EvaluateTagCellDelegate

-(void)evaluateTagDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    replyTag = EvaluateTag[button.tag];
}

#pragma mark - EvaluateNumberCellDelegate
-(void)evaluateNumberChange:(NSString *)number{
    bewriteMatch = number;
}


-(void)dismissTextViewInput:(UIBarButtonItem*)item{
    UIBarButtonItem* aitem = item;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:aitem.tag];
    EvaluateContentTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    replyContent = cell.contentTextView.text;
    
    [cell.contentTextView resignFirstResponder];
}

-(void)takePicDelegate:(id)sender{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选择"]];
    sheet.delegate = self;
    [sheet showInView:self.view];

}

-(void)deletePicDelegate:(id)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    uploadImageUrl = @"";
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //选择相机时，设置UIImagePickerController对象相关属性
    if (buttonIndex == 0) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }else if (buttonIndex == 1){
        
        //选择相册时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString* str = [[representation url] absoluteString];
        NSArray *nameArray = [str componentsSeparatedByString:@"="];
        NSString* tempname = [nameArray objectAtIndex:1];
        tempname = [tempname substringToIndex:tempname.length-4];
        [uploadImageName appendString:tempname];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *string = [formatter stringFromDate:date];
        [uploadImageName appendString:string];
        
        [self uploadImageRequest:image];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
}

#pragma mark - NetworkRequest

-(void)postEvaluateRequest{
    if (replyContent.length && replyTag.length && bewriteMatch.length ) {
        [[MyService sharedMyService] userEvaluateWithParameters:@{@"Organization_Application_ID":self.orgId,@"Organization_Course_ID":@"",@"Reply_User_ID":[UserInfo sharedUserInfo].userID,@"Reply_Content":replyContent,@"Reply_Tag":replyTag,@"BewriteMatch":bewriteMatch,@"Reply_Picture":uploadImageUrl,@"TagPictureUrl":@"",@"Reply_Flag":@"",@"CourseOrder_ID":self.orderId} onCompletion:^(id json) {
            [self updateAfterEvauateRequest];
            
        } onFailure:^(id json) {
            
        }];
    }
}

-(void)uploadImageRequest:(UIImage*)image{
    [[MyService  sharedMyService] uploadFileInfoWithImage:image Parameters:uploadImageName onCompletion:^(id json) {
        uploadResult = json;
        if (uploadResult.statusCode == 0) {
            
        }else if (uploadResult.statusCode == 1){

            uploadImageUrl = [uploadResult.detailinfo getString:@"UrlPath"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
        
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    } onFailure:^(id json) {
        
    }];

}

-(void)updateAfterEvauateRequest{
    [[MyService sharedMyService] updateAfterEvaluateWithParameters:@{@"Id":self.orderId} onCompletion:^(id json) {
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}
@end
