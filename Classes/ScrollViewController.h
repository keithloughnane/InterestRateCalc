//
//  ScrollViewController.h
//  MonthlyInterest
//
//  Created by keith.loughnane on 27/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"


@interface ScrollViewController : UIScrollView <UIPickerViewDataSource, UIPickerViewDelegate>  {
    IBOutlet UISlider *amountSlider;
    IBOutlet UISlider *APRSlider;
    IBOutlet UISlider *termSlider;
    
    IBOutlet UITextField *amountField;
    IBOutlet UITextField *APRField;
    IBOutlet UITextField *termField;
    
    IBOutlet UIPickerView *paymentPicker;
    
    IBOutlet UISegmentedControl *repaySeg;
    IBOutlet UISegmentedControl *typeSeg;
    
    //IBOutlet UIBarButtonItem;
    
    NSMutableArray *arrayColors;
    
    IBOutlet UIToolbar *tBar;
    
    NSString *paymentString;
    
    
    double APRSlideConvertion, princSlideConvertion, termSlideConvertion;
    
    
    
    double APR;
    double principleAmount;
    int numberOfMonths;
    double monthlyPayment;
    NSMutableArray *TotalOwedRemaing;
    NSMutableArray *PrincipleOwedRemaing;
    
    IBOutlet  NSMutableArray *dataSets;
        IBOutlet DataClass *myData;
    
}
- (IBAction)sliderUpdate;

- (IBAction)repayPeriodShow;
- (IBAction)textFieldUpdate;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)EditingDidEnd;
- (void)insertNewSet:(NSMutableArray*)dataSet;
- (void)test;
-(void) setUpPickerForRepayment;
-(void) setUpTypeForRepayment;
- (IBAction) pickFromPicker;
-(void) convertToPoints;
-(IBAction) segRepayChanged;
-(IBAction) segTypeChanged;
-(void) setValues;


@property (nonatomic, retain) UISlider *amountSlider;
@property (nonatomic, retain) UISlider *APRSlider;
@property (nonatomic, retain) UISlider *termSlider;

@property (nonatomic, retain) UISegmentedControl *repaySeg;
@property (nonatomic, retain) UISegmentedControl *typeSeg;

@property (nonatomic, retain) UIToolbar *tBar;

@property (nonatomic, retain) UIPickerView *paymentPicker;

@property (nonatomic, retain) UITextField *amountField;
@property (nonatomic, retain) UITextField *APRField;
@property (nonatomic, retain) UITextField *termField;

@property (nonatomic, assign) IBOutlet NSMutableArray* dataSets;
@property (nonatomic, assign) IBOutlet DataClass* myData;
@end
