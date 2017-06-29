//
//  ViewController.m
//  HTMLAnimation
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 LIZHAO. All rights reserved.
//
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) CAGradientLayer * skyLayer;
@property(nonatomic,strong) CALayer * landLayer;
@property(nonatomic,strong) CALayer * cloudLayer;
@property(nonatomic,strong) CAShapeLayer * leftLawnLayer;
@property(nonatomic,strong) CAShapeLayer * rightLawnLayer;
@property(nonatomic,strong) UIBezierPath * leftLawnPath;
@property(nonatomic,strong) UIBezierPath * rightLawnPath;
@property(nonatomic,strong) CAShapeLayer * yellowLoadLayer;
@property(nonatomic,strong) UIBezierPath * yellowPath;
@property(nonatomic,strong) CAShapeLayer * trackLayer;
@property(nonatomic,strong) CAShapeLayer * greenLayer;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setup];
    
}

- (void)setup {
    
    [self.view.layer addSublayer:self.skyLayer];
    [self.view.layer addSublayer:self.landLayer];
    [self.view.layer addSublayer:self.cloudLayer];
    [self initLeftSnowMountain];
    [self initRightSnowMountain];
    self.leftLawnLayer.path =self.leftLawnPath.CGPath;
    [self.view.layer addSublayer:self.leftLawnLayer];
    self.rightLawnLayer.path = self.rightLawnPath.CGPath;
    [self.view.layer addSublayer:self.rightLawnLayer];
    //    self.yellowLoadLayer.path = self.yellowPath.CGPath;
    //    self.trackLayer.path =self.yellowPath.CGPath;
    //    [self.yellowLoadLayer addSublayer:self.trackLayer];
    //    [self.view.layer addSublayer:self.yellowLoadLayer];
    [self initGreenLoadLayer];
    [self initTree];
    [self carAnimationWith:@"otherCar" TrackLayer:self.greenLayer AnimationDuration:5.0 BeginTime:CACurrentMediaTime()];
}

- (void)initLeftSnowMountain {
    
    CAShapeLayer * leftSnowLayer = [CAShapeLayer layer];
    leftSnowLayer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath * leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:CGPointMake(0, SCREEN_HEIGHT-120)];
    [leftPath addLineToPoint:CGPointMake(SCREEN_WIDTH/4, 100)];
    [leftPath addLineToPoint:CGPointMake(200, SCREEN_HEIGHT-120)];
    //  [leftPath closePath];
    leftSnowLayer.path = leftPath.CGPath;
    [self.view.layer addSublayer:leftSnowLayer];
    
    
    CAShapeLayer * leftBrownLayer = [CAShapeLayer layer];
    leftBrownLayer.fillColor = [UIColor brownColor].CGColor;
    UIBezierPath * leftBrownBezierPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(0, SCREEN_HEIGHT-120);
    CGPoint endPoint   = CGPointMake(SCREEN_WIDTH/4, 100);
    CGPoint firstPoint = [self calculateWithXValue:20 startPoint:startPoint endpoint:endPoint];
    [leftBrownBezierPath moveToPoint:startPoint];
    [leftBrownBezierPath addLineToPoint:firstPoint];
    [leftBrownBezierPath addLineToPoint:CGPointMake(60, firstPoint.y)];
    [leftBrownBezierPath addLineToPoint:CGPointMake(100, firstPoint.y + 30)];
    [leftBrownBezierPath addLineToPoint:CGPointMake(140, firstPoint.y)];
    [leftBrownBezierPath addLineToPoint:CGPointMake(172, firstPoint.y - 20)];
    [leftBrownBezierPath addLineToPoint:CGPointMake(200, SCREEN_HEIGHT - 120)];
    leftBrownLayer.path = leftBrownBezierPath.CGPath;
    [self.view.layer addSublayer:leftBrownLayer];
}

- (void)initRightSnowMountain {
    
    CAShapeLayer * rightSnowLayer = [CAShapeLayer layer];
    rightSnowLayer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath * rightSnowPath = [UIBezierPath bezierPath];
    CGPoint  startPoint = CGPointMake(200,SCREEN_HEIGHT-120);
    CGPoint  endPoint = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT-120);
    CGFloat centerOriginY = ((SCREEN_HEIGHT-120-100)/2)+100;
    CGPoint  centerPoint = CGPointMake(250, centerOriginY);
    [rightSnowPath moveToPoint:startPoint];
    [rightSnowPath addLineToPoint:centerPoint];
    [rightSnowPath addLineToPoint:endPoint];
    rightSnowLayer.path = rightSnowPath.CGPath;
    [self.view.layer addSublayer:rightSnowLayer];
    
    
    
    CAShapeLayer * rightBrownLayer = [CAShapeLayer layer];
    rightBrownLayer.fillColor = [UIColor brownColor].CGColor;
    UIBezierPath * rightBrownPath = [UIBezierPath bezierPath];
    CGPoint startBrownPoint = startPoint;
    CGPoint middleFirstPathPoint = [self calculateWithXValue:(startBrownPoint.x + 20) startPoint:startBrownPoint endpoint:centerPoint];
    [rightBrownPath moveToPoint:startBrownPoint];
    [rightBrownPath addLineToPoint:middleFirstPathPoint];
    [rightBrownPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 20, middleFirstPathPoint.y)];
    [rightBrownPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 50, middleFirstPathPoint.y + 30)];
    [rightBrownPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 80, middleFirstPathPoint.y +10)];
    [rightBrownPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 100, middleFirstPathPoint.y +10)];
    [rightBrownPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 113, middleFirstPathPoint.y +15)];
    [rightBrownPath addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT-120)];
    rightBrownLayer.path = rightBrownPath.CGPath;
    [self.view.layer addSublayer:rightBrownLayer];
    
}

