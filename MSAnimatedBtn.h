//
//  MSBtnAnimation.h
//

#import <Foundation/Foundation.h>

@interface MSAnimatedBtn : UIButton
//First call:set top color first
-(void)SetTopColorWithR:(float)red G:(float)green B:(float)blue alpha:(float)alpha;
//Second call:set bottom color
-(void)SetBottomColorWithR:(float)red G:(float)green B:(float)blue alpha:(float)alpha;
//Third call:call this create layer
-(void)createLayer;

//To programtically handle layer
- (void)alterLayer:(id)sender;
@end
