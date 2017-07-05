# ZYYRandCodeDemo
使用NSTimer实现倒计时
很多时候,发送验证码时需要实现用户再次获取验证码,有的是不跳界面的,有的是跳界面的,今天就说一下输完手机号码后跳界面计入倒计时的方法,如有更好的方法,请私信我,谢谢.
其实主要的代码没有多少,我简单的说一下思路.
首页进入到界面的时候就要创建NSTimer,实现方法.我们以60秒倒计时为例,那么就要每一秒都要调用一次NSTimer的方法.代码如下:

      count = 60;
    
    //倒计时,每一秒调用一次NSTimer方法
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

然后就是在countDown方法里实现倒计时,首先肯定是要每秒递减的,那么就是

    count--;//秒数递减

这个时候需要显示按钮的文字+倒计时秒数

    [self.reAskCode setTitle:[NSString stringWithFormat:@"重新获取验证码(%ld)",count] forState:UIControlStateNormal];

当count=0时,需要改变按钮的文字显示,并且是timer不可再使用,也就是不再调用countDown方法.

    if (count == 0) {
        
        [self.reAskCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.reAskCode setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.reAskCode.enabled = YES;//设置按钮此时可以点击
        
        [self.timer invalidate];//停止调用NSTimer方法
        self.timer = nil;//移除self.timer
    }

然后在按钮的点击事件里,由于count已经倒计时到0了,所以需要给count重新赋值,即count = 60.
而此时timer已经被移除,所以需要重新创建timer,方法还是用countDown方法.

    -(void)reAskCodeAction {
        count = 60;//重新给count赋值
    
        //由于此时self.timer已经被移除了,所以需要重新创建
        //倒计时,每一秒调用一次NSTimer方法
        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
        self.reAskCode.enabled = NO;//设置按钮不可用
        [self.reAskCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
思路就是这个思路,如果有好的方法,希望可以告诉我一下,非常感谢.

另外里面也整理了一些公共方法,在BaseViewController里面,方便调用.

    //设置返回按钮标题
    - (void)setBackBarButtonItemWithTitle:(NSString *)title {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"NavBackSorrow"] forState:UIControlStateNormal];
        [btn setContentMode:UIViewContentModeScaleAspectFill];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
        [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }

    //返回按钮点击事件
    -(void)backAction:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //设置导航栏标题
    -(void)setNaviTitle:(NSString *)title {
        self.navigationItem.title = title;
    }

    //设置背景颜色,导航栏颜色,导航栏字体颜色和字体大小,导航栏是否透明等,如果有需要设置其他的,可以私信我
    -(void)setViewAndNavi {
    
        [self.view setBackgroundColor:[UIColor whiteColor]];
    
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
        [self.navigationController.navigationBar setTitleTextAttributes:
     
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
        self.navigationController.navigationBar.translucent = NO;//导航栏呈现半透明状态的属性,NO为不透明,YES为透明
    
        //去掉导航栏下面的黑线
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            for (UIView *subview in view.subviews) {
                if (subview.bounds.size.height <= 1 ) {
                    NSLog(@"%f", subview.bounds.size.height);
                    [subview removeFromSuperview];
                }
            }
        }
    
    }

    //展示alert对话框提示
    -(void)showAlertView:(NSString *)msgStr {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msgStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
