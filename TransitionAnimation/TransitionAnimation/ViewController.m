//
//  ViewController.m
//  TransitionAnimation
//
//  Created by 吕其瑞  on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "ViewController.h"
#import "TransitionAnimationType.h"
#import "AnimationViewController.h"
#import "UIViewController+Animation.h"
#import "AAPLCustomPresentationController.h"
#import "AAPLCustomPresentationSecondViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSIndexPath * indexPath;

@end

@implementation ViewController


static NSArray *pushArray = nil;
static NSArray *presentArray = nil;
static NSArray *customPresentArry = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    pushArray= @[@"LQR_TransitionTypeSysPushFromRight",
                  @"LQR_TransitionTypeSysPushFromLeft",
                  @"LQR_TransitionTypeSysPushFromTop",
                  @"LQR_TransitionTypeSysPushFromBottom",
                  
                  @"LQR_TransitionTypeSysRevealFromRight",
                  @"LQR_TransitionTypeSysRevealFromLeft",
                  @"LQR_TransitionTypeSysRevealFromTop",
                  @"LQR_TransitionTypeSysRevealFromBottom",
                  
                  @"LQR_TransitionTypeSysMoveInFromRight",
                  @"LQR_TransitionTypeSysMoveInFromLeft",
                  @"LQR_TransitionTypeSysMoveInFromTop",
                  @"LQR_TransitionTypeSysMoveInFromBottom",
                  
                  @"LQR_TransitionTypeSysCubeFromRight",
                  @"LQR_TransitionTypeSysCubeFromLeft",
                  @"LQR_TransitionTypeSysCubeFromTop",
                  @"LQR_TransitionTypeSysCubeFromBottom",
                  
                  @"LQR_TransitionTypeSysOglFlipFromRight",
                  @"LQR_TransitionTypeSysOglFlipFromLeft",
                  @"LQR_TransitionTypeSysOglFlipFromTop",
                  @"LQR_TransitionTypeSysOglFlipFromBottom",
                  
                  @"LQR_TransitionTypeSysPageCurlFromRight",
                  @"LQR_TransitionTypeSysPageCurlFromLeft",
                  @"LQR_TransitionTypeSysPageCurlFromTop",
                  @"LQR_TransitionTypeSysPageCurlFromBottom",
            
                  @"LQR_TransitionTypeSysCameraIrisHollow"];
    
    
    presentArray= @[@"LQR_TransitionPresentTypeSpreadFromRight",
                    @"LQR_TransitionPresentTypeSpreadFromLeft",
                    @"LQR_TransitionPresentTypeSpreadFromTop",
                    @"LQR_TransitionPresentTypeSpreadFromBottom",
                    @"LQR_TransitionPresentTypePage",
                    @"LQR_TransitionPresentTypeCover",
                    @"LQR_TransitionPresentTypeCrossDissolve",
                    @"LQR_TransitionPresentTypeCheckerboard"];

    customPresentArry = @[@"LQR_CustomPresentTransitionFirst"];
    
}


#pragma mark-----代理方法


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        AAPLCustomPresentationSecondViewController *secondViewController = [[AAPLCustomPresentationSecondViewController alloc] init];
        
        AAPLCustomPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
        
        presentationController = [[AAPLCustomPresentationController alloc] initWithPresentedViewController:secondViewController presentingViewController:self];
        
        secondViewController.transitioningDelegate = presentationController;
        
        [self presentViewController:secondViewController animated:YES completion:NULL];
        
        return ;
    }
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AnimationViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"AnimationViewController"];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否使用动画?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *normalAction = [UIAlertAction actionWithTitle:@"不使用动画" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];
    UIAlertAction *animationAction = [UIAlertAction actionWithTitle:@"使用动画" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUInteger selectIndex = indexPath.row + 1;
        switch (indexPath.section) {
            case 0:
            {
                [self pushViewController:vc animationType:selectIndex complete:^{
                    NSLog(@"pushViewController 动画结束");
                }];
            }
                break;
            case 1:
            {
                [self presentViewController:vc animationType:selectIndex complete:^{
                    NSLog(@"presentViewController 动画结束");
                }];
            }
                break;
            default:
                break;
        }
    }];
    [alertVC addAction:normalAction];
    [alertVC addAction:animationAction];
                                      
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return LQR_TransitionTypeSysCameraIrisHollow;
            break;
        case 1:
            return LQR_TransitionPresentTypeCheckerboard;
            break;
        case 2:
            return LQR_CustomPresentTransitionFirst;
            break;
        default:
            return 0;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = pushArray[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = presentArray[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = customPresentArry[indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor purpleColor];
    label.textColor = [UIColor whiteColor];
    switch (section) {
        case 0:
            label.text = @"PushAnimation";
            break;
        case 1:
            label.text = @"PresentAnimation";
            break;
        case 2:
            label.text = @"CustomPresentViewController";
            break;
        default:
            break;
    }
    return label;
}




@end
