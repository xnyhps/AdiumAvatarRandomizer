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
#import <CommonCrypto/CommonDigest.h>

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
	return AIUserIconMediumPriority;
}

- (AIUserIconSourceQueryResult)updateUserIconForObject:(AIListObject *)inObject
{
	//NSLog(@"Should find icon for %@", inObject);
	
	AIListContact *contact = (AIListContact *)inObject;
	
	const char *chr = [[contact UID] UTF8String];
	unsigned char result[16];
	CC_MD5(chr, strlen(chr), result);
	
	NSString *MD5UID = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						result[0], result[1], result[2], result[3], 
						result[4], result[5], result[6], result[7],
						result[8], result[9], result[10], result[11],
						result[12], result[13], result[14], result[15]
						];
	
	NSURL *gravatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@.jpg?d=identicon", MD5UID]];
	NSImage *icon = [[[NSImage alloc] initWithContentsOfURL:gravatarURL] autorelease];
	
	NSLog(@"Found: %@", icon);
	
	[AIUserIcons userIconSource:self
		   didDetermineUserIcon:icon
				 asynchronously:NO
					  forObject:inObject];
	
	return AIUserIconSourceFoundIcon;
}

@end