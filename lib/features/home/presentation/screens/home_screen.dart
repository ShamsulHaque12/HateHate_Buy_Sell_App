import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import '../../domain/entities/category_item.dart';
import '../../domain/entities/product.dart';
import '../widgets/home_header_app_bar.dart';
import '../widgets/home_search_and_radius_box.dart';
import '../widgets/home_category_slider.dart';
import '../widgets/home_safety_banner.dart';
import '../widgets/home_featured_carousel.dart';
import '../widgets/home_nearby_products_section.dart';
import '../widgets/home_filter_chips_bar.dart';
import '../widgets/home_latest_products_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _currentLocation = 'মিরপুর, ঢাকা';
  String _currentRadius = '২ কিমি ব্যাসার্ধ';

  // Categories Mock Data
  late final List<CategoryItem> _categories = [
    const CategoryItem(
      id: 'mobile',
      titleBn: 'মোবাইল',
      titleEn: 'Mobile',
      icon: Icons.phone_android_rounded,
    ),
    const CategoryItem(
      id: 'laptop',
      titleBn: 'ল্যাপটপ',
      titleEn: 'Laptop',
      icon: Icons.laptop_mac_rounded,
    ),
    const CategoryItem(
      id: 'bike',
      titleBn: 'বাইক',
      titleEn: 'Bike',
      icon: Icons.two_wheeler_rounded,
    ),
    const CategoryItem(
      id: 'electronics',
      titleBn: 'ইলেকট্রনিক্স',
      titleEn: 'Electronics',
      icon: Icons.tv_rounded,
    ),
    const CategoryItem(
      id: 'furniture',
      titleBn: 'ফার্নিচার',
      titleEn: 'Furniture',
      icon: Icons.chair_rounded,
    ),
    const CategoryItem(
      id: 'fashion',
      titleBn: 'ফ্যাশন',
      titleEn: 'Fashion',
      icon: Icons.checkroom_rounded,
    ),
    const CategoryItem(
      id: 'property',
      titleBn: 'প্রোপার্টি',
      titleEn: 'Property',
      icon: Icons.home_work_rounded,
    ),
    const CategoryItem(
      id: 'car',
      titleBn: 'গাড়ি',
      titleEn: 'Car',
      icon: Icons.directions_car_rounded,
    ),
  ];

  // Featured Products
  late List<Product> _featuredProducts = [
    const Product(
      id: 'feat_1',
      title: 'iPhone 14 Pro Max 256GB',
      price: '৳ ৮৮,৫০০',
      imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=80',
      location: 'মিরপুর, ঢাকা',
      timeAgo: '১০ মিনিট আগে',
      badge: 'ফিচার্ড',
      tag: 'দরদাম হবে',
      isFeatured: true,
      isNidVerified: true,
    ),
    const Product(
      id: 'feat_2',
      title: 'Yamaha R15 V3 (Special Edition)',
      price: '৳ ৩,৪৫,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=600&auto=format&fit=crop&q=80',
      location: 'উত্তরা, ঢাকা',
      timeAgo: '১ ঘন্টা আগে',
      badge: 'ফিচার্ড',
      tag: 'কাগজপত্র ওকে',
      isFeatured: true,
      isNidVerified: true,
    ),
    const Product(
      id: 'feat_3',
      title: 'MacBook Air M2 8/256GB Space Grey',
      price: '৳ ১,০৫,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80',
      location: 'ধানমন্ডি, ঢাকা',
      timeAgo: '২ ঘন্টা আগে',
      badge: 'ফিচার্ড',
      tag: 'ফুল বক্স',
      isFeatured: true,
      isNidVerified: true,
    ),
  ];

  // Hyperlocal Nearby Products
  late final List<Product> _nearbyProducts = [
    const Product(
      id: 'near_1',
      title: 'Sony WH-1000XM4 Headphone',
      price: '৳ ১৬,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80',
      location: 'মিরপুর ১০',
      timeAgo: '৫ মিনিট আগে',
      distance: '৫০০ মি.',
      tag: 'সরাসরি দেখে নিন',
    ),
    const Product(
      id: 'near_2',
      title: 'স্টাডি টেবিল ও রিভলভিং চেয়ার',
      price: '৳ ৪,৫০০',
      imageUrl: 'https://images.unsplash.com/photo-1580481077111-6677f98555e0?w=600&auto=format&fit=crop&q=80',
      location: 'মিরপুর ২',
      timeAgo: '২০ মিনিট আগে',
      distance: '১.২ কিমি',
      tag: 'জরুরী বিক্রি',
    ),
    const Product(
      id: 'near_3',
      title: 'Samsung Galaxy S23 Ultra 12/256GB',
      price: '৳ ৭২,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&auto=format&fit=crop&q=80',
      location: 'মিরপুর ১১',
      timeAgo: '৩৫ মিনিট আগে',
      distance: '১.৮ কিমি',
      tag: 'বক্স ও ওয়ারেন্টিসহ',
    ),
  ];

  // Latest Products
  late List<Product> _latestProducts = [
    const Product(
      id: 'lat_1',
      title: 'Canon EOS 200D Mark II Lens সহ',
      price: '৳ ৪২,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&auto=format&fit=crop&q=80',
      location: 'মোহাম্মদপুর, ঢাকা',
      timeAgo: '১৫ মিনিট আগে',
      tag: 'অনুমোদিত',
      isNidVerified: true,
    ),
    const Product(
      id: 'lat_2',
      title: 'Walton Inverter Refrigerator (Good Condition)',
      price: '৳ ১৮,৫০০',
      imageUrl: 'https://images.unsplash.com/photo-1584992236310-6edddc08acff?w=600&auto=format&fit=crop&q=80',
      location: 'বাড্ডা, ঢাকা',
      timeAgo: '৩০ মিনিট আগে',
      tag: '১ বছর ব্যবহার',
      isNidVerified: false,
    ),
    const Product(
      id: 'lat_3',
      title: 'Apple Watch Series 8 45mm GPS',
      price: '৳ ২৮,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=600&auto=format&fit=crop&q=80',
      location: 'গুলশান, ঢাকা',
      timeAgo: '১ ঘণ্টা আগে',
      tag: 'অনুমোদিত',
      isNidVerified: true,
    ),
    const Product(
      id: 'lat_4',
      title: 'Hero Glamour 125cc বাইক',
      price: '৳ ৮৫,০০০',
      imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&auto=format&fit=crop&q=80',
      location: 'লালবাগ, ঢাকা',
      timeAgo: '২ ঘণ্টা আগে',
      tag: 'কাগজপত্র ওকে',
      isNidVerified: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFeaturedFavorite(Product product) {
    setState(() {
      _featuredProducts = _featuredProducts.map((p) {
        if (p.id == product.id) {
          return p.copyWith(isFavorite: !p.isFavorite);
        }
        return p;
      }).toList();
    });
  }

  void _toggleLatestFavorite(Product product) {
    setState(() {
      _latestProducts = _latestProducts.map((p) {
        if (p.id == product.id) {
          return p.copyWith(isFavorite: !p.isFavorite);
        }
        return p;
      }).toList();
    });
  }

  void _showLocationSheet(BuildContext context, bool isBengali) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final locations = [
          'মিরপুর ১০, ঢাকা (Mirpur 10, Dhaka)',
          'মিরপুর ২, ঢাকা (Mirpur 2, Dhaka)',
          'উত্তরা, ঢাকা (Uttara, Dhaka)',
          'ধানমন্ডি, ঢাকা (Dhanmondi, Dhaka)',
          'গুলশান, ঢাকা (Gulshan, Dhaka)',
          'মোহাম্মদপুর, ঢাকা (Mohammadpur, Dhaka)',
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBengali ? 'এলাকা পরিবর্তন করুন' : 'Change Location',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...locations.map((loc) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                    title: Text(loc, style: const TextStyle(fontSize: 14)),
                    trailing: _currentLocation.contains(loc.split(',')[0])
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() {
                        _currentLocation = loc.split(' (')[0];
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRadiusSheet(BuildContext context, bool isBengali) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final radii = [
          {'bn': '১ কিমি ব্যাসার্ধ', 'en': '1 km radius'},
          {'bn': '২ কিমি ব্যাসার্ধ', 'en': '2 km radius'},
          {'bn': '৫ কিমি ব্যাসার্ধ', 'en': '5 km radius'},
          {'bn': '১০ কিমি ব্যাসার্ধ', 'en': '10 km radius'},
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBengali ? 'দূরত্ব বা ব্যাসার্ধ নির্ধারণ' : 'Set Hyperlocal Radius',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                ...radii.map((r) {
                  final label = isBengali ? r['bn']! : r['en']!;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.radar_rounded, color: AppColors.primary),
                    title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: _currentRadius == label
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() {
                        _currentRadius = label;
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Product> _getFilteredProducts() {
    if (_selectedFilter == 'verified') {
      return _latestProducts.where((p) => p.isNidVerified).toList();
    } else if (_selectedFilter == 'urgent') {
      return _latestProducts.where((p) => p.tag?.contains('জরুরী') ?? false).toList();
    } else if (_selectedFilter == 'negotiable') {
      return _latestProducts.where((p) => p.tag?.contains('দরদাম') ?? false).toList();
    }
    return _latestProducts;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, child) {
        final displayedLatestProducts = _getFilteredProducts();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: HomeHeaderAppBar(
            isBengali: isBengali,
            location: _currentLocation,
            onLocationTap: () => _showLocationSheet(context, isBengali),
            onNotificationTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isBengali ? 'নতুন কোনো নোটিফিকেশন নেই' : 'No new notifications',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          body: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110), // safe space above bottom navigation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // 1. Search Box
                  HomeSearchAndRadiusBox(
                    isBengali: isBengali,
                    searchController: _searchController,
                    onSearchChanged: (val) {
                      setState(() {});
                    },
                    onVoiceSearchTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBengali ? 'ভয়েস সার্চ শীঘ্রই আসছে...' : 'Voice search coming soon...',
                          ),
                        ),
                      );
                    },
                    onFilterTap: () {
                      _showRadiusSheet(context, isBengali);
                    },
                  ),
                  const SizedBox(height: 20),

                  // 2. Categories Slider
                  HomeCategorySlider(
                    isBengali: isBengali,
                    categories: _categories,
                    onCategoryTap: (category) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBengali
                                ? '${category.titleBn} ক্যাটাগরি নির্বাচিত হয়েছে'
                                : '${category.titleEn} category selected',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onSeeAllTap: () {
                      // Navigate to Category tab
                    },
                  ),
                  const SizedBox(height: 16),

                  // 3. Safety Trust Banner
                  HomeSafetyBanner(
                    isBengali: isBengali,
                  ),
                  const SizedBox(height: 24),

                  // 4. Featured / Highlighted Products Carousel
                  HomeFeaturedCarousel(
                    isBengali: isBengali,
                    products: _featuredProducts,
                    onProductTap: (product) {
                      // Navigate to product detail
                    },
                    onFavoriteTap: _toggleFeaturedFavorite,
                  ),
                  const SizedBox(height: 24),

                  // 5. Hyperlocal Nearby Products Section
                  HomeNearbyProductsSection(
                    isBengali: isBengali,
                    locationBadge: '$_currentLocation ($_currentRadius)',
                    products: _nearbyProducts,
                    onProductTap: (product) {
                      // Navigate to product detail
                    },
                    onChatTap: (product) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBengali
                                ? '${product.title}-এর বিক্রেতার সাথে চ্যাট খুলছে...'
                                : 'Opening chat with seller of ${product.title}...',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // 6. Interactive Filter Chips Bar
                  HomeFilterChipsBar(
                    isBengali: isBengali,
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filterId) {
                      setState(() {
                        _selectedFilter = filterId;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // 7. Newly Posted Ads (2-Column Grid)
                  HomeLatestProductsGrid(
                    isBengali: isBengali,
                    products: displayedLatestProducts.isEmpty
                        ? _latestProducts
                        : displayedLatestProducts,
                    onProductTap: (product) {
                      // Navigate to product detail
                    },
                    onFavoriteTap: _toggleLatestFavorite,
                    onSortTap: () {
                      setState(() {
                        _latestProducts = _latestProducts.reversed.toList();
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // 8. Load More Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isBengali
                                    ? 'সব বিজ্ঞাপন লোড করা হয়েছে'
                                    : 'All ads loaded',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.expand_more_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          isBengali ? 'আরও বিজ্ঞাপন দেখুন' : 'Load More Ads',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.surfaceContainerHighest,
                            width: 1.2,
                          ),
                          backgroundColor: AppColors.surfaceContainerLowest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
