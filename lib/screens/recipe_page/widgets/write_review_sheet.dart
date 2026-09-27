import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';

class WriteReviewSheet extends StatefulWidget {
  final Future<void> Function(
      int rating,
      String comment,
      ) onSubmit;

  final bool isSubmitting;
  final String? errorMessage;

  const WriteReviewSheet({
    super.key,
    required this.onSubmit,
    this.isSubmitting = false,
    this.errorMessage,
  });

  @override
  State<WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  int _selectedRating = 0;

  final TextEditingController _commentController =
  TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Write a review",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 16),

          _buildRatingSelector(),

          const SizedBox(height: 16),

          TextField(
            controller: _commentController,
            maxLines: 3,
            enabled: !widget.isSubmitting,
            decoration: InputDecoration(
              hintText: "Tell other cooks how it went...",
              filled: true,
              fillColor: AppColors.paperDim,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          if (widget.errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              widget.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _selectedRating == 0 || widget.isSubmitting
                  ? null
                  : _submit,
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  AppColors.petrol,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: widget.isSubmitting
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Post review",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
            (index) {
          final starValue = index + 1;

          return GestureDetector(
            onTap: widget.isSubmitting
                ? null
                : () {
              setState(() {
                _selectedRating = starValue;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Icon(
                Icons.star_rounded,
                size: 32,
                color: starValue <= _selectedRating
                    ? AppColors.mustard
                    : AppColors.paperDim,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit() async {
    final comment = _commentController.text.trim();

    await widget.onSubmit(
      _selectedRating,
      comment,
    );
  }
}