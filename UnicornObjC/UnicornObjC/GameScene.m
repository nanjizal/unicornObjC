//
//  GameScene.m
//  UnicornObjC
//
//  Created by justin on 09/09/2016.
//  Copyright (c) 2016 justin. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (instancetype)init {
    self = [super init];
    if (self) {
        self.canvasWidth = 800;
        self.canvasHeight = 800;
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    self.canvasWidth = 800;
    self.canvasHeight = 800;
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0.0f, -6.0f);
    SKPhysicsBody* physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = physicsBody;
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];
    [self setupGallopFrames];
    SKTexture * firstFrame = _gallopFrames[0];
    _unicorn = [SKSpriteNode spriteNodeWithTexture:firstFrame];
    _unicorn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_unicorn];
    [self gallop];
    _unicorn.physicsBody = [SKPhysicsBody bodyWithTexture:firstFrame size:_unicorn.size];
    // this defines the mass, roughness and bounciness
    _unicorn.physicsBody.friction = 0.3f;
    _unicorn.physicsBody.restitution = 0.8f;
    _unicorn.physicsBody.mass = 0.5f;
    // this will allow the balls to rotate when bouncing off each other
    _unicorn.physicsBody.allowsRotation = NO;
    // let's create 20 bouncing balls
    for ( uint i = 0; i < 30; i++ ) {

        // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
        // it has built in support for primitives like a circle, so we pass a radius
        SKShapeNode * shape = [SKShapeNode shapeNodeWithCircleOfRadius:20.0f];
        // we set the color and line style
        shape.strokeColor = [UIColor colorWithRed:255.0f green:0.0f blue:0.0f alpha:0.5 ];
        shape.lineWidth = 4.0f;
        // we create a text node to embed text in our ball
        SKLabelNode * text = [SKLabelNode labelNodeWithFontNamed:[NSString stringWithFormat:@"%d", i] ];
        // we set the font
        text.fontSize = 9.0f;
        // we nest the text label in our ball
        [shape addChild:text];

        // we set initial random positions[arc4random]%
        
        shape.position = CGPointMake( arc4random()%_canvasWidth,arc4random()%_canvasHeight);
        // we add each circle to the display list
        [self addChild:shape];

        // this is the most important line, we define the body
        shape.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:shape.frame.size.width/2];
        // this defines the mass, roughness and bounciness
        shape.physicsBody.friction = 0.3f;
        shape.physicsBody.restitution = 0.8f;
        shape.physicsBody.mass = 0.5f;
        // this will allow the balls to rotate when bouncing off each other
        shape.physicsBody.allowsRotation = YES;
    }
}

-(void)setupGallopFrames{
    SKTextureAtlas * unicornSequence = [SKTextureAtlas atlasNamed: @"unicornSequence"];
    _gallopFrames = [NSMutableArray array];
    NSUInteger numImages = unicornSequence.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *unicornTextureName = [NSString stringWithFormat:@"unicornAnimation000%d", i];
        SKTexture *temp = [unicornSequence textureNamed:unicornTextureName];
        [_gallopFrames addObject:temp];
    }
    return;
}

-(void)gallop{
    [_unicorn runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:_gallopFrames
                                       timePerFrame:0.05f
                                             resize:NO
                                            restore:YES]] withKey:@"galloping"];
    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        _unicorn.position = location;
        /*SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];*/
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if( _unicorn != nil ){
        //unicorn.physicsBody = SKPhysicsBody(texture: unicorn.!texture, size: unicorn.size)
        //print( unicorn.texture )
    }
   // if unicorn != nil { unicorn.zRotation += CGFloat(M_PI/30) }
}

@end
