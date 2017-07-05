//
//  BaseViewController.h
//  ZYYRandCodeDemo
//
//  Created by liguo.chen on 17/7/5.
//  Copyright © 2017年 Slience. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth   ([UIScreen mainScreen].bounds.size.width)

@interface BaseViewController : UIViewController

//设置返回按钮标题
- (void)setBackBarButtonItemWithTitle:(NSString *)title;

//判断是否是合法的手机号码(网上的方法😁)
- (BOOL)isMobileNumber:(NSString *)mobileNum;

//设置导航栏标题
-(void)setNaviTitle:(NSString *)title;

//设置背景颜色,导航栏颜色,导航栏字体颜色和字体大小,导航栏标题,导航栏是否透明等,如果有需要设置其他的,可以私信我
-(void)setViewAndNavi;

//展示alert对话框提示
-(void)showAlertView:(NSString *)msgStr;

@end
