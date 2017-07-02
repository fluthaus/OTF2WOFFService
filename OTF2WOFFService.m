/*

 OTF2WOFFService - an OS X service to convert OTF files to WOFF files and vice versa.
 Copyright (C) 2011-2017 NoHalfBits | fluthaus (nohalfbits0x40fluthaus0x2Ede)
 Project available at https://github.com/fluthaus/OTF2WOFFService

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 */

// OTF2WOFFServive exists as an Objective-C class only because the calling conventions for OS X services are defined this way; otherwise, there is no need for an instance - no ivars, no inheritance etc. To emphasise this, most of the functionality here is deliberately placed in plain c functions. 

#import "OTF2WOFFService.h"
#import "woff.h"

@implementation OTF2WOFFService

const uint8_t* convert2OTF(const uint8_t* srcData, uint32_t srcLength, uint32_t* dstLength, uint32_t* status)
{
	return woffDecode( srcData, srcLength, dstLength, status);
}

const uint8_t* convert2WOFF(const uint8_t* srcData, uint32_t srcLength, uint32_t* dstLength, uint32_t* status)
{
	return woffEncode( srcData, srcLength, 1, 0, dstLength, status);
}

NSString* uniquePathFromPath(NSString* inPath)
{
	if (![[NSFileManager defaultManager] fileExistsAtPath:inPath])
		return inPath;

	for (int i = 2;;i++)
	{
		NSString* outPath = [NSString stringWithFormat:@"%@ %d.%@", [inPath stringByDeletingPathExtension], i, [inPath pathExtension]];
		if (![[NSFileManager defaultManager] fileExistsAtPath:outPath])
			return outPath;
	}
}

#define HandleDataError( cond, file, action, err) if (cond) { NSLog( @"OTF2WOFF.service: %s of '%@' failed with error = %@", action, file, err); return; }
#define HandleWoffError( cond, file, status) if (cond) { NSLog( @"OTF2WOFF.service: conversion of '%@' failed with status = 0x%x (see 'woff.h' for status codes)", file, status); return; }

void convertFiles( NSPasteboard* pboard, const uint8_t*(*conversionFunction)(const uint8_t*, uint32_t, uint32_t*, uint32_t*), NSString* extension, NSString** outError)
{
	for (NSString* filePath in [pboard propertyListForType:NSFilenamesPboardType])
	{
		@autoreleasepool
		{
			NSError* error = nil;

			NSData* srcData = [NSData dataWithContentsOfFile:[filePath stringByStandardizingPath] options:0 error:&error];
			HandleDataError( !srcData, filePath, "reading", error);

			uint32_t status = 0;
			uint32_t dstLength = 0;
			void* dstData = (void*)(*conversionFunction)((const uint8_t*)(srcData.bytes), (uint32_t)(srcData.length), &dstLength, &status);
			HandleWoffError( !WOFF_SUCCESS(status) || (dstData == NULL), filePath, status);

			BOOL writeOK = [[NSData dataWithBytesNoCopy:dstData length:dstLength freeWhenDone:YES] writeToFile:uniquePathFromPath([[filePath stringByDeletingPathExtension] stringByAppendingPathExtension:extension]) options:0 error:&error];
			HandleDataError( !writeOK, filePath, "writing", error);
		}
	}
}

#pragma mark - Public Interface

-(void)otf2woff:(NSPasteboard*)pasteBoard userData:(NSString*)userData error:(NSString**)error
{
	convertFiles( pasteBoard, &convert2WOFF, @"woff", error);
}


-(void)woff2otf:(NSPasteboard*)pasteBoard userData:(NSString*)userData error:(NSString**)error
{
	convertFiles( pasteBoard, &convert2OTF, @"otf", error);
}

@end
