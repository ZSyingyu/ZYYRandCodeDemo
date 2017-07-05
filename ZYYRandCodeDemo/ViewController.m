//
//  ViewController.m
//  ZYYRandCodeDemo
//
//  Created by liguo.chen on 17/7/5.
//  Copyright © 2017年 Slience. All rights reserved.
//

#import "ViewController.h"

#import "NextViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property(strong,nonatomic) NSString *phoneNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"NSTimer倒计时按钮Demo"];
    [self setViewAndNavi];
    
    UITextField *phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, ScreenWidth - 30, 50)];
    phoneTf.delegate = self;
    phoneTf.placeholder = @"请输入手机号码";
    phoneTf.textColor = [UIColor blackColor];
    phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    phoneTf.borderStyle = UITextBorderStyleRoundedRect;
    [phoneTf addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:phoneTf];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneTf.frame) + 40, ScreenWidth - 30, 50)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [nextBtn setBackgroundColor:[UIColor redColor]];
    nextBtn.layer.cornerRadius = 5.0;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

//实时监听textfield的值的变化,当然也可以用通知
-(void)textValueChanged:(UITextField *)textField {
    
    self.phoneNum = textField.text;
    
}

-(void)nextAction {
    
    if ([self isMobileNumber:self.phoneNum] == YES) {
        
        NextViewController *nextVc = [[NextViewController alloc] init];
        
        [self.navigationController pushViewController:nextVc animated:YES];
        
    }else {
        
        [self showAlertView:@"请输入正确的手机号码"];
        
    }
    
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

@end
