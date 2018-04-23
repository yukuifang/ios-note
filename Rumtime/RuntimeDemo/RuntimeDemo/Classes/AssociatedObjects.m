//
//  AssociatedObjects.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "AssociatedObjects.h"
#import "UIView+DefaultColor.h"
@interface AssociatedObjects ()

@end

@implementation AssociatedObjects

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.view.defaultColor = [UIColor blueColor];
    self.view.backgroundColor = self.view.defaultColor;
    
}





@end
