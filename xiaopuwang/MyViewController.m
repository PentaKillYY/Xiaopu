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
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import "MyChatListViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,UserLogoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString* uploadImageName;
    DataResult* uploadResult;
}
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.tableView registerNib:[UINib nibWithNibName:@"MyBannerCell" bundle:nil] forCellReuseIdentifier:@"MyBannerCell"];
    

    UIBarButtonItem* leftitem = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"message") style:UIBarButtonItemStylePlain target:self action:@selector(messagePush:)];
    
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingPush:)];
    
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftitem rightBarButtonItem:rightItm];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    [self getUserBalanceRequest];
    
    [super viewWillAppear:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return MyCellTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [NSArray arrayWithArray:MyCellTitle[section]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MyBannerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyBannerCell" forIndexPath:indexPath];
        
        cell.bgImage.image =V_IMAGE(@"top");
        
        UserInfo* info = [UserInfo sharedUserInfo];
        if (info.headPicUrl != nil) {
            
            [cell.userLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,info.headPicUrl ]] forState:UIControlStateNormal placeholderImage:nil];
        }
        
        cell.userName.text = info.username;
        cell.balance.text = [NSString stringWithFormat:@"账户余额:%.2f",[info.userBalance doubleValue]];
        cell.coupon.text = [NSString stringWithFormat:@"优惠券:%d张",[info.userCoupon integerValue]];
        
        cell.delegate = self;
        return cell;
    }else {
        UserInfo* info = [UserInfo sharedUserInfo];
        MyTableCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil].firstObject;
        cell.cellTitle.text = MyCellTitle[indexPath.section][indexPath.row];
        NSString* imageName = [NSString stringWithFormat:@"My-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        
        
        cell.cellImage.image = V_IMAGE(imageName);
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.cellDetail.text = [NSString stringWithFormat:@"%.2f元",[info.userBalance doubleValue]];
        }else if (indexPath.section == 2 && indexPath.row == 1){
            cell.cellDetail.text = [NSString stringWithFormat:@"%d张",[info.userCoupon integerValue]];
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
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        if (indexPath.section == 1 && indexPath.row ==0) {
            [self performSegueWithIdentifier:@"MyToOrder" sender:self];
        }else if (indexPath.section == 2 && indexPath.row == 0){
            [self performSegueWithIdentifier:@"MyToWallet" sender:self];
        }else if (indexPath.section == 2 && indexPath.row == 1){
//            [self performSegueWithIdentifier:@"MyToCoupon" sender:self];
        }else if (indexPath.section ==3 && indexPath.row == 0) {
            [self performSegueWithIdentifier:@"MyToFollow" sender:self];
        }else if (indexPath.section == 3 && indexPath.row == 1){
            [self performSegueWithIdentifier:@"MyToSpecialist" sender:self];
        }else if (indexPath.section == 3 && indexPath.row == 2) {
            //显示分享面板
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
                
                [self shareWebPageToPlatformType:platformType];
                
            }];
        }else if (indexPath.section == 3 && indexPath.row == 3){
            [self performSegueWithIdentifier:@"MyToUpdateInfo" sender:self];
        }else if (indexPath.section == 3 && indexPath.row == 4){
            [self performSegueWithIdentifier:@"MyToSetting" sender:self];
        }

    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
}


-(void)messagePush:(id)sender{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        MyChatListViewController *chatList = [[MyChatListViewController alloc] init];
        chatList.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:chatList animated:YES];
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}

-(void)settingPush:(id)sender{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length){
        [self performSegueWithIdentifier:@"MyToSetting" sender:self];
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
}

-(void)changeUserLogo:(id)sender{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length){
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选择"]];
        sheet.delegate = self;
        [sheet showInView:self.view];
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
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
        uploadImageName = [tempname substringToIndex:tempname.length-4];
        DLog(@"uploadImageName:%@",str);
        
        [self updateUserHeadRequest:image];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];

}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    UserInfo* info = [UserInfo sharedUserInfo];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ShareDetailTitle descr:nil thumImage:[UIImage imageNamed:@"ShareLogo"]];

    shareObject.webpageUrl =[NSString stringWithFormat:@"http://www.admin.ings.org.cn/UserRegister/GetCoupon?userId=%@&couponId=",info.userID];
    
    
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

-(void)getUserBalanceRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        [[MyService sharedMyService] getUserBalanceWithParameters:@{@"userId":info.userID} onCompletion:^(id json) {
            DataResult* result = json;
            
            info.userBalance = [NSString stringWithFormat:@"%f",[result.detailinfo getDouble:@"TotalPrice"]];
            [info synchronize];
            
            [self getUserCouponListRequest];
        } onFailure:^(id json) {
            DataResult* result = json;
            
            info.userBalance = [NSString stringWithFormat:@"%f",[result.detailinfo getDouble:@"TotalPrice"]];
            [info synchronize];
            
            [self getUserCouponListRequest];

        }];
    }
}

-(void)updateUserHeadRequest:(UIImage*)image{
    
    
    [[MyService  sharedMyService] uploadFileInfoWithImage:image Parameters:uploadImageName onCompletion:^(id json) {
        uploadResult = json;
        [self updateUsrLogoRequest];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUsrLogoRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] postUserHeadWithParameters:@{@"UserID":info.userID,@"ImageBase":[uploadResult.detailinfo getString:@"UrlPath"]} onCompletion:^(id json) {
        info.headPicUrl = [uploadResult.detailinfo getString:@"UrlPath"];
        [info synchronize];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserCouponListRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] getUserCouponListWithParameters:@{@"userId":info.userID} onCompletion:^(id json) {
        DataResult* couponResult = json;
        info.userCoupon = [NSString stringWithFormat:@"%ld",couponResult.items.size];
        [info synchronize];
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}


@end
