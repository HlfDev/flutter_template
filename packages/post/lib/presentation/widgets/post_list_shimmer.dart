import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DSColors.lightGrey20,
      highlightColor: DSColors.lightGrey10,
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
                height: DSSizes.sizeLarge,
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
