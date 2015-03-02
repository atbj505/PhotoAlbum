//
//  UIViewController+photo.m
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "UIViewController+photo.h"
#import <objc/message.h>

#define CHOOSE_PHOTO_SHEET_TAG 9001
#define SET_PICKER_SOURCE_TYPE(__picker, __sourceType) \
if ([UIImagePickerController isSourceTypeAvailable:__sourceType]) {\
__picker.sourceType = __sourceType;\
}\
else{\
    NSLog(@"error");\
    return;\
}
@implementation UIViewController (photo)
- (void)showPhotoChooseActionSheetInView:(UIView*)view{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"相册", nil];
    action.tag = CHOOSE_PHOTO_SHEET_TAG;
    [action showInView:view];
}
#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    for (UIView *view in actionSheet.subviews) {
        UIButton *button = (UIButton *)view;
        button.tintColor = [UIColor blackColor];
    }
}
- (void)photoChooseWithActionSheet:(UIActionSheet *)actionSheet
              clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag != CHOOSE_PHOTO_SHEET_TAG) {
        return;
    }
    if (buttonIndex == 2) {
        NSLog(@"取消");
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
#warning imagePicker.sourceType的默认值是0（UIImagePickerControllerSourceTypePhotoLibrary）
    NSLog(@"%d",imagePicker.sourceType);
    
    switch (buttonIndex) {
        case 0:
            SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypeCamera);
            break;
        case 1:
            SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypePhotoLibrary);
            break;
        default:
            break;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 原图
    UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // 编辑图
    UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    ((void(*)(id,SEL,id,id,id))objc_msgSend)(self, @selector(photoChoose:originalImage:editedImage:), picker, originalImage, editedImage);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
