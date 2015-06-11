//
//  LLCollectionViewFlowLayout.m
//  CollectionAnimation
//
//  Created by lidehua on 15/4/30.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

#import "LLCollectionViewFlowLayout.h"
@interface LLCollectionViewFlowLayout()
@property (nonatomic, strong) UIDynamicAnimator * animator;
@end
@implementation LLCollectionViewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray * items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        for (UICollectionViewLayoutAttributes * attribute in items) {
            UIAttachmentBehavior * spring = [[UIAttachmentBehavior alloc] initWithItem:attribute attachedToAnchor:attribute.center];
            spring.length = 1.0;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [_animator addBehavior:spring];
        }
        //NSArray * array = _animator.behaviors;
    }
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect:rect];
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView * scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    //NSArray * array = _animator.behaviors;
    for (UIAttachmentBehavior * spring in _animator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 500;
        
        UICollectionViewLayoutAttributes * item = [spring.items firstObject];
        CGPoint center = item.center;
        
        center.y += (scrollDelta > 0) ? MIN(scrollDelta, scrollDelta * scrollResistance) : MAX(scrollDelta, scrollDelta * scrollResistance);
        item.center = center;
        
        [_animator updateItemUsingCurrentState:item];
    }
    return NO;
}
@end
