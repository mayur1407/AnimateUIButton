//
//  MSBtnAnimation.m
//

#import "MSAnimatedBtn.h"

@implementation MSAnimatedBtn
{    
    CAGradientLayer *coloredLayer;
    
    UIColor *topColor;
    UIColor *bottomColor;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self drawButton];
        //[self drawBtnLayer];
    }
    return self;
}
-(void)drawButton
{
    CALayer *layer=self.layer;
    layer.cornerRadius=10.0;
//    layer.borderWidth = 1;
//    layer.borderColor = [UIColor colorWithRed:0.77f green:0.43f blue:0.00f alpha:1.00f].CGColor;
    
    [self addTarget:self action:@selector(alterLayer:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(alterLayerBack:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(alterLayerBack:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)drawBtnLayer
{
    
    coloredLayer.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height/2);
    [self.layer insertSublayer:coloredLayer atIndex:0];
}

- (void)alterLayer:(id)sender {
    UIButton *btn=(UIButton*)sender;
    coloredLayer.frame=CGRectMake(0, btn.frame.size.height/2, btn.frame.size.width,btn.frame.size.height/2);
    [btn.layer addAnimation:[self scalingDownAnimation] forKey:@"zoomOut"];
}
- (void)alterLayerBack:(id)sender {
    UIButton *btn=(UIButton*)sender;
    coloredLayer.frame=CGRectMake(0, 0, btn.frame.size.width,btn.frame.size.height/2);
    [btn.layer addAnimation:[self scalingUpAnimation] forKey:@"zoomOut"];
}

#pragma mark - Scale Animation
-(CABasicAnimation*)scalingDownAnimation
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue =   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.90, 0.90, 1.0)];
    [animation setDuration:0.2];
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    return animation;
}
-(CABasicAnimation*)scalingUpAnimation
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.90, 0.90, 1.0)];
    animation.toValue =   [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.delegate=self;
    [animation setDuration:0.3];
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    return animation;
}

#pragma mark - Colored Layers
-(CAGradientLayer*)GradientLayer
{
    UIColor *tColor =topColor;
    UIColor *bColor =bottomColor;
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)tColor.CGColor, (id)bColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.cornerRadius=10.0;
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    return gradientLayer;
}
-(void)SetTopColorWithR:(float)red G:(float)green B:(float)blue alpha:(float)alpha
{
    topColor=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}
-(void)SetBottomColorWithR:(float)red G:(float)green B:(float)blue alpha:(float)alpha
{
    bottomColor=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
-(void)createLayer
{
    coloredLayer=[self GradientLayer];
    [self drawBtnLayer];
}

@end
