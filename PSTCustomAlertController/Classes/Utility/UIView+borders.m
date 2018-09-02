//
//  UIView+borders.m
//  Pods
//
//  Created by grant.zhou on 2017/6/7.
//
//

#import "UIView+borders.h"

@implementation UIView (addons)


//////////
// Top
//////////

-(CALayer*)createTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    return [self createTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

-(UIView*)createViewBackedTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    return [self createViewBackedTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

-(void)addTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    [self addTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

-(void)addViewBackedTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    [self addViewBackedTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

//////////
// Top + Offset
//////////

-(CALayer*)createTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset {
    // Subtract the bottomOffset from the height and the thickness to get our final y position.
    // Add a left offset to our x to get our x position.
    // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
    return [self getOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

-(UIView*)createViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset {
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    return border;
}

-(void)addTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset {
    // Add leftOffset to our X to get start X position.
    // Add topOffset to Y to get start Y position
    // Subtract left offset from width to negate shifting from leftOffset.
    // Subtract rightoffset from width to set end X and Width.
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

-(void)addViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset {
    UIView *border = [self createViewBackedTopBorderWithHeight:height color:color leftOffset:leftOffset rightOffset:rightOffset andTopOffset:topOffset];
    [self addSubview:border];
    
    NSArray<__kindof NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[border(%f)]",height] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];

    [self addConstraints:constraints];
    
    [self sendSubviewToBack:border];
}


//////////
// Bottom
//////////

-(void)addBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    [self addBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

-(void)addViewBackedBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    [self addViewBackedBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

-(void)addViewFrontedBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    [self addViewFrontedBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

-(CALayer*)createBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    return [self createBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

//////////
// Bottom + Offset
//////////

-(void)addViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self createViewBackedBottomBorderWithHeight:height color:color leftOffset:leftOffset rightOffset:rightOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
    NSArray<__kindof NSLayoutConstraint *> *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[border(%f)]-%f-|",height,bottomOffset] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];
    
    [self addConstraints:vConstraints];
    NSArray<__kindof NSLayoutConstraint *> *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[border]-%f-|",leftOffset,rightOffset] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];
    
    [self addConstraints:hConstraints];
    [self sendSubviewToBack:border];
}

-(void)addViewFrontedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self createViewBackedBottomBorderWithHeight:height color:color leftOffset:leftOffset rightOffset:rightOffset andBottomOffset:bottomOffset];
    NSArray<__kindof NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[border(%f)]|",height] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];
    
    [self addConstraints:constraints];
    [self addSubview:border];
}

-(void)addBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset {
    // Subtract the bottomOffset from the height and the thickness to get our final y position.
    // Add a left offset to our x to get our x position.
    // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, self.frame.size.height-height-bottomOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

-(CALayer*)createBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset {
    // Subtract the bottomOffset from the height and the thickness to get our final y position.
    // Add a left offset to our x to get our x position.
    // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
    return [self getOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, self.frame.size.height-height-bottomOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

-(UIView*)createViewBackedBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color{
    return [self createViewBackedBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

-(UIView*)createViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, self.frame.size.height-height-bottomOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    return border;
}


//////////
// Left
//////////

-(CALayer*)createLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    return [self createLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

-(UIView*)createViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    return [self createViewBackedLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

-(void)addLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    [self addLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

-(void)addViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    [self addViewBackedLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}



//////////
// Left + Offset
//////////

-(CALayer*)createLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset {
    return [self getOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

-(UIView*)createViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
    return border;
}

-(void)addLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset {
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

-(void)addViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self createViewBackedLeftBorderWithWidth:width color:color leftOffset:leftOffset topOffset:topOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
    NSArray<__kindof NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[border(%f)]",width] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];
    [self addConstraints:constraints];
}


//////////
// Right
//////////

-(CALayer*)createRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    return [self createRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

-(UIView*)createViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    return [self createViewBackedRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

-(void)addRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    [self addRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

-(void)addViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color{
    [self addViewBackedRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}



//////////
// Right + Offset
//////////

-(CALayer*)createRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    
    // Subtract bottomOffset from the height to get our end.
    return [self getOneSidedBorderWithFrame:CGRectMake(self.frame.size.width-width-rightOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

-(UIView*)createViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(self.frame.size.width-width-rightOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
    return border;
}

-(void)addRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    
    // Subtract the rightOffset from our width + thickness to get our final x position.
    // Add topOffset to our y to get our start y position.
    // Subtract topOffset from our height, so our border doesn't extend past teh view.
    // Subtract bottomOffset from the height to get our end.
    [self addOneSidedBorderWithFrame:CGRectMake(self.frame.size.width-width-rightOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

-(void)addViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *border = [self createViewBackedRightBorderWithWidth:width color:color rightOffset:rightOffset topOffset:topOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
    NSArray<__kindof NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[border(%f)]|",width] options:0 metrics:nil views:NSDictionaryOfVariableBindings(border)];
    [self addConstraints:constraints];
}

//////////
// Private: Our methods call these to add their borders.
//////////

-(void)addOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    CALayer *border = [self getOneSidedBorderWithFrame:frame andColor:color];
    [self.layer addSublayer:border];
}

-(CALayer*)getOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    [border setBackgroundColor:color.CGColor];
    return border;
}

-(UIView*)getViewBackedOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    UIView *border = [[UIView alloc]initWithFrame:frame];
    [border setBackgroundColor:color];
    return border;
}

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
@end
