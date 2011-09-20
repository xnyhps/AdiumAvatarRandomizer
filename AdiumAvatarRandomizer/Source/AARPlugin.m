//
//  AARPlugin.m
//  AdiumAvatarRandomizer
//
//  Created by Thijs Alkemade on 20-09-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AARPlugin.h"

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
	NSLog(@"Should find icon for %@", inObject);
	return AIUserIconSourceDidNotFindIcon;
}

@end
