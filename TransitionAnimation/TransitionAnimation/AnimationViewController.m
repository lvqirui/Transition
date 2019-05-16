//
//  MineViewController.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "AnimationViewController.h"
//#import "UIViewController+Animation.h"
#import "FinalViewController.h"
@interface AnimationViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}


- (IBAction)dismissAutoReverseAnimationAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushViewControllerAction:(UIButton *)sender {
    
    FinalViewController *vc = [[FinalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)presentViewControllerAction:(UIButton *)sender {
    
    FinalViewController *vc = [[FinalViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"%@释放了",[self class]);
}


@end
