//
//  Pay_maskView.m
//  XHPayTextfield
//
//  Created by XH on 16/11/23.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "Pay_maskView.h"
#import "Pay_TextField.h"

@interface Pay_maskView ()
@property (nonatomic,weak) Pay_TextField *textField;

@end

@implementation Pay_maskView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIView *payTextView = [[UIView alloc] initWithFrame:CGRectMake(0, kheight - 150, kwidth, 150)];
        payTextView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:payTextView];
        
        
        
        UILabel *titleLalel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 20)];
        titleLalel.font = [UIFont systemFontOfSize:13];
        titleLalel.text = @"请输入交易密码";
        titleLalel.textAlignment = NSTextAlignmentCenter;
        titleLalel.textColor = [UIColor whiteColor];
        [payTextView addSubview:titleLalel];

        
        Pay_TextField *textField = [[Pay_TextField alloc] initWithFrame:CGRectMake(25, (payTextView.frame.size.height - 45 ) * 0.5, self.frame.size.width - 50, 50)];
        [payTextView addSubview:textField];
        [textField addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
        self.textField = textField;
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        removeButton.frame = CGRectMake(0 , 0, kwidth, kheight - payTextView.frame.size.height);
        [removeButton addTarget:self action:@selector(removeButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        
        
        
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(textField.frame) + 10, 200, 20)];
        errorLabel.text = @"你还有5次机会,请重新收入密码";
        errorLabel.font = [UIFont systemFontOfSize:13];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.textColor = [UIColor whiteColor];
        [payTextView addSubview:errorLabel];
        
        
        UIButton *clearPassword = [UIButton buttonWithType:UIButtonTypeCustom];
        clearPassword.frame = CGRectMake(self.frame.size.width - 90, CGRectGetMaxY(textField.frame) + 10, 70, 20);
        clearPassword.titleLabel.font = [UIFont systemFontOfSize:15];
        clearPassword.backgroundColor = [UIColor redColor];
        [clearPassword setTitle:@"清空密码" forState:UIControlStateNormal];
        [clearPassword addTarget:self action:@selector(removeTextField) forControlEvents:UIControlEventTouchUpInside];
        [payTextView addSubview:clearPassword];
        
        
        
        // 监听键盘
        [self registerForKeyboardNotifications];
    }
    return self;
}
- (void)textFiledEdingChanged{
    
    self.textField.showDotLabel = self.textField.text;
    if (self.textField.text.length == kPasswordLength) {
        if ([self.delegate respondsToSelector:@selector(Pay_maskViewPassWord:)]) {
            [self.delegate Pay_maskViewPassWord:self.textField.text];
        }
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
}

- (void)showView:(UIView *)view{
    [view addSubview:self.textField];
    [self.textField becomeFirstResponder];
}

- (void)removeButtonDown{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

    [self removeFromSuperview];
}

+(Pay_maskView *)showWithDelegateOwer:(id)target andAddView:(UIView *)view{
    
    Pay_maskView *maskView = [[Pay_maskView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight )];
    [view addSubview:maskView];
    maskView.delegate = target;
    [maskView.textField becomeFirstResponder];
    return maskView;
    
}
//  移除字符串
- (void)removeTextField{
    
    self.textField.text = nil;
    
    for(NSInteger i=0;i<kPasswordLength;i++){
        
        UILabel *dotLabel = (UILabel *)[self viewWithTag:kDotTag + i];
        
        dotLabel.hidden = YES;
    }
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

}
@end
