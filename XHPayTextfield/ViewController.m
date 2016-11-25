//
//  ViewController.m
//  XHPayTextfield
//
//  Created by XH on 16/11/23.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "ViewController.h"
#import "Pay_maskView.h"
@interface ViewController ()<Pay_maskViewDelegate>
@property (nonatomic,weak) Pay_maskView *payView;
- (IBAction)buttonDown:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];


}



- (IBAction)buttonDown:(id)sender {
    Pay_maskView *view = [Pay_maskView showWithDelegateOwer:self andAddView:self.view];
    self.payView = view;
}


- (void)Pay_maskViewPassWord:(NSString *)password{
    
    NSLog(@"请求服务器去吧---- ");
}
@end
