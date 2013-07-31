//
//  ScrollViewController.m
//  MonthlyInterest
//
//  Created by keith.loughnane on 27/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "ScrollViewController.h"
#import "DataGraphAppDelegate.h"


@implementation ScrollViewController

@synthesize amountSlider, APRSlider, termSlider;

@synthesize amountField;
@synthesize APRField;
@synthesize termField;
@synthesize tBar;

@synthesize paymentPicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   // self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    //[self setValues];
    return self;
}

- (void)dealloc
{
    [super dealloc];
}
- (IBAction)textFieldReturn:(id)sender
{
    //NSLog(@"textFieldReturn,%f",[[APRField text] floatValue]);
    
    [self setValues];

    
    [sender resignFirstResponder];
}
-(void) setValues
{
    
    APR = [ [APRField text]  floatValue];
    principleAmount = [[amountField text] floatValue];
    if(principleAmount < 1000)
        principleAmount = 1000;
    numberOfMonths = [[termField text] intValue];
    if(numberOfMonths < 1)
        numberOfMonths = 1;
    
    APRSlider.value = APR/20;
    termSlider.value = (numberOfMonths/100)-1;
    amountSlider.value = (principleAmount/1000000)-1000;
    
    NSString *APRTemp = [[NSString alloc]initWithFormat:@"%.2f",APR];
    NSString *amountTemp = [[NSString alloc]initWithFormat:@"%.2f",principleAmount];
    NSString *termTemp = [[NSString alloc]initWithFormat:@"%d",numberOfMonths];
    
    [APRField setText:APRTemp];
    [amountField setText:amountTemp];
    [termField setText:termTemp];

    
    [amountTemp release];
    [termTemp release];
    [APRTemp release];
    
    //NSLog(@"converting to points");
        [self convertToPoints];

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (IBAction)sliderUpdate
{
    //NSLog(@"SliderUpdate");
    
    
    APR = APRSlider.value*20;
    principleAmount = (amountSlider.value*1000000)+1000;
    numberOfMonths = (int)((termSlider.value*100)+1);
    
    
    
    NSString *APRTemp = [[NSString alloc]initWithFormat:@"%.2f",APR];
    NSString *amountTemp = [[NSString alloc]initWithFormat:@"%.2f",principleAmount];
    NSString *termTemp = [[NSString alloc]initWithFormat:@"%d",numberOfMonths];
    
    
    [APRField setText:APRTemp];
    [amountField setText:amountTemp];
    [termField setText:termTemp];
    
    [myData printData];
    
    [APRTemp release];
    [amountTemp release];
    [termTemp release];
    
    
    [self convertToPoints];

    
    //NSLog(@"COUNT COUNT >> %d",[dataSets count]);
}
- (IBAction)textFieldUpdate
{
   //[self setValues];
    //[self convertToPoints];
    //NSLog(@"TextFieldUpdate");
    
    
}

- (IBAction)EditingDidEnd
{
    //NSLog(@"Editing did end");
}

- (IBAction)repayPeriodShow
{
    //NSLog(@"repayPeriodShow");
    [self setUpPickerForRepayment];
    paymentPicker.hidden = NO;
    tBar.hidden = NO;
}

- (IBAction)repayTypeShow
{
   // NSLog(@"repayTypeShow");
    [self setUpTypeForRepayment];
    paymentPicker.hidden = NO;
    tBar.hidden = NO;
}

- (IBAction) pickFromPicker
{
    
    //HERE HERE HERE
    //paymentPeriodInMonths = 1;
    //2;
    //4;
    
   // case(picker text
    
    paymentPicker.hidden = YES;
         
         
         
    tBar.hidden = YES;
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [self convertToPoints];
    [amountSlider addTarget:self action:@selector(sliderUpdate) forControlEvents:UIControlEventValueChanged];
    [APRSlider addTarget:self action:@selector(sliderUpdate) forControlEvents:UIControlEventValueChanged];
    [termSlider addTarget:self action:@selector(sliderUpdate) forControlEvents:UIControlEventValueChanged];
}
- (void)calcPayments
{
    
    //NSLog(@"Calcing payments ");
    
    double iTotal,iPrinciple;
    double r = APR/1200;
    double repayFreqInMonths = 1;
   // double numRepayments = (numRepayments*12)/repayFreqInMonths;  
    
    PrincipleOwedRemaing = [[NSMutableArray alloc]init];
    TotalOwedRemaing = [[NSMutableArray alloc]init];
    
    if(repaySeg.selectedSegmentIndex == 0)  //Repay weekly
    {
        repayFreqInMonths = 0.25;
    }
    else if(repaySeg.selectedSegmentIndex == 1)   //forthnightly
    {
        repayFreqInMonths  = 0.5;
    }
        else if(repaySeg.selectedSegmentIndex == 2)   //mothly
        {
            repayFreqInMonths = 1;
        }
    
    


    iTotal = principleAmount + (principleAmount*r)*numberOfMonths;
    
    if(typeSeg.selectedSegmentIndex == 0)//Just prince
    {
    monthlyPayment = ((r + (r/(pow((1+r),(numberOfMonths))-1))) * principleAmount );
    }
    else if(typeSeg.selectedSegmentIndex == 1)//Prince & interest
    {
    monthlyPayment = ((r + (r/(pow((1+r),(numberOfMonths))-1))) * iTotal );
    }
    
    [myData setPayment:monthlyPayment payments:repayFreqInMonths];
    
    //NSLog(@"Mothly Payment = %f",monthlyPayment);
    
    for(int i = 0; iTotal > 0.0 && i < 150;i++)
    {
        for(double j=0; j<1.0;j+=repayFreqInMonths)
        {
            //NSLog(@"j=%f Reducing iTotal by (%f * %f) %f: Total = %f",j,monthlyPayment,repayFreqInMonths,monthlyPayment*repayFreqInMonths,iTotal);
        iTotal -= monthlyPayment*repayFreqInMonths;

        }
                iTotal += (iTotal*APR)/1200;
        NSNumber *temp = [[NSNumber alloc] initWithDouble:iTotal];
        [TotalOwedRemaing addObject:temp];
        //NSLog(@"i=%d    iTotal=%f",i,iTotal);
        
        [temp release];
    }
    
    iPrinciple = principleAmount;
    //NSLog(@"Mothly Payment = %f",monthlyPayment);
    
    for(int i = 0; iPrinciple > 0.0;i++)
    {
        for(double j=0; j<1.0;j+=repayFreqInMonths)
        {
        iPrinciple -= monthlyPayment*repayFreqInMonths;
        }
        //iTotal += (iTotal*APR)/1200;
        NSNumber *temp = [[NSNumber alloc] initWithDouble:iPrinciple];
        [PrincipleOwedRemaing addObject:temp];
       // NSLog(@"i=%d    iPrinc=%f",i,iPrinciple); 
        [temp release];
    }
    
    
    
    
    
}

- (void)convertToPoints
{
       // NSLog(@"converting to points");
    //[self 
    [myData initData];
    [self calcPayments];
    

    
    //-------Figure out scaling-------
    double sizeX = 230;
    double sizeY = 200;
    
    
    double scaleY = 1.0;  //= Max array val / MAx drawing space Y
    double scaleX = 1.0;
    double maxY = 0;
    for(int i = 0; i < [TotalOwedRemaing count];i++)
    {
        NSNumber *temp = [TotalOwedRemaing objectAtIndex:i];
        
        if(maxY < [temp doubleValue])
        {
            maxY = [temp doubleValue];
        }
        
        
    }
    
    
           scaleX = sizeX/[TotalOwedRemaing count];
           scaleY = sizeY/maxY;
    
 
    
    //NSLog(@"Scale set X:%f Y:%f MaxY:%f  Term:%f",scaleX,scaleY,maxY,numberOfMonths);
    
    //--------------------------------

    //dataSets = [[NSMutableArray alloc]init];
    
    //[myData setData:69];
    
    
   //NSLog(@"Converting data");
    
    NSMutableArray *dataSet1 = [[NSMutableArray alloc] init];
    
    for(int ii = 0; ii < [TotalOwedRemaing count];ii++)
    {
        NSNumber *tNum = [TotalOwedRemaing objectAtIndex:ii];
    CGPoint p1 = CGPointMake(ii*scaleX, -1*([tNum doubleValue]*scaleY)+sizeY );
        
    //NSLog(@"Total created point X%f  Y%f",ii*scaleX,-1*([tNum doubleValue]*scaleY)+sizeY);
    
    
    NSValue *point1 = [NSValue valueWithCGPoint:p1];

    
    
    [dataSet1 addObject:point1];

    
    //NSLog(@"Totalset setup with %d entries",[dataSet1 count]);
    }
    
    [self insertNewSet:dataSet1];
    
    
    
    
    
    
    
    
    
    
    
    
    NSMutableArray *dataSet2 = [[NSMutableArray alloc] init];
    
    for(int ii = 0; ii < [PrincipleOwedRemaing count];ii++)
    {
        NSNumber *tNum = [PrincipleOwedRemaing objectAtIndex:ii];
        CGPoint p1 = CGPointMake(ii*scaleX, -1*([tNum doubleValue]*scaleY)+sizeY );
        
       // NSLog(@"principle created point X%f  Y%f",ii*scaleX,-1*([tNum doubleValue]*scaleY)+sizeY);
        
        
        NSValue *point1 = [NSValue valueWithCGPoint:p1];
        
        
        
        [dataSet2 addObject:point1];
        
        
        //NSLog(@"principleset setup with %d entries",[dataSet1 count]);
    }
    
    [self insertNewSet:dataSet2];
    [myData inputScale:scaleX :scaleY];
    
    
}


- (void)test
{
    [self calcPayments];
    [myData initData];
    //dataSets = [[NSMutableArray alloc]init];
    
    //[myData setData:69];
    
    
    //NSLog(@"Testing, instering dummy data");
    NSMutableArray *dummyDataSet = [[NSMutableArray alloc] init];
    
    CGPoint p1 = CGPointMake(0.0, APR);
    CGPoint p2 = CGPointMake(20.0, monthlyPayment);
    CGPoint p3 = CGPointMake(40.0, principleAmount);
    
    NSValue *point1 = [NSValue valueWithCGPoint:p1];
    NSValue *point2 = [NSValue valueWithCGPoint:p2];
    NSValue *point3 = [NSValue valueWithCGPoint:p3];
    
    
    [dummyDataSet addObject:point1];
    [dummyDataSet addObject:point2];
    [dummyDataSet addObject:point3];
    
    //NSLog(@"Dummyset setup with %d entries",[dummyDataSet count]);
    
    [self insertNewSet:dummyDataSet];
    
    //NSLog(@"Testing, instering dummy data");
    NSMutableArray *dummyDataSetb = [[NSMutableArray alloc] init];
    
    CGPoint p1b = CGPointMake(05.0, APR);
    CGPoint p2b = CGPointMake(25.0, monthlyPayment);
    CGPoint p3b = CGPointMake(45.0, principleAmount);
    
    NSValue *point1b = [NSValue valueWithCGPoint:p1b];
    NSValue *point2b = [NSValue valueWithCGPoint:p2b];
    NSValue *point3b = [NSValue valueWithCGPoint:p3b];
    
    
    [dummyDataSetb addObject:point1b];
    [dummyDataSetb addObject:point2b];
    [dummyDataSetb addObject:point3b];
    
    //NSLog(@"Dummyset setup with %d entries",[dummyDataSetb count]);
    
    [self insertNewSet:dummyDataSetb];
    
    
    
}


- (void)insertNewSet:(NSMutableArray*)dataSet
{
    
    
    
    
    
    //NSLog(@"instering set (count %d) into datasets (count %d)",[dataSet count],[myData count]);
    
    [myData addObject:dataSet];
    
    // [dataSets addObject:dataSet];
    
    //NSLog(@"instered set into datasets (count %d)",[myData count]);
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{

    NSLog(@"Scrollview View did load");

}


- (void)viewDidUnload
{
    //[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	[self setUpPickerForRepayment];
	return [arrayColors count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	//[self setUpPickerForRepayment];
	return [arrayColors objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	//[self setUpPickerForRepayment];
	//NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayColors objectAtIndex:row], row);
    
    paymentString = [arrayColors objectAtIndex:row];
    
    
}

-(void) setUpPickerForRepayment
{
    
    
    arrayColors = [[NSMutableArray alloc] init];
	[arrayColors addObject:@"Monthly"];
	//[arrayColors addObject:@"Bimonthly"];
    [arrayColors addObject:@"Fortnightly"];
	[arrayColors addObject:@"Weekly"];
    
    
    [paymentPicker setNeedsDisplay];
    
}

-(void) setUpTypeForRepayment
{
    
    arrayColors = [[NSMutableArray alloc] init];
	[arrayColors addObject:@"1"];
	[arrayColors addObject:@"2"];
    
    
    [paymentPicker setNeedsDisplay];
    
    
}

-(IBAction) segRepayChanged
{
    //NSLog(@"Seg Repay changed, %d", repaySeg.selectedSegmentIndex);
    [self setValues];
        [self convertToPoints];
   
}
-(IBAction) segTypeChanged
{
    //NSLog(@"Seg Type Changed, %d",typeSeg.selectedSegmentIndex);
    [self setValues];
        [self convertToPoints];
}

@end
