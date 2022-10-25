import 'package:flutter/material.dart';

import 'package:marvelapp/app/core/extensions/screen_extension.dart';
import 'package:marvelapp/app/modules/home/presentation/home_controller.dart';

import '../../../../core/style/fonts.dart';
import 'list_filter_widget.dart';

class MarvelTextField extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final HomeController controller;

  MarvelTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 24.scale),
        child: TextField(
          controller: nameController,
          style: TextStyle(
            fontFamily: FontsMarvel.quicksand,
            color: theme.colorScheme.secondary,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => FiltersModalDialog(),
                  ),
                  icon: Icon(
                    Icons.filter_list,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    controller.fetchHeroes(
                      startsWith: nameController.text.isEmpty
                          ? null
                          : nameController.text,
                    );
                    nameController.clear();
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            hintText: 'Enter hero name',
            hintStyle: TextStyle(
              fontFamily: FontsMarvel.quicksand,
              color: theme.dividerColor,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
