//
//  AARAsynchronousImageLoader.h
//  AdiumAvatarRandomizer
//
//  Created by Thijs Alkemade on 20-09-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adium/AIListObject.h>
#import "AARPlugin.h"

@interface AARAsynchronousImageLoader : NSObject {
	NSMutableData *imageData;
	AIListObject *object;
	
	AARPlugin *delegate;
}

@property (readwrite, retain) AIListObject *object;
@property (readwrite, retain) AARPlugin *delegate;

- (id)initWithListObject:(AIListObject *)inObject delegate:(AARPlugin *)plugin;
- (void)start;

@end
