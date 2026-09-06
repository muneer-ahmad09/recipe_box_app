import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';

class CookingTime extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const CookingTime({super.key, required this.value, required this.onChanged});

  @override
  State<CookingTime> createState() => _CookingTimeState();
}

class _CookingTimeState extends State<CookingTime> {
  late final TextEditingController _cookingTimeController =
      TextEditingController(text: widget.value.toString());

  @override
  void dispose() {
    _cookingTimeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CookingTime oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _cookingTimeController.text = widget.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    if (widget.value > 0) {
                      widget.onChanged(widget.value - 1);
                    }
                  });
                },
                icon: Icon(Icons.remove_circle_outline),
                iconSize:  30,
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
                            widget.onChanged(0);
                            return;
                          }

                          widget.onChanged(parsedValue);
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
                  setState(() {
                    widget.onChanged(widget.value + 1);
                  });
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
