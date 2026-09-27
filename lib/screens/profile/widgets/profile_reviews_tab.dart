import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_review_card.dart';

import '../../../core/features/profile_reviews/profile_review_controller.dart';

class ProfileReviewsTab extends ConsumerStatefulWidget {
  final String userId;

  const ProfileReviewsTab({super.key, required this.userId});

  @override
  ConsumerState<ProfileReviewsTab> createState() => _ProfileReviewsTabState();
}

class _ProfileReviewsTabState extends ConsumerState<ProfileReviewsTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      final state = ref.read(profileReviewProvider);

      if (state.hasMore && !state.isLoadingMore) {
        ref
            .read(profileReviewProvider.notifier)
            .loadReviews(userId: widget.userId, page: state.currentPage + 1);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileReviewProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.errorMessage!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(profileReviewProvider.notifier)
                    .loadReviews(userId: widget.userId);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.reviews.isEmpty) {
      return const Center(child: Text('No reviews yet'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: state.reviews.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.reviews.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final review = state.reviews[index];

        return ProfileReviewCard(review: review);
      },
    );
  }
}
