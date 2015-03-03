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
 *  @param info 回调返回数据字典
 */
- (void)getPhotoSucceedInfo:(NSDictionary *)info;

/**
 *  获取图片失败回调
 *
 *  @param info 回调返回错误信息
 */
- (void)getPhotoFailedInfo:(NSDictionary *)info;

@end

@interface photoLibrary : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, weak)id<photoLibraryDelegate>delegate;

CLASS_SINGLETON_INTERFACE(photoLibrary)

/**
 *  获取图片库
 *
 *  @param viewController 图片库父视图
 */
- (void)getPhotoLibraryInSuperViewController:(UIViewController*)viewController;

@end
