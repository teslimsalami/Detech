//
//  ViewController.m
//  Detech_
//
//  Created by Teslim on 3/28/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)startUpdates:(id)sender {
    if (![fftCalculator isSupported]) {
        return NSLog(@"Error: FFTCalculator not supported due to device restrictions - Please run this project on the device to use the CoreMotion sensor.");
    }
    
    [fftCalculator startUpdatesWithCalculationHandler:^(NSArray<NSNumber *> * _Nullable values, float mean, NSError * _Nullable error) {
        NSLog(@"\nFourier values: %@", values);
        NSLog(@"Fourier mean-value: %f", mean);
    }];
}

- (IBAction)stopUpdates:(id)sender {
    [fftCalculator stopUpdates];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fftCalculator = [[FFTCalculator alloc] initWithFrameSize:256];
    
    // Do any additional setup after loading the view.
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

@end
