//
//  MyViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyViewController.h"
#import "MyBannerCell.h"
#import "MyTableCell.h"
#import "UIActionSheet+Block.h"
#import "MyService.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,UserLogoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.tableView registerNib:[UINib nibWithNibName:@"MyBannerCell" bundle:nil] forCellReuseIdentifier:@"MyBannerCell"];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        
    UIBarButtonItem* leftitem = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"message") style:UIBarButtonItemStylePlain target:self action:@selector(messagePush:)];
    
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingPush:)];
    
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftitem rightBarButtonItem:rightItm];

    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self getUserOnlyRequest];
   
    [self getUserBalanceRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MyBannerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyBannerCell" forIndexPath:indexPath];
        
        cell.bgImage.image =V_IMAGE(@"top");
        
        UserInfo* info = [UserInfo sharedUserInfo];
        if (info.headPicUrl != nil) {
            NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:info.headPicUrl options:NSDataBase64DecodingIgnoreUnknownCharacters];
            
            UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
            [cell.userLogo setImage:_decodedImage forState:UIControlStateNormal];
        }
        
        cell.userName.text = info.username;
        cell.balance.text = [NSString stringWithFormat:@"账户余额:%.2f",[info.userBalance doubleValue]];
        
        cell.delegate = self;
        return cell;
    }else {
        UserInfo* info = [UserInfo sharedUserInfo];
        MyTableCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil].firstObject;
        cell.cellTitle.text = MyCellTitle[indexPath.section-1][indexPath.row];
        NSString* imageName = [NSString stringWithFormat:@"My-%ld-%ld",indexPath.section,indexPath.row];
        
        
        cell.cellImage.image = V_IMAGE(imageName);
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.cellDetail.text = [NSString stringWithFormat:@"%.2f元",[info.userBalance doubleValue]];
        }else if (indexPath.section == 2 && indexPath.row == 1){
            cell.cellDetail.text = @"0张";
        }else if (indexPath.section == 2 && indexPath.row == 2){
            cell.cellDetail.text = @"0.00元";
        }else{
            cell.cellDetail.text = @"";
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Main_Screen_Width/753*378+1;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 && indexPath.row == 1) {
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            
            [self shareWebPageToPlatformType:platformType];
            
        }];
    }
}


-(void)messagePush:(id)sender{

}

-(void)settingPush:(id)sender{
    
}

-(void)changeUserLogo:(id)sender{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选择"]];
    sheet.delegate = self;
    [sheet showInView:self.view];
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
    
    
    NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *_encodedImageStr = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    
    [self updateUserHeadRequest:_encodedImageStr];
//    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
//    MyBannerCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell.userLogo setImage:image forState:UIControlStateNormal];
//    [cell layoutSubviews];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ShareDetailTitle descr:nil thumImage:[UIImage imageNamed:@"ShareLogo"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://www.admin.ings.org.cn/UserRegister/GetCoupon?userId=&couponId=";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - NetWorkRequest
-(void)getUserOnlyRequest{
    [[MyService sharedMyService] getUserOnlyWithParameters:@{@"userId":@"47c68ae6-7705-4aa8-b272-ac7ea768601c"} onCompletion:^(id json) {
        DataResult* result = json;
        
        UserInfo* info = [UserInfo sharedUserInfo];
        NSString* UserBase64Image = [result.detailinfo getString:@"UserImage"];
        NSRange range = [UserBase64Image rangeOfString:@"base64,"];
        NSInteger location = range.location;
        NSInteger leight = range.length;
        UserBase64Image = [UserBase64Image substringFromIndex:location+leight];
    
        info.headPicUrl = UserBase64Image;
        info.username = [result.detailinfo getString:@"UserName"];
        
        [info synchronize];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserBalanceRequest{
    [[MyService sharedMyService] getUserBalanceWithParameters:@{@"userId":@"47c68ae6-7705-4aa8-b272-ac7ea768601c"} onCompletion:^(id json) {
        DataResult* result = json;
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.userBalance = [NSString stringWithFormat:@"%f",[result.detailinfo getDouble:@"TotalPrice"]];
        [info synchronize];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUserHeadRequest:(NSString*)imageBase64{
    [[MyService sharedMyService] postUserHeadWithParameters:@{@"UserID":@"47c68ae6-7705-4aa8-b272-ac7ea768601c",@"ImageBase":imageBase64} onCompletion:^(id json) {
        DataResult* result = json;
        UserInfo* info = [UserInfo sharedUserInfo];
        
        NSRange range = [imageBase64 rangeOfString:@"base64,"];
        NSInteger location = range.location;
        NSInteger leight = range.length;
        info.headPicUrl = [imageBase64 substringFromIndex:location+leight];
        [info synchronize];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}
@end
