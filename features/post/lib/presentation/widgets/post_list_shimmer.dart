import 'package:shimmer/shimmer.dart';
import 'package:design_system/tokens/ds_colors.dart';
import 'package:design_system/tokens/ds_sizes.dart';
import 'package:flutter/material.dart';

class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DSColors.neutral200,
      highlightColor: DSColors.neutral100,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: DSSizes.sizeXXL,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DSSizes.radiusXL),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: DSSizes.sizeL)),
          SliverList.separated(
            itemCount: 2,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              return Container(
                height: DSSizes.sizeL,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DSSizes.sizeM),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
