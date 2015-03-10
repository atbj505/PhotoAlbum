//
//  photoLibrary.h
//  PhotoAlbum
//
//  Created by Robert on 15/3/2.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol photoLibraryDelegate <NSObject>

/**
 *  获取照片成功回调
 *
 *  @param originalImage 原始图片
 *  @param editedImage   编辑后图片
 */
- (void)getPhotoSucceedOriginalImage:(UIImage *)originalImage editedImage:(UIImage *)editedImage;

/**
 *  获取图片失败回调
 *
 *  @param info 回调返回错误信息
 */
- (void)getPhotoFailedInfo:(NSDictionary *)info;

@end

@interface photoLibrary : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, weak) id<photoLibraryDelegate>delegate;

/**
 *  单例方法
 *
 *  @return 实例变量
 */
+ (photoLibrary *)sharephotoLibrary;

/**
 *  获取图片库
 *
 *  @param viewController 图片库父视图
 */
- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController;

@end