- (void)initGreenLoadLayer {
    _greenLayer = [CAShapeLayer layer];
    _greenLayer.lineWidth = 5;
    _greenLayer.strokeColor = [UIColor colorWithDisplayP3Red:0.0 / 255.0 green:147.0 / 255.0 blue:163.0 /255.0  alpha:1.0].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(SCREEN_WIDTH + 10, SCREEN_HEIGHT - 30)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH + 10, SCREEN_HEIGHT - 70)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH/1.5, SCREEN_HEIGHT - 70) controlPoint:CGPointMake(SCREEN_WIDTH-150, 200)];
    [path addArcWithCenter:CGPointMake(SCREEN_WIDTH/1.6, SCREEN_HEIGHT - 140) radius:70 startAngle:M_PI_2 endAngle:2.5 *M_PI clockwise:YES];
    [path addCurveToPoint:CGPointMake(0, SCREEN_HEIGHT - 100) controlPoint1:CGPointMake(SCREEN_WIDTH / 1.8 - 60, SCREEN_HEIGHT - 60) controlPoint2:CGPointMake(150, SCREEN_HEIGHT / 2.3)];
    [path addLineToPoint:CGPointMake(- 10, SCREEN_HEIGHT - 30)];
    _greenLayer.path = path.CGPath;
    _greenLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]].CGColor;
    [self.view.layer addSublayer:_greenLayer];
    
    //加入虚线
    CAShapeLayer *trackLine = [[CAShapeLayer alloc] init];
    trackLine.lineCap = kCALineCapRound;
    trackLine.strokeColor = [UIColor whiteColor].CGColor;
    
    trackLine.lineDashPattern = @[@1.0,@6.0];
    trackLine.lineWidth = 2.5;
    trackLine.fillColor = [UIColor clearColor].CGColor;
    trackLine.path = path.CGPath;
    [_greenLayer addSublayer:trackLine];
}

- (void)initTree {
    
    [self addTreesWithNumber:7 treeFrame:CGRectMake(0, SCREEN_HEIGHT-30 - 20, 13, 23)];
    [self addTreesWithNumber:7 treeFrame:CGRectMake(0, SCREEN_HEIGHT-30 - 64, 18, 32)];
    [self addTreesWithNumber:5 treeFrame:CGRectMake(0, SCREEN_HEIGHT-30 - 90, 13, 23)];
    
    
}

- (void)addTreesWithNumber:(NSInteger)treesNumber treeFrame:(CGRect)frame {
    UIImage *tree = [UIImage imageNamed:@"tree"];
    for (NSInteger i = 0; i < treesNumber + 1; i++) {
        CALayer *treeLayer = [[CALayer alloc] init];
        treeLayer.contents = (__bridge id _Nullable)(tree.CGImage);
        treeLayer.frame = CGRectMake(SCREEN_WIDTH - 50 * i * (arc4random_uniform(4) + 1), frame.origin.y, frame.size.width, frame.size.height);
        [self.view.layer insertSublayer:treeLayer above:_greenLayer];
    }
    
    
}

- (CALayer *)landLayer {
    if (_landLayer) {
        return _landLayer;
    }
    _landLayer = [CALayer layer];
    _landLayer.frame = CGRectMake(0, SCREEN_HEIGHT-30, SCREEN_WIDTH, 30);
    _landLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"land"].CGImage);
    return _landLayer;
}

- (CAGradientLayer *)skyLayer {
    if (_skyLayer) {
        return _skyLayer;
    }
    _skyLayer = [CAGradientLayer layer];
    _skyLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20);
    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    _skyLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    _skyLayer.startPoint = CGPointMake(0, 0);
    _skyLayer.endPoint  = CGPointMake(1, 1);
    return _skyLayer;
}

- (CALayer *)cloudLayer {
    if (_cloudLayer) {
        return _cloudLayer;
    }
    _cloudLayer = [CALayer layer];
    _cloudLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"cloud"].CGImage);
    _cloudLayer.frame = CGRectMake(0, 60, 63, 30);
    
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH + 63, 50)];
    NSValue * value2 = [NSValue valueWithCGPoint:CGPointMake(-63, 50)];
    keyAnimation.values= @[value1,value2];
    keyAnimation.duration = 10.;
    keyAnimation.autoreverses = NO;//是否以新的位置为起点
    keyAnimation.repeatCount = CGFLOAT_MAX;//重复次数
    keyAnimation.calculationMode = kCAAnimationPaced;//平均
    [_cloudLayer addAnimation:keyAnimation forKey:@"position"];
    
    return _cloudLayer;
}

