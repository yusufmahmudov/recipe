import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
// import 'package:recipe/infrastructure/core/context_extension.dart';

class CommercialTab extends StatelessWidget {
  const CommercialTab({
    this.tabController,
    required this.onTabTap,
    required this.tabLabels,
    super.key,
  });

  final TabController? tabController;
  final List<String> tabLabels;
  final ValueChanged<int> onTabTap;

  @override
  Widget build(BuildContext context) => Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: borderColor,
        ),
        padding: const EdgeInsets.all(2),
        child: TabBar(
          dividerColor: Colors.transparent,
          onTap: onTabTap,
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: black,
            // Theme.of(context).extension<ThemedColors>()!.whiteToDolphin,
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.04),
                blurRadius: 1,
                offset: const Offset(0, 3),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          labelPadding: EdgeInsets.zero,
          unselectedLabelStyle:
              Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
          labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: white,
              ),
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: white,
          tabs: [
            for (int i = 0; i < tabLabels.length - 1; i++)
              Row(
                children: [
                  Expanded(child: Tab(text: tabLabels[i])),
                  const VerticalDivider(
                    color: Color(0xFFAFB8C1),
                    thickness: 0.65,
                    width: 0.65,
                    indent: 5,
                    endIndent: 2,
                  )
                ],
              ),
            Tab(text: tabLabels.last),
          ],
        ),
      );
}
