//
//  ViewController.m
//  Multiply
//
//  Created by Rockstar. on 3/9/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UISlider *numberSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *operatorSegmentControl;

@property (nonatomic) int multiplier;
@property (nonatomic) int result;



@end

@implementation ViewController


#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    //Set up slider, set initial value of 10 and make it animated.
    //Set slider to be continous and set a min and max value.
    //Add target to for event value change of slider from 0 - 10.
    [self.numberSlider setValue:10.0 animated:YES];
    self.numberSlider.continuous = YES;
    self.numberSlider.minimumValue = 0.0;
    self.numberSlider.maximumValue = 10.0;
    [self.numberSlider addTarget:self action:@selector(updateNumber:) forControlEvents:UIControlEventValueChanged];
    NSLog(@"Current value: %f", self.numberSlider.value);

    // Do any additional setup after loading the view, typically from a nib.
}




#pragma mark - Actions
- (IBAction)updateNumber:(UISlider *)sender {
    //Update multiplier label with slider value.
    self.multiplierLabel.text = [NSString stringWithFormat:@"%.0f", self.numberSlider.value];
    self.multiplier = self.numberSlider.value;
    
}


- (IBAction)onCalculateButtonPressed:(id)sender {
    // Set initial value for multiplier of 10.
    self.multiplier = self.numberSlider.value;

    //Save number entered in textfield.
    int numberEntered = self.numberTextField.text.intValue;


    //--------------------------
    // Operands using index of segmented control.
    //--------------------------

    // Index 0 = multiplication
    // Index 1 = division
    // Index 2 = addition
    // INdex 3 = substraction
    if (self.operatorSegmentControl.selectedSegmentIndex == 0) {
        self.result = numberEntered * self.multiplier;
    } else if (self.operatorSegmentControl.selectedSegmentIndex == 1){
        self.result = numberEntered / self.multiplier;
    } else if (self.operatorSegmentControl.selectedSegmentIndex == 2) {
        self.result = numberEntered + self.multiplier;
    } else {
        self.result = numberEntered - self.multiplier;
    }

    // Store operation final value.
    // Update label with final value.
    NSString *final = [NSString stringWithFormat:@"%i", self.result];
    self.answerLabel.text = final;

    //CHange screen depending on final result
    if (self.result >= 20) {
        self.view.backgroundColor = [UIColor greenColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }


    //------------
    // FizzBuzz
    //------------
    if (self.result % 3 == 0 && self.result % 5 == 0) {
        self.answerLabel.text = [NSString stringWithFormat:@"%i, FizzBuzz", self.result];
    } else if (self.result % 5 == 0) {
        self.answerLabel.text = [NSString stringWithFormat:@"%i, Buzz", self.result];
    } else if (self.result % 3 == 0) {
        self.answerLabel.text = [NSString stringWithFormat:@"%i, Fizz", self.result];
    } else {
        self.answerLabel.text = final;
    }

    //------------------
    // Dismiss Keyboard
    //------------------
    [self.numberTextField resignFirstResponder];
}


#pragma mark - UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
@end
