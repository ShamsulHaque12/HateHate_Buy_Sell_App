import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import '../../data/category_data.dart';
import '../../domain/entities/category_model.dart';
import '../widgets/category_header_app_bar.dart';
import '../widgets/category_search_bar.dart';
import '../widgets/category_tabs_header.dart';
import '../widgets/all_categories_grid_view.dart';
import '../widgets/single_category_tab_view.dart';
import '../widgets/category_search_results.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _currentLocation = 'মিরপুর ১০, ঢাকা';

  final List<CategoryItemData> _categories = CategoryData.categories;
  TabController? _tabController;

  TabController get _effectiveTabController {
    if (_tabController == null) {
      _initTabController();
    }
    return _tabController!;
  }

  void _initTabController() {
    _tabController = TabController(length: _categories.length + 1, vsync: this);
    _tabController!.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!(_tabController?.indexIsChanging ?? false)) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initTabController();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (_tabController == null) {
      _initTabController();
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    _effectiveTabController.animateTo(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    setState(() {});
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

  void _showPostAdSheet(BuildContext context, bool isBengali) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBengali
              ? 'বিজ্ঞাপন তৈরির পেজ শীঘ্রই আসছে...'
              : 'Post ad page coming soon...',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CategoryHeaderAppBar(
            isBengali: isBengali,
            location: _currentLocation,
            onLocationTap: () => _showLocationSheet(context, isBengali),
          ),
          body: Column(
            children: [
              const SizedBox(height: 8),

              // Search Bar
              CategorySearchBar(
                isBengali: isBengali,
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                onClear: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
                onVoiceTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBengali
                            ? 'ভয়েস সার্চ শীঘ্রই আসছে...'
                            : 'Voice search coming soon...',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Horizontal Category Pill Tabs (hidden during search)
              if (_searchQuery.isEmpty) ...[
                CategoryTabsHeader(
                  isBengali: isBengali,
                  categories: _categories,
                  selectedIndex: _effectiveTabController.index,
                  onTabSelected: _onTabSelected,
                ),
                const SizedBox(height: 8),
              ],

              // Main Body: Search Results OR Swipeable TabBarView
              Expanded(
                child: _searchQuery.isNotEmpty
                    ? CategorySearchResults(
                        isBengali: isBengali,
                        query: _searchQuery,
                        categories: _categories,
                        onCategoryTap: (cat) {
                          final catIndex = _categories.indexWhere((c) => c.id == cat.id);
                          if (catIndex != -1) {
                            _onTabSelected(catIndex + 1);
                          }
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                        onSubCategoryTap: (sub) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isBengali
                                    ? '${sub.nameBn}-এর বিজ্ঞাপন লোড হচ্ছে...'
                                    : 'Loading ${sub.nameEn} ads...',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      )
                    : TabBarView(
                        controller: _effectiveTabController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // Tab 0: All Categories Overview Grid
                          AllCategoriesGridView(
                            isBengali: isBengali,
                            categories: _categories,
                            onCategoryCardTap: (tabIndex) {
                              _onTabSelected(tabIndex);
                            },
                            onPostAdTap: () => _showPostAdSheet(context, isBengali),
                          ),

                          // Tabs 1 to 8: Individual Category Views (Swipeable!)
                          ..._categories.map((cat) {
                            return SingleCategoryTabView(
                              isBengali: isBengali,
                              category: cat,
                              onSubCategoryTap: (sub) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isBengali
                                          ? '${sub.nameBn} ক্যাটাগরির পণ্য লোড হচ্ছে...'
                                          : 'Loading ${sub.nameEn} products...',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onTagTap: (tag) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isBengali
                                          ? '"$tag" অনুসন্ধান করা হচ্ছে...'
                                          : 'Searching for "$tag"...',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onViewAllAdsTap: () {
                                final title = isBengali ? cat.titleBn : cat.titleEn;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isBengali
                                          ? '$title-এর সকল বিজ্ঞাপন খুলছে...'
                                          : 'Opening all $title ads...',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onPostAdTap: () => _showPostAdSheet(context, isBengali),
                            );
                          }),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
