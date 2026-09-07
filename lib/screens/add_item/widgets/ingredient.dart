import 'package:flutter/material.dart';

class Ingredient extends StatefulWidget {
  final ValueChanged<List<String>> onIngredientsChanged;

  const Ingredient({super.key, required this.onIngredientsChanged});

  @override
  State<Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  final List<TextEditingController> _ingredientControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (final controller in _ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _notifyIngredients() {
    final ingredients = _ingredientControllers
        .map((controller) => controller.text)
        .toList();
    widget.onIngredientsChanged(ingredients);
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
    _notifyIngredients();
  }

  void _removeIngredient(int index) {
    setState(() {
      if (_ingredientControllers.length > 1) {
        final controller = _ingredientControllers.removeAt(index);
        controller.dispose();
      }
    });
    _notifyIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                _addIngredient();
              },
              child: Text("Add"),
            ),
          ],
        ),
        Column(
          children: [
            for (int i = 0; i < _ingredientControllers.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientControllers[i],
                      onChanged: (_) {
                        _notifyIngredients();
                      },
                      decoration: InputDecoration(
                        hintText: "e.g 2 Cup of flour",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_ingredientControllers.length > 1)
                    IconButton(
                      onPressed: () {
                        _removeIngredient(i);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
