//
//  NextViewController.m
//  ZYYRandCodeDemo
//
//  Created by liguo.chen on 17/7/5.
//  Copyright © 2017年 Slience. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()<UITextFieldDelegate>

{
    NSInteger count;
}

@property(strong,nonatomic) NSTimer *timer;

@property(strong,nonatomic) NSString *phoneCodeStr;

@property(strong,nonatomic) UIButton *reAskCode;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"NSTimer倒计时"];
    [self setViewAndNavi];
    [self setBackBarButtonItemWithTitle:@"返回"];
    
    UITextField *phoneCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, ScreenWidth - 30, 50)];
    phoneCodeTf.delegate = self;
    phoneCodeTf.placeholder = @"请输入手机验证码";
    phoneCodeTf.textColor = [UIColor blackColor];
    phoneCodeTf.keyboardType = UIKeyboardTypeNumberPad;
    phoneCodeTf.borderStyle = UITextBorderStyleRoundedRect;
    [phoneCodeTf addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:phoneCodeTf];
    
    UIButton *reAskCode = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneCodeTf.frame) + 10, ScreenWidth - 30, 30)];
    [reAskCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [reAskCode.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [reAskCode setBackgroundColor:[UIColor clearColor]];
    reAskCode.enabled = NO;//先设置按钮不能点击
    reAskCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [reAskCode addTarget:self action:@selector(reAskCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reAskCode];
    self.reAskCode = reAskCode;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    count = 60;
    
    //倒计时,每一秒调用一次NSTimer方法
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//实时监听textfield的值的变化,当然也可以用通知
-(void)textValueChanged:(UITextField *)textField {
    
    self.phoneCodeStr = textField.text;
    
}

-(void)reAskCodeAction {
    count = 60;//重新给count赋值
    
    //由于此时self.timer已经被移除了,所以需要重新创建
    //倒计时,每一秒调用一次NSTimer方法
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.reAskCode.enabled = NO;
    [self.reAskCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)countDown {
    count--;
    [self.reAskCode setTitle:[NSString stringWithFormat:@"重新获取验证码(%ld)",count] forState:UIControlStateNormal];
    if (count == 0) {
        
        [self.reAskCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.reAskCode setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.reAskCode.enabled = YES;
        
        [self.timer invalidate];//停止调用NSTimer方法
        self.timer = nil;//移除self.timer
    }
    
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

@end
