#define _GNU_SOURCE

#import <MulleFoundation/MulleFoundation.h>

#import <MulleFoundation/mulle-foundation-startup-private.inc>


#define FOUNDATION__STARTUP_VERSION  ((0UL << 20) | (20 << 8) | 6)


static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
{
   struct _mulle_objc_universeconfiguration   config;

   mulle_foundation_universeconfiguration_set_defaults( &config);
   MulleFoundationBang( universe, allocator, &config);
}
