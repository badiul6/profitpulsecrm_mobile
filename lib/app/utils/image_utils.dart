import 'package:flutter_svg/svg.dart';

class ImageUtils {
    
      static const String landing = 'assets/images/landing_page.svg';
      static const String logo = 'assets/images/logo.svg';
      static const String appIcon = 'assets/images/appIcon.svg';
      static const String marketing = 'assets/images/marketing.svg';
      static const String sale = 'assets/images/sales.svg';
      static const String cs = 'assets/images/cs.svg';
    
     static void svgPrecacheImage() {

        const cacheSvgImages = [  /// Specify the all the svg image to cache 
          ImageUtils.landing,
          ImageUtils.logo,
          ImageUtils.marketing,
          ImageUtils.sale,
          ImageUtils.cs
        ];
    
        for (String element in cacheSvgImages) {
          var loader = SvgAssetLoader(element);
          svg.cache
              .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
        }

      }
    
    }