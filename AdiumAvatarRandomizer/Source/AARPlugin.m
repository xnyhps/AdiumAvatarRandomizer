//
//  AARPlugin.m
//  AdiumAvatarRandomizer
//
//  Created by Thijs Alkemade on 20-09-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AARPlugin.h"
#import <Adium/AIListContact.h>
#import <Adium/AIListObject.h>
#import "AARAsynchronousImageLoader.h"

@implementation AARPlugin

- (void)installPlugin
{
	[AIUserIcons registerUserIconSource:self];
}

- (void)uninstallPlugin
{
}

- (AIUserIconPriority)priority
{
	return AIUserIconLowPriority;
}

- (AIUserIconSourceQueryResult)updateUserIconForObject:(AIListObject *)inObject
{
	//NSLog(@"Should find icon for %@", inObject);
	AARAsynchronousImageLoader *loader = [[AARAsynchronousImageLoader alloc] initWithListObject:inObject delegate:self];
	
	[loader start];
	
	return AIUserIconSourceLookingUpIconAsynchronously;
}

@end