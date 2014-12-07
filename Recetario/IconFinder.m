//
//  IconFinder.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/21/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "IconFinder.h"

@implementation IconFinder {
    
    NSMutableDictionary *ingredientImageMapping;
    NSMutableDictionary *stepsImageMapping;
    
}

static IconFinder *sharedSingleton;

-(id)init {
    if ( self = [super init] ) {
        ingredientImageMapping = [self loadWithFilter:@"ingr_"];
        stepsImageMapping = [self loadWithFilter:@"accion_"];
        
    }
    return self;
}

+ (IconFinder *)sharedSingleton {
    @synchronized(self) {
        if (sharedSingleton == NULL)
            sharedSingleton = [[self alloc] init];
    }
    return(sharedSingleton);
}

- (NSString*) guessIngredientIconFromString:(NSString*) text {
    if (text == nil) {
        return nil;
    }
    
    NSSet *wordsToGuess = [self sanitizedText:text];
    NSString * ret = [self guessIconName:wordsToGuess with:ingredientImageMapping];
    
    return ret;
    
}

- (NSString*) guessRecipeStepIconFromString:(NSString*) text {
    
    if (text == nil) {
        return nil;
    }
    
    NSSet *wordsToGuess = [self sanitizedText:text];
    NSString * ret = [self guessIconName:wordsToGuess with:stepsImageMapping];
    
    if (ret == nil) {
        ret = [self guessIconName:wordsToGuess with:ingredientImageMapping];
    }
    return ret;
}

// sanitize the NSString by doing:
// * remove non-literal characters
// * lowercase
// * remove acents
- (NSMutableSet *)sanitizedText:(NSString *)text {
    // Turn accented letters into normal letters (optional)
    NSData *sanitizedData = [[text lowercaseString] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *sanitizedText = [NSString stringWithCString:[sanitizedData bytes] encoding:NSASCIIStringEncoding];
    
    // Prepare a word bag from the text
    NSSet *words = [NSSet setWithArray:[sanitizedText componentsSeparatedByString:@" "]];
    NSMutableSet *wordsToGuess = [[NSMutableSet alloc] init];
    NSCharacterSet *notAllowedChars = [[NSCharacterSet letterCharacterSet] invertedSet];
    
    for(NSString* w in words) {
        NSString *word = [[w componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        [wordsToGuess addObject:word];
    }
    return wordsToGuess;
}

- (NSString*) guessIconName:(NSSet*) textWords with:(NSMutableDictionary*) imageMapping {
    if (imageMapping == nil) return nil;
    
    for (NSString* key in imageMapping) {
        // Take each word from the imagemapping -- make sure it is lowercase
        NSString *word = [key lowercaseString];
        // Hernan:HACK heuristic, find this image and a plural form
        if ( [textWords containsObject:word] || [textWords containsObject:[NSString stringWithFormat:@"%@s",word]]) {
            return [imageMapping objectForKey:key];
        }
    }
    return nil;
}


- (NSMutableDictionary*) loadWithFilter:(NSString*)filter {
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] init];
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self BEGINSWITH '%@'", filter]];
    NSArray *onlyIngrs = [dirContents filteredArrayUsingPredicate:fltr];
    
    int start = [filter length];
    
    for (NSString* img in onlyIngrs) {
        NSRange range = NSMakeRange(start,  img.length - (4+start));
        NSString *key = [img substringWithRange:range];
        [ret setValue:img forKey:key];
    }
    
    return ret;
    
}

@end
