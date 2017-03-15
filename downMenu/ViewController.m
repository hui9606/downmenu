//
//  ViewController.m
//  downMenu
//
//  Created by qingyun on 17/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MenuOption.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMenuOption:) name:@"menuOptionNotification" object:nil];
 
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    MenuOption *menu =[MenuOption menu];
    menu.contentArray=@[@"按发布时间",@"按价格",@"取消"];
    [menu showTableViewMenuFrom:sender];
    
    //弹出下拉菜单
    NSLog(@"排序按钮点击了");


    
    
}

#pragma  mark - 接收到排序条件
-(void)getMenuOption:(NSNotification *)noti{
    
    NSNumber *selectedIndex=noti.userInfo[@"selectedIndex"];
    NSLog(@"用户点击了%@",selectedIndex);

}


-(void)dealloc{    
    //销毁 通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
