

#import "DataGraphView.h"


@implementation DataGraphView
//@synthesize dataSets;

- (void)draw
{
    
    
    int r,g,b;
    
    NSMutableArray *dataSets = [myData getDataSet];
    
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
#define GRADIENT_BACKGROUND 1
#if GRADIENT_BACKGROUND
    
    CGRect rect = CGRectMake(0, 0, 300, 300);
    
	CGContextDrawLinearGradient(
                                context,
                                [self backgroundGradient],
                                CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)),
                                CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)),
                                0);
#endif
	
	// Move to the first location
	CGContextTranslateCTM(context, 20, 0);
    
    
#define FALSE_HOLE_STROKE 1
#if FALSE_HOLE_STROKE
    // False hole stroke
    
    //NSLog(@"Drawing for %d datasets",[myData count]);
    
    //Draw grid
    /*
    for (int k = 0; k < 20; k++) {
        CGContextMoveToPoint(context, 0, k *20);
        CGContextAddLineToPoint(context, 480, k *20);
        CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
        CGContextSetLineWidth(context, 0.5);
        CGContextStrokePath(context);
        
        
    }
     */
    /*
    for (int m = 0; m < 20; m++) {
        CGContextMoveToPoint(context, m *20,0);
        CGContextAddLineToPoint(context, m *20,300);
        CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
        CGContextSetLineWidth(context, 0.5);
        CGContextStrokePath(context);
        
        
    }
     */
    
    //Add lables
    
    if([myData isSetUp])
    {
    UIFont* font1=[UIFont fontWithName:@"Helvetica" size:9.0];
    double scaleX = [myData getXScale];
    double scaleY = [myData getYScale];
    
    
    
    //Add Lables
    double lX = 0;
    
    for (int xi = 0; xi <30;xi++) {

        CGContextMoveToPoint(context, 0, (-1*(lX*scaleY))+200);
        CGContextAddLineToPoint(context, 480, (-1*(lX*scaleY))+200);
        CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
        CGContextSetLineWidth(context, 0.5);
        CGContextStrokePath(context);
        
       /* if(lX == 0)
        {
            CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.2);
            CGContextSetLineWidth(context, 5);
        }*/
        
        NSString *vLable = [[NSString alloc]initWithFormat:@"%dK",(int)(lX/1000) ];
    
       [vLable drawAtPoint:CGPointMake(-20, (-1*(lX*scaleY))+200) withFont:font1];
        
        //NSLog(@"lX=%f   Drawing Lable %@, at %f",lX,vLable,(-1*(lX*scaleY))+200);
        
        NSLog(@"Scale(%f,%f)",scaleX,scaleY);
        if(scaleY > 0.009509)
        {
            NSLog(@"S1");
        lX += 1000;
        }
        else if(scaleY > 0.001158)
        {
                        NSLog(@"S2");
            lX += 5000;
        }
        else if(scaleY > 0.000290)
        {
                        NSLog(@"S3");
            lX += 15000;
        }
        else
        {
                        NSLog(@"S4");
              lX += 150000;
        }
        
        [vLable release];
    }
        /*
            for (int xi = 0; xi <40;xi++) {
                
                CGContextMoveToPoint(context, 0, (-1*(lX*scaleY))+200);
                CGContextAddLineToPoint(context, 480, (-1*(lX*scaleY))+200);
                CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
                CGContextSetLineWidth(context, 0.5);
                CGContextStrokePath(context);
                
 
                
                NSString *vLable = [[NSString alloc]initWithFormat:@"%dK",(int)(lX/1000) ];
                
                [vLable drawAtPoint:CGPointMake(-20, (-1*(lX*scaleY))+200) withFont:font1];
                
                //NSLog(@"lX=%f   Drawing Lable %@, at %f",lX,vLable,(-1*(lX*scaleY))+200);
                
            }
        
                for (int xi = 0; xi <40;xi++) {
                    
                    CGContextMoveToPoint(context, 0, (-1*(lX*scaleY))+200);
                    CGContextAddLineToPoint(context, 480, (-1*(lX*scaleY))+200);
                    CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
                    CGContextSetLineWidth(context, 0.5);
                    CGContextStrokePath(context);
                    

                    
                    NSString *vLable = [[NSString alloc]initWithFormat:@"%dK",(int)(lX/1000) ];
                    
                    [vLable drawAtPoint:CGPointMake(-20, (-1*(lX*scaleY))+200) withFont:font1];
                    
                    //NSLog(@"lX=%f   Drawing Lable %@, at %f",lX,vLable,(-1*(lX*scaleY))+200);
                    
                }
        for (int xi = 0; xi <40;xi++) {
            
            CGContextMoveToPoint(context, 0, (-1*(lX*scaleY))+200);
            CGContextAddLineToPoint(context, 480, (-1*(lX*scaleY))+200);
            CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
            CGContextSetLineWidth(context, 0.5);
            CGContextStrokePath(context);
            

            
            NSString *vLable = [[NSString alloc]initWithFormat:@"%dK",(int)(lX/1000) ];
            
            [vLable drawAtPoint:CGPointMake(-20, (-1*(lX*scaleY))+200) withFont:font1];
            
            //NSLog(@"lX=%f   Drawing Lable %@, at %f",lX,vLable,(-1*(lX*scaleY))+200);
          
        }
    */
    
    NSString *vLable = [[NSString alloc]initWithFormat:@"Payment: %.2f",[myData getPayment]*[myData getMonthPayment]];
    [vLable drawAtPoint:CGPointMake(200, 10) withFont:font1];
    
    vLable = [[NSString alloc]initWithFormat:@"Montly: %.2f",[myData getPayment] ];
    [vLable drawAtPoint:CGPointMake(200, 20) withFont:font1];
    
    
    
    
    int lY = 0;
    for (int yi = 0; yi <300;yi++) {
        
        
        CGContextMoveToPoint(context, ((lY*scaleX))-10,0);
        CGContextAddLineToPoint(context,((lY*scaleX))-10,300);
        CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 0.2);
        CGContextSetLineWidth(context, 0.5);
       /* if(lY == 0)
        {
            CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.2);
            CGContextSetLineWidth(context, 5);
        }*/
        
        
        CGContextStrokePath(context);
        
        
        
        
        NSString *vLable = [[NSString alloc]initWithFormat:@"%d",lY ];
        [vLable drawAtPoint:CGPointMake( ((lY*scaleX))-10,200+(lY%3)*10) withFont:font1];
        
        //NSLog(@"lY=%d(Mod3 %d)   Drawing Lable %@, at %f",lY,lY%3,vLable,(-1*(lY*scaleX)));
        lY += 1;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //Loop data sets
    for(int i = 0; i < [dataSets count];i++)
    {
        //NSLog(@"Inside loop");
        NSMutableArray *thisDataSet = (NSMutableArray *)[dataSets objectAtIndex:i];
        
        NSValue *point1 = [thisDataSet objectAtIndex:0];
        CGPoint p1 = [point1 CGPointValue];
        
        
        
        CGContextMoveToPoint(context, p1.x, p1.y);
        
        //Loop data points
        for(int j =1; j < [thisDataSet count]; j++) 
        {
            //NSLog(@"SET %d COUNT %d ",j,[thisDataSet count]);
            NSValue *pointn = [thisDataSet objectAtIndex:j];
            CGPoint pn = [pointn CGPointValue];
            CGContextAddLineToPoint(context, pn.x, pn.y);
            
            // CGRect tr = CGRectMake(100, 100, 25, 25);
            // CGContextAddEllipseInRect(context, tr);
            
            // CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
            // CGContextFillEllipseInRect(context, tr);
        }
        
        
        CGContextSetLineWidth(context, 3);
        
        if(i==0)
        {
            r = 1.0;
            g = 0.0;
            b = 0.0;
        }
        else         if(i==1)
        {
            r = 0.0;
            g = 0.0;
            b = 1.0;
        }
    	CGContextSetRGBStrokeColor(context, r, g, b, 1);
        CGContextStrokePath(context);
        
        double knobWidth = 10.0;
        
        for(int l =0; l < [thisDataSet count]; l++) 
        {
            NSValue *pointn = [thisDataSet objectAtIndex:l];
            CGPoint pn = [pointn CGPointValue];
            
            
            CGRect tr = CGRectMake(pn.x-((knobWidth*((scaleX/10)))/2), pn.y-((knobWidth*((scaleX/10)))/2), (knobWidth*((scaleX/10))), (knobWidth*((scaleX/10))));
            // CGContextAddEllipseInRect(context, tr);
            
            CGContextSetRGBFillColor(context, r, g, b, 1);
            CGContextFillEllipseInRect(context, tr);
            
        }
    }
        
    }
    
    
    

    
    
    // CGContextAddEllipseInRect(context, tr);
    
