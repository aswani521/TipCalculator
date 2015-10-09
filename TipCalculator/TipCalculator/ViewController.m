//
//  ViewController.m
//  TipCalculator
//
//  Created by venkata aswani nerella on 9/28/15.
//  Copyright (c) 2015 com.test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//properties for all UI elements in the design
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *splitCtrl;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipCtrl;
@property (weak, nonatomic) IBOutlet UILabel *totalBillLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmtLabel;


- (IBAction)onTap:(id)sender;

- (void) updateValues;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Add a "DONE" button on top of the keyboard
    UIToolbar *tipToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    tipToolbar.barStyle = UIBarStyleBlackOpaque;
    tipToolbar.items = [NSArray arrayWithObjects:
                        //1
                        [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                            target:nil
                            action:nil],
                        
                        //3
                        [[UIBarButtonItem alloc]
                            initWithTitle:@"DONE"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(textFieldDone)],
                        nil];
    [tipToolbar sizeToFit];
     
    
    self.billTextField.inputAccessoryView = tipToolbar;
    
    //To clear content of textfield when editing starts;
    //Can be set through the UI as well.
    self.billTextField.clearsOnBeginEditing = YES;
    
}

//Call this when the DONE button is pressed
- (void)textFieldDone
{
    
    
    //Update values since tip percent or splits might have changed
    [self updateValues];
    
    [self.billTextField resignFirstResponder];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.billTextField becomeFirstResponder];
    
    //Get userdefaults from settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultTipSegmentIndex = [defaults integerForKey:@"default_tip_percentage"];
    NSInteger defaultSplitSegmentIndex = [defaults integerForKey:@"default_split"];
    
    [self.tipCtrl setSelectedSegmentIndex:defaultTipSegmentIndex];
    [self.splitCtrl setSelectedSegmentIndex:defaultSplitSegmentIndex];
    
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipCtrlChanged:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount    = [self.billTextField.text floatValue];
    NSArray *tipValues  = @[@(0.1),@(0.15),@(0.2)];
    NSArray *splitValues= @[@(1), @(2), @(3), @(4), @(5)];
    
    float tipValue = billAmount*[tipValues[self.tipCtrl.selectedSegmentIndex] floatValue];
    float totalBill = (billAmount + tipValue)/[splitValues[self.splitCtrl.selectedSegmentIndex] floatValue];
    
    
    //self.tipAmtLabel.text  = [NSString stringWithFormat:@"$%0.2f",tipValue];
    //self.billAmtLabel.text = [NSString stringWithFormat:@"$%0.2f",totalBill];
    
    NSNumberFormatter* numberformatter = [[NSNumberFormatter alloc]init];
    [numberformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.tipAmtLabel.text = [numberformatter stringFromNumber:[[NSNumber alloc]initWithFloat:tipValue]];
    self.billAmtLabel.text = [numberformatter stringFromNumber:[[NSNumber alloc]initWithFloat:totalBill]];
    
}



@end
