//
//  ViewController.m
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+photo.h"
#import "photoLibrary.h"

@interface ViewController () <photoLibraryDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 方法1:UIViewController+photo
    //[self showPhotoChooseActionSheetInView:self.view];
    // 方法2:photoLibrary
    [[photoLibrary sharephotoLibrary] getPhotoLibraryInSuperViewController:self];
}
#pragma mark -
#pragma mark 方法1UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self photoChooseWithActionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
}
#pragma mark ChoosePhoto 相册选择回调

- (void)photoChoose:(UIImagePickerController *)picker originalImage:(UIImage *)originalImage editedImage:(UIImage *)editedImage{
    NSLog(@"original:%@",originalImage);
    NSLog(@"editedImage:%@",editedImage);
}

#pragma mark -
#pragma mark 方法2
- (void)getPhotoSucceedOriginalImage:(UIImage *)originalImage editedImage:(UIImage *)editedImage{
    NSLog(@"%@",originalImage);
    NSLog(@"%@",editedImage);
}
- (void)getPhotoFailedInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
}
@end
