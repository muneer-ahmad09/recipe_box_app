import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/features/add_recipe/add_recipe_controller.dart';

class Steps extends ConsumerStatefulWidget {

  const Steps({super.key});

  @override
  ConsumerState<Steps> createState() => _StepsState();
}

class _StepsState extends ConsumerState<Steps> {
  final List<TextEditingController> _stepControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (final controller in _stepControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _notifySteps() {
    final steps = _stepControllers
        .map((controller) => controller.text)
        .toList();
    ref.read(addRecipeProvider.notifier).updateSteps(steps);
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
    _notifySteps();
  }

  void _removeStep(int index) {
    setState(() {
      if (_stepControllers.length > 1) {
        final controller = _stepControllers.removeAt(index);
        controller.dispose();
      }
    });
    _notifySteps();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Steps",
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                _addStep();
              },
              child: Text("Add"),
            ),
          ],
        ),
        Column(
          children: [
            for (int i = 0; i < _stepControllers.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _stepControllers[i],
                      onChanged: (_) {
                        _notifySteps();
                      },
                      decoration: InputDecoration(
                        hintText: "Step ${i + 1}",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  if (_stepControllers.length > 1)
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeStep(i),
                      color: Colors.red,
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
