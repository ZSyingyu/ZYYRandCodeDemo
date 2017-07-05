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
