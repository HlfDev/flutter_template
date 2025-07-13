import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey20,
      highlightColor: AppColors.lightGrey10,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: kSize48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kBorderRadius24),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: kSize24)),
          SliverList.separated(
            itemCount: 2,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              return Container(
                height: kSize60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kSize16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
