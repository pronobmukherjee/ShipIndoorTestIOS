//
//  IDViewController.h
//  MyFirstIndoorsApp
//
//  Created by Mina Haleem on 13.08.13.
//  Copyright (c) 2013 Indoors GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Indoors/Indoors.h>
#import <Indoors/IndoorsCoordinateUtil.h>
#import <CoreLocation/CoreLocation.h>

@interface IDViewController : UIViewController

@property (strong, nonatomic) IDSBuilding *currentBuilding;

@end