#endif

}
- (void)drawRect:(CGRect)rect
{
    //Figure out scale
    
    
    [self draw];
    
    
    
    


 
}
- (void)takeDataAndAutoConvertToDataSet
{
    //Taking in values rep'ing money or other non points. Find the biggest, the smallest to find scale Y.
    // Take the number(f) or dataline, divide by number of vals and to find X scales.
    
    //Convert values to points and insert into dataset. Pick a color
    
    
    //NSLog(@"%@   TakingData",self);
}

/*- (NSMutableArray*)getDataSet
{
    return myData;
}*/

- (IBAction)redraw
{
    
    //NSLog(@"REDRAW");
    [self draw];
    [self setNeedsDisplay];
    
}



- (CGGradientRef)backgroundGradient
{
	static CGGradientRef backgroundGradient = NULL;
	if (!backgroundGradient)
	{
		UIColor *contentColorTop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
		UIColor *contentColorBottom = [UIColor colorWithRed:0.8 green:0.8 blue:1.0 alpha:1.0];

		CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
		CGFloat backgroundColorComponents[2][4];
		memcpy(
			backgroundColorComponents[0],
			CGColorGetComponents(contentColorTop.CGColor),
			sizeof(CGFloat) * 4);
		memcpy(
			backgroundColorComponents[1],
			CGColorGetComponents(contentColorBottom.CGColor),
			sizeof(CGFloat) * 4);
		
		const CGFloat endpointLocations[2] = {0.0, 1.0};
		backgroundGradient =
			CGGradientCreateWithColorComponents(
				colorspace,
				(const CGFloat *)backgroundColorComponents,
				endpointLocations,
				2);
		CFRelease(colorspace);
	}
	
	return backgroundGradient;
}

@end
