//
//  UIViewController+photo.h
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (photo)<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  选择器展示页面
 *
 *  @param view 父视图
 */
- (void)showPhotoChooseActionSheetInView:(UIView*)view;
/**
 *  ActionSheet点击选择相册或拍照后调用
 *
 *  @param actionSheet ActionSheet
 *  @param buttonIndex 点击按钮
 */
- (void)photoChooseWithActionSheet:(UIActionSheet *)actionSheet
              clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
