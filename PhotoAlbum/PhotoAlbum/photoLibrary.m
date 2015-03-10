//
//  photoLibrary.m
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "photoLibrary.h"

@interface photoLibrary()

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation photoLibrary

static photoLibrary *sharedPhotoLibrary;

/**
 *  单例方法
 *
 *  @return 实例变量
 */
+ (photoLibrary *)sharephotoLibrary{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPhotoLibrary = [[self alloc] init];
    });
    return sharedPhotoLibrary;
}

/**
 *  show actionSheet
 *
 *  @param viewController 父视图控制器
 */
- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController{
    self.delegate = (id)viewController;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相机",@"相册", nil];
    [actionSheet showInView:viewController.view];
    
    _vc = viewController;
}
#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    NSLog(@"%@",actionSheet.subviews);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    switch (buttonIndex) {
        case 0:
            SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypeCamera);
            break;
        case 1:
            SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypePhotoLibrary);
            break;
        default:
            return;
    }
    [_vc presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 原图
    UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 编辑图
    UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self.delegate getPhotoSucceedOriginalImage:originalImage editedImage:editedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
