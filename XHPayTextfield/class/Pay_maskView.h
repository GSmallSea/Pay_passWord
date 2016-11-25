//
//  Pay_maskView.h
//  XHPayTextfield
//
//  Created by XH on 16/11/23.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kwidth [UIScreen mainScreen].bounds.size.width // 全屏宽度
#define kheight [UIScreen mainScreen].bounds.size.height // 全屏高度


@protocol Pay_maskViewDelegate <NSObject>

- (void)Pay_maskViewPassWord:(NSString *)password;

@end

@interface Pay_maskView : UIView

@property (nonatomic,assign) id <Pay_maskViewDelegate> delegate;

/**清空字符串*/
- (void)removeTextField;

-(void)showView:(UIView *)view;

+(Pay_maskView *)showWithDelegateOwer:( id) target andAddView:(UIView *)view;
@end
