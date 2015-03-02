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

@implementation photoLibrary

CLASS_SINGLETON_IMPLEMENTATION(photoLibrary)

- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    self.delegate = viewController;
    
    SET_PICKER_SOURCE_TYPE(imagePicker, UIImagePickerControllerSourceTypePhotoLibrary);
    
    [viewController presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.delegate getPhotoSucceedInfo:info];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
