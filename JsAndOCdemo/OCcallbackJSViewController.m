//
//  OCcallbackJSViewController.m
//  JsAndOCdemo
//
//  Created by 张锦辉 on 2016/11/22.
//  Copyright © 2016年 张锦辉. All rights reserved.
//我们说一下如何使用JavaScriptCore让OC调用JavaScript函数,使用JavaScriptCore进行OC调用JavaScript函数是很容易进行传值操作的.首先我们需要在HTML文件创建爱你一个带有id的标签以及一个JavaScript函数.代码如下所示

#import "OCcallbackJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCcallbackJSViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)JSContext *context;
@end

@implementation OCcallbackJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"改变" style:UIBarButtonItemStyleDone target:self action:@selector(changeWebTxet)];
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ocCallJS.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {

    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptonValue){
    
        context.exception = exceptonValue;
    };
}

-(void)changeWebTxet{
    
    /*下面就是实现方法,首先我们要先通过JSContext对象获取到JS中的对应函数并且使用JSValue对象进行接收.
     然后我们通过使用- (JSValue *)callWithArguments:(NSArray *)arguments;进行JS函数的调用,
     当然了这里的JS函数没有返回值,我也就没有做接收返回值的工作.*/

    JSValue *labelAction = self.context[@"labelAction"];
    [labelAction callWithArguments:@[@"你好，张锦辉",@"是的，我很好"]];
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
