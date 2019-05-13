//
//  MineViewController.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "AnimationViewController.h"
//#import "UIViewController+Animation.h"
@interface AnimationViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 300, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    textField.leftView.backgroundColor = [UIColor lightGrayColor];
    textField.leftViewMode = UITextFieldViewModeUnlessEditing;
    textField.text = @"我是一个text";
    [self.view addSubview:textField];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}


- (IBAction)dismissAutoReverseAnimationAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"%@释放了",[self class]);
}


@end
