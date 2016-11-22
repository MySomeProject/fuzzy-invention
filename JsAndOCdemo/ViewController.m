//
//  ViewController.m
//  JsAndOCdemo
//
//  Created by 张锦辉 on 2016/11/22.
//  Copyright © 2016年 张锦辉. All rights reserved.
//

#import "ViewController.h"
#import "JsCallbackOCViewController.h"
#import "OCcallbackJSViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jsCallbackOC:(id)sender {
    JsCallbackOCViewController* view1 = [[JsCallbackOCViewController alloc]init];
    [self.navigationController pushViewController:view1 animated:YES];
    
}

- (IBAction)OCcallbackJs:(id)sender {
    
    OCcallbackJSViewController *view2 = [[OCcallbackJSViewController alloc]init];
    [self.navigationController pushViewController:view2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
