#define _GNU_SOURCE

#import <MulleFoundation/MulleFoundation.h>

#import <MulleFoundation/private/mulle-foundation-startup-private.inc>


#define FOUNDATION_STARTUP_VERSION  ((0 << 20) | (19 << 8) | 0)


static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
{
   struct _mulle_objc_universeconfiguration   config;

   mulle_foundation_universeconfiguration_set_defaults( &config);
   MulleFoundationBang( universe, allocator, &config);
}
