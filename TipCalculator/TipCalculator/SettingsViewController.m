//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by venkata aswani nerella on 10/6/15.
//  Copyright (c) 2015 com.test. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultSplitControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
- (IBAction)onSplitValueChange:(id)sender;
- (IBAction)onTipValueChange:(id)sender;
- (void)updateDefaults;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultTipSegmentIndex = [defaults integerForKey:@"default_tip_percentage"];
    NSInteger defaultSplitSegmentIndex = [defaults integerForKey:@"default_split"];

    [self.defaultSplitControl setSelectedSegmentIndex:defaultSplitSegmentIndex];
    [self.defaultTipControl setSelectedSegmentIndex:defaultTipSegmentIndex];
    
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

- (void) viewWillDisappear:(BOOL)animated {
    [self updateDefaults];
}

- (IBAction)onSplitValueChange:(id)sender {
    [self updateDefaults];
}

- (IBAction)onTipValueChange:(id)sender {
    [self updateDefaults];
}

- (void) updateDefaults {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultSplitControl.selectedSegmentIndex  forKey:@"default_split"];
    [defaults setInteger:self.defaultTipControl.selectedSegmentIndex forKey:@"default_tip_percentage"];
    [defaults synchronize];
}

@end
