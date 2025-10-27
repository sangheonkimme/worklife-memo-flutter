import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 앱 Shimmer 로딩 효과
/// 콘텐츠 로딩 중 스켈레톤 UI 표시
class AppShimmerLoading extends StatelessWidget {
  final Widget child;

  const AppShimmerLoading({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: child,
    );
  }
}

/// Shimmer 박스 (사각형 스켈레톤)
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

/// 메모 카드 스켈레톤
class NoteCardShimmer extends StatelessWidget {
  const NoteCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              const ShimmerBox(
                width: 200,
                height: 20,
              ),
              const SizedBox(height: 8),
              // 내용 1줄
              const ShimmerBox(
                width: double.infinity,
                height: 16,
              ),
              const SizedBox(height: 4),
              // 내용 2줄
              const ShimmerBox(
                width: double.infinity,
                height: 16,
              ),
              const SizedBox(height: 4),
              // 내용 3줄 (짧음)
              ShimmerBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 16,
              ),
              const SizedBox(height: 12),
              // 태그들
              Row(
                children: [
                  const ShimmerBox(width: 60, height: 24),
                  const SizedBox(width: 8),
                  const ShimmerBox(width: 80, height: 24),
                  const SizedBox(width: 8),
                  const ShimmerBox(width: 50, height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 메모 리스트 스켈레톤
class NoteListShimmer extends StatelessWidget {
  final int itemCount;

  const NoteListShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => const NoteCardShimmer(),
    );
  }
}

/// 폴더 아이템 스켈레톤
class FolderItemShimmer extends StatelessWidget {
  const FolderItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      child: ListTile(
        leading: const ShimmerBox(width: 40, height: 40),
        title: const ShimmerBox(width: 150, height: 16),
        subtitle: const ShimmerBox(width: 100, height: 12),
        trailing: const ShimmerBox(width: 30, height: 30),
      ),
    );
  }
}

/// 태그 칩 스켈레톤
class TagChipShimmer extends StatelessWidget {
  const TagChipShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      child: ShimmerBox(
        width: 80,
        height: 32,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
