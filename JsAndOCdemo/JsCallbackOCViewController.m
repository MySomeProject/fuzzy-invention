//
//  JsCallbackOCViewController.m
//  JsAndOCdemo
//
//  Created by 张锦辉 on 2016/11/22.
//  Copyright © 2016年 张锦辉. All rights reserved.
//

#import "JsCallbackOCViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@protocol WebExport

JSExportAs(
           myLog,
           -(void)myOCLog:(NSString *)string
           );

@end

@interface JsCallbackOCViewController ()<UIWebViewDelegate, WebExport>
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)JSContext *context;


@end

@implementation JsCallbackOCViewController

-(void)myOCLog:(NSString *)string {
    NSLog(@"你好,世界!");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"jsCallOC.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {

    //对JSContext进行初始化
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //验证JSContext是否验证成功
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
        context.exception = exceptionValue;
    };
    
    /*block方式比较简单,也是我比价推荐的一种,但是要注意防止循环引用问题的发生.
     首先我们先说一下不带有参数的函数调用,也就是说我们不需要从网页那边有参数的传值,比如跳转页面等等.代码如下所示.*/
    __weak typeof (self)temp = self;
    self.context[@"myAction"] = ^(){
        [temp.navigationController popViewControllerAnimated:YES];
    };
    
    /*接下来我们看一下,通过页面的传值,我们把H5标签的值作为参数进行传值操作,并且调用OC的block进行打印.*/
    self.context[@"log"] = ^(NSString *str){
        NSLog(@"输入值: %@",str);
    };
    
    /*通过实现JSExport协议方式进行OC与JS的交互,这里我只是简单的实现以下没有参数的函数调用.
     首先,我们在HTML文件中创建一个按钮用来调用OC中JSExport协议方法.*/
    self.context[@"native"] = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
