//
//  PhotoView.m
//  GOTour
//
//  Created by 磊 田 on 15/10/20.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface PhotoView()

@property (nonatomic, weak) UIControl *control;

@end
@implementation PhotoView

- (UIControl *)control
{
    
    if (_control == nil) {
        
        UIControl *con = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        con.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [con addTarget:self action:@selector(outAvtion:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _control;
    
}
- (instancetype)init
{
    if (self = [super init]) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
        
        //长按保存图片到相册
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self addGestureRecognizer:longPress];
    }


    return self;
}

// Adds a photo to the saved photos album.  The optional completionSelector should have the form:
//  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

//UIKIT_EXTERN void UIImageWriteToSavedPhotosAlbum(UIImage *image, __nullable id completionTarget, __nullable SEL completionSelector, void * __nullable contextInfo);

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
        UIWindow *win = [[UIApplication sharedApplication] keyWindow];
        [win addSubview:self.control];
        
        //    UIImageView *imageV = (UIImageView *)longPress.view;
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"确认保存图片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [alertV show];
        //保存图片到相册
        
    }
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
    
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    }


}

- (void)complent
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
}
/**
 * 用于会调
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSString *_str = nil;
    
    if (error == nil ) {
        
        _str = @"保存图片成功";
        
    }else{
        
        _str = @"保存图片失败";
        
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    [alert show];
    
    NSLog(@"——————————%@",contextInfo);
    
}
- (void)outAvtion:(UIControl *)con
{
    [con removeFromSuperview];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _imageUrls.count; i ++) {
        
        MJPhoto *photo = [[MJPhoto alloc]init];
        
        photo.url =[NSURL URLWithString:_imageUrls[i]]; 
        photo.srcImageView = self;
        
        [array addObject:photo];
    }
    
    int i = 0;
    for (NSString *str in _imageUrls) {
        i++;
        if ([str isEqualToString:_urlStr]) {
            break;
        }
        
    }
    
    browser.currentPhotoIndex = i - 1;
    browser.photos = array;
        
    
    [browser show];
    
    
//    UIControl *control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [control addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    _control =control;
//    control.backgroundColor = [UIColor blackColor];
//    
//    UIWindow *keyW = [[UIApplication sharedApplication] keyWindow];
//    [keyW addSubview:control];
//    
//    //添加图片
//    UIImageView *imageV = [[UIImageView alloc] initWithImage:self.image];
//    imageV.frame = [keyW convertRect:self.frame fromView:self.superview];
//
//    [control addSubview:imageV];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        CGRect frame = imageV.frame;
//        frame.size.width = kScreenWidth;
//        frame.size.height =kScreenWidth*(imageV.image.size.height/imageV.image.size.width);
//        frame.origin = CGPointMake(0, (kScreenHeight - frame.size.height)/2);
//        
//        imageV.frame = frame;
//    }];
//    
//    
//
    
}

//- (void)backAction
//{
//    
//    
//    [UIView animateWithDuration:2 animations:^{
//        
//        _control.alpha = 0;
//        
//    }];
////[_control removeFromSuperview];
//
//}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = [urlStr copy];
    
    [self sd_setImageWithURL:[NSURL URLWithString:_urlStr] placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    
}
@end
