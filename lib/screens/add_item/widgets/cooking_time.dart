import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';

import '../../../core/features/add_recipe/add_recipe_controller.dart';

class CookingTime extends ConsumerStatefulWidget {
  const CookingTime({super.key});

  @override
  ConsumerState<CookingTime> createState() => _CookingTimeState();
}

class _CookingTimeState extends ConsumerState<CookingTime> {
  final TextEditingController _cookingTimeController = TextEditingController(text: "30");

  @override
  void dispose() {
    _cookingTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(addRecipeProvider);
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cooking Time",
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: AppColors.petrol,
                onPressed: () {
                  if (recipeState.cookingTime > 0) {
                    final newTime = recipeState.cookingTime - 1;

                    ref
                        .read(addRecipeProvider.notifier)
                        .updateCookingTime(newTime);

                    _cookingTimeController.text = newTime.toString();
                  }
                },
                icon: Icon(Icons.remove_circle_outline),
                iconSize: 30,
              ),
              Container(
                height: 65,
                width: 130,
                decoration: BoxDecoration(
                  color: AppColors.paperDim,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 35,
                      child: TextField(
                        controller: _cookingTimeController,
                        onChanged: (value) {
                          final parsedValue = int.tryParse(value);

                          if (parsedValue == null) {
                            _cookingTimeController.text = '0';
                            _cookingTimeController.selection =
                                TextSelection.fromPosition(
                                  const TextPosition(offset: 1),
                                );
                            ref
                                .read(addRecipeProvider.notifier)
                                .updateCookingTime(0);
                            return;
                          }

                          ref
                              .read(addRecipeProvider.notifier)
                              .updateCookingTime(parsedValue);
                        },
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text("min", style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ),
              IconButton(
                color: AppColors.petrol,
                onPressed: () {
                  final newTime = recipeState.cookingTime + 1;

                  ref
                      .read(addRecipeProvider.notifier)
                      .updateCookingTime(newTime);

                  _cookingTimeController.text = newTime.toString();
                },
                icon: Icon(Icons.add_circle_outline),
                iconSize: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
