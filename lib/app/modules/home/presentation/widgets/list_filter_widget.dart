import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvelapp/app/core/extensions/screen_extension.dart';
import 'package:marvelapp/app/core/style/fonts.dart';
import 'package:marvelapp/app/modules/home/presentation/home_controller.dart';

class FiltersModalDialog extends StatelessWidget {
  FiltersModalDialog({
    Key? key,
  }) : super(key: key);
  final HomeController controller = Modular.get<HomeController>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Observer(builder: (_) {
      return Stack(
        children: [
          Positioned(
            top: 10,
            right: 20,
            child: IconButton(
              onPressed: Modular.to.pop,
              icon: Icon(
                Icons.close,
                color: theme.colorScheme.background,
                size: 50,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Dialog(
              child: SizedBox(
                height: size.height * 0.4,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 80.scale,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => controller.setIsAscending(true),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: controller.isAscending
                                    ? theme.colorScheme.primary
                                    : theme.dividerColor,
                              ),
                              SizedBox(
                                width: 16.scale,
                              ),
                              Text(
                                'Ascending Order',
                                style: theme.textTheme.bodyText1!.merge(
                                  TextStyle(
                                    fontFamily: FontsMarvel.quicksand,
                                    color: controller.isAscending
                                        ? theme.colorScheme.primary
                                        : theme.dividerColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24.scale),
                        InkWell(
                          onTap: () => controller.setIsAscending(false),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: controller.isAscending
                                    ? theme.dividerColor
                                    : theme.colorScheme.primary,
                              ),
                              SizedBox(
                                width: 16.scale,
                              ),
                              Text(
                                'Descending Order',
                                style: theme.textTheme.bodyText1!.merge(
                                  TextStyle(
                                    fontFamily: FontsMarvel.quicksand,
                                    color: controller.isAscending
                                        ? theme.dividerColor
                                        : theme.colorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.19,
            left: size.width * 0.3,
            right: size.width * 0.3,
            child: CircleAvatar(
              radius: 30.scale,
              backgroundColor: theme.primaryColor,
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 40.scale,
              ),
            ),
          ),
        ],
      );
    });
  }
}
