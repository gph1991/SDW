//
//  UIImage+Rotate_Flip.h
//  SDWLearn
//
//  Created by Apple on 16/1/19.
//  Copyright © 2016年 gph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate_Flip)


/*
 * @brief rotate image 90 withClockWise
 */
- (UIImage*)rotate90Clockwise;

/*
 * @brief rotate image 90 counterClockwise
 */
- (UIImage*)rotate90CounterClockwise;

/*
 * @brief rotate image 180 degree
 */
- (UIImage*)rotate180;

/*
 * @brief rotate image to default orientation
 */
- (UIImage*)rotateImageToOrientationUp;

/*
 * @brief flip horizontal
 */
- (UIImage*)flipHorizontal;

/*
 * @brief flip vertical
 */
- (UIImage*)flipVertical;

/*
 * @brief flip horizontal and vertical
 */
- (UIImage*)flipAll;


@end