- (CAShapeLayer *)leftLawnLayer {
    if (_leftLawnLayer) {
        return _leftLawnLayer;
    }
    _leftLawnLayer = [CAShapeLayer layer];
    _leftLawnLayer.fillColor = [UIColor colorWithDisplayP3Red:82.0 / 255.0 green:177.0 / 255.0 blue:52.0 / 255.0 alpha:1.0].CGColor;
    return _leftLawnLayer;
}

- (UIBezierPath *)leftLawnPath {
    if (_leftLawnPath) {
        return _leftLawnPath;
    }
    _leftLawnPath =[UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(0, SCREEN_HEIGHT-30);
    [_leftLawnPath moveToPoint:startPoint];
    [_leftLawnPath addLineToPoint:CGPointMake(0, SCREEN_HEIGHT-120)];
    [_leftLawnPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-30) controlPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-200)];
    
    return _leftLawnPath;
}

- (CAShapeLayer *)rightLawnLayer {
    if (_rightLawnLayer) {
        return _rightLawnLayer;
    }
    _rightLawnLayer = [CAShapeLayer layer];
    _rightLawnLayer.fillColor = [UIColor colorWithDisplayP3Red:92.0/255.0 green:195.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    return _rightLawnLayer;
}

- (UIBezierPath *)rightLawnPath {
    if (_rightLawnPath) {
        return _rightLawnPath;
    }
    _rightLawnPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(0, SCREEN_HEIGHT - 30);
    [_rightLawnPath moveToPoint:startPoint];
    [_rightLawnPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - 120) controlPoint:CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT -230)];
    [_rightLawnPath addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - 30)];
    return _rightLawnPath;
}

- (CAShapeLayer *)yellowLoadLayer {
    if (_yellowLoadLayer) {
        return _yellowLoadLayer;
    }
    _yellowLoadLayer = [CAShapeLayer layer];
    _yellowLoadLayer.fillColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    return _yellowLoadLayer;
}

- (UIBezierPath *)yellowPath {
    if (_yellowPath) {
        return _yellowPath;
    }
    _yellowPath = [UIBezierPath bezierPath];
    CGFloat centerOriginY = ((SCREEN_HEIGHT-120-100)/2)+100;
    CGPoint startPoint = CGPointMake(0, SCREEN_HEIGHT - 50);
    CGPoint centerPoint = CGPointMake(SCREEN_WIDTH/3, centerOriginY );
    [_yellowPath moveToPoint:startPoint];
    [_yellowPath addCurveToPoint:centerPoint controlPoint1:CGPointMake(SCREEN_WIDTH/6, SCREEN_HEIGHT - 160) controlPoint2:CGPointMake(SCREEN_WIDTH/4, SCREEN_HEIGHT+50)];
    [_yellowPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH + 50,SCREEN_HEIGHT / 3.0 ) controlPoint:CGPointMake(SCREEN_WIDTH - 100, 50)];
    [_yellowPath addLineToPoint:CGPointMake(SCREEN_WIDTH + 10, SCREEN_HEIGHT + 10)];
    [_yellowPath addLineToPoint:CGPointMake(0,SCREEN_HEIGHT + 10)];
    return _yellowPath;
}

- (CAShapeLayer *)trackLayer {
    if (_trackLayer) {
        return _trackLayer;
    }
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.strokeColor = [UIColor whiteColor].CGColor;
    _trackLayer.lineDashPattern = @[@1.0,@6.0];
    _trackLayer.lineWidth = 2.5;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    return _trackLayer;
}

//根据起始点，算出指定的x在这条线段上对应的y。返回这个point。知道两点，根据两点坐标，求出两点连线的斜率。y=kx+b求出点坐标。
- (CGPoint)calculateWithXValue:(CGFloat)xvalue startPoint:(CGPoint)startPoint endpoint:(CGPoint)endpoint{
    //    求出两点连线的斜率
    CGFloat k = (endpoint.y - startPoint.y) / (endpoint.x - startPoint.x);
    CGFloat b = startPoint.y - startPoint.x * k;
    CGFloat yvalue = k * xvalue + b;
    return CGPointMake(xvalue, yvalue);
}

//抽取过山车的动画
- (CAKeyframeAnimation *)carAnimationWith:(NSString *)carImageName TrackLayer:(CAShapeLayer *)track AnimationDuration:(CFTimeInterval)duration BeginTime:(CFTimeInterval)beginTime{
    CALayer *car = [[CALayer alloc] init];
    car.frame = CGRectMake(0, 0, 22, 15);
    car.contents = (__bridge id _Nullable)([UIImage imageNamed:carImageName].CGImage);
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = track.path;
    
    ani.duration = duration;
    ani.beginTime = beginTime;
    ani.autoreverses = NO;
    ani.repeatCount = CGFLOAT_MAX;
    ani.calculationMode = kCAAnimationPaced;
    ani.rotationMode = kCAAnimationRotateAuto;
    
    [track addSublayer:car];
    [car addAnimation:ani forKey:@"carAni"];
    
    return ani;
}





@end
