//
//  sunriset.h
//  Twilight
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

#ifndef sunriset_h
#define sunriset_h

int sunriset( int year, int month, int day, double lon, double lat,
                 double altit, int upper_limb, double *rise, double *set );

double daylen( int year, int month, int day, double lon, double lat,
                  double altit, int upper_limb );

#endif /* sunriset_h */
