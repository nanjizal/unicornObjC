//
//  GameScene.h
//  UnicornObjC
//

//  Copyright (c) 2016 justin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene
@property uint canvasWidth;
@property uint canvasHeight;
@property SKSpriteNode * unicorn;
@property NSMutableArray * gallopFrames;//SKTexture

@end
