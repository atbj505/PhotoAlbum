//
//  photoLibrary.m
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "photoLibrary.h"

#define SET_PICKER_SOURCE_TYPE(__picker, __sourceType) \
if ([UIImagePickerController isSourceTypeAvailable:__sourceType]) {\
__picker.sourceType = __sourceType;\
}\
else{\
NSLog(@"error");\
NSDictionary *dic = @{@"error":@"hardware error"};\
[self.delegate getPhotoFailedInfo:dic];\
return;\
}

@implementation photoLibrary{
    UIViewController *_vc;
}

CLASS_SINGLETON_IMPLEMENTATION(photoLibrary)

//- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//    imagePicker.delegate = self;
//    self.delegate = (id)viewController;
//    
//    SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypePhotoLibrary);
//    
//    [viewController presentViewController:imagePicker animated:YES completion:nil];
//}
- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController{
    self.delegate = (id)viewController;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:viewController.view];
    _vc = viewController;
}
#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    NSLog(@"%@",actionSheet.subviews);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.delegate getPhotoSucceedInfo:info];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
