//
//  ViewController.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/10.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ViewController.h"

#import "ChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor js_colorWithHexString:@"#FFFFFF"];
    
    [self setupNavigation];
    
    [self createButton];
}

#pragma mark Setup Navigation
- (void)setupNavigation {
    NSAttributedString *attributedTitleString = [[NSAttributedString alloc] initWithString:@"主页"
                                                                                attributes:@{
                                                                                             NSForegroundColorAttributeName : [UIColor js_colorWithHexString:@"#FFFFFF"]
                                                                                             }];
    
    [self createNavigationBarWithTitle:attributedTitleString
                         withImageName:@"Navigation"];
}

#pragma mark Create
- (void)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor js_colorWithHexString:@"#FFFFFF"];
    
    [button setTitle:@"点击跳转聊天界面"
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor js_colorWithHexString:@"#000000"]
                 forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(chatClick:)
     forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake((JSSCREEN_W - 200.0f) / 2, (JSSCREEN_H - 64.0f - 50.0f) / 2, 200.0f, 50.0f);
    
    [self.view addSubview:button];
}

#pragma mark Action
- (void)chatClick:(UIButton *)sender {
    ChatViewController *chat = [[ChatViewController alloc] init];
    
    [self.navigationController pushViewController:chat
                                         animated:YES];
}

@end
