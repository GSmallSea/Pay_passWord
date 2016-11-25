//
//  Pay_TextField.m
//  XHPayTextfield
//
//  Created by XH on 16/11/23.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "Pay_TextField.h"
#define LinebgColor [UIColor redColor]
#define DotLabelbgColor [UIColor redColor]

@implementation Pay_TextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        self.tintColor = [UIColor clearColor];
        self.textColor = [UIColor clearColor];
        self.keyboardType = UIKeyboardTypeNumberPad;
        CGFloat Width = self.frame.size.width / kPasswordLength;
        for (int i = 0; i < kPasswordLength; i++) {

            CGFloat lineX = i * Width;
            CGFloat lineY = 0;
            CGFloat lineW = 1;
            CGFloat lineH = self.frame.size.height;
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = LinebgColor;
            line.frame = CGRectMake(lineX, lineY, lineW, lineH);
            
            [self addSubview:line];

            UILabel *dotLabel = [[UILabel alloc] init];
            CGFloat dotLabelW = 10;
            CGFloat dotLabelH = 10;
            CGFloat dotLabelX = lineX + (Width - dotLabelW) * 0.5;
            CGFloat dotLabelY = (lineH - dotLabelH) * 0.5;
            dotLabel.frame = CGRectMake(dotLabelX, dotLabelY, dotLabelW, dotLabelH);
            dotLabel.layer.masksToBounds = YES;
            dotLabel.layer.cornerRadius = dotLabelW * 0.5;
            dotLabel.backgroundColor = DotLabelbgColor;
            dotLabel.hidden = YES;
            dotLabel.tag = kDotTag + i;
            [self addSubview:dotLabel];
            
        }
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        view.userInteractionEnabled = NO;
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
    }
    return self;
}

- (void)setShowDotLabel:(NSString *)showDotLabel{
    _showDotLabel = showDotLabel;
    
    for (int i = 0; i < kPasswordLength; i++) {
        UILabel *dotlabel = [self viewWithTag:kDotTag+i];
        if (dotlabel) dotlabel.hidden = showDotLabel.length <= i;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu){ menu.menuVisible = NO;}
    return NO;
}

@end
