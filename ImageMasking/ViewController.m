//
//  ViewController.m
//  frdsgv
//
//  Created by Sandip Saha on 23/09/13.
//  Copyright (c) 2013 Sandip Saha. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
@synthesize imageView1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setRoundedView:imageView toDiameter:180.0];
    self.view.backgroundColor=[UIColor underPageBackgroundColor];
    self.imageView.backgroundColor=[UIColor blackColor];
    self.imageView.image=[UIImage imageNamed:@"dark1.png"];
    self.imageView.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.imageView.layer.borderWidth=5.0;
    
    UIImage *image=[UIImage imageNamed:@"image.png"];
    UIImage *mask=[UIImage imageNamed:@"mask23.png"];
    UIImage *newimage=[self maskImage:image withMask:mask];
    self.imageView1.image=newimage;
}

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.layer.masksToBounds=YES;
    roundedView.center = saveCenter;
}


- (UIImage*) maskImage:(UIImage *) image withMask:(UIImage *) mask
{
    CGImageRef imageReference = image.CGImage;
    CGImageRef maskReference = mask.CGImage;
    
    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference),
                                             CGImageGetHeight(maskReference),
                                             CGImageGetBitsPerComponent(maskReference),
                                             CGImageGetBitsPerPixel(maskReference),
                                             CGImageGetBytesPerRow(maskReference),
                                             CGImageGetDataProvider(maskReference),
                                             NULL, // Decode is null
                                             YES // Should interpolate
                                             );
    
    CGImageRef maskedReference = CGImageCreateWithMask(imageReference, imageMask);
    CGImageRelease(imageMask);
    
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedReference];
    CGImageRelease(maskedReference);
    
    return maskedImage;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
