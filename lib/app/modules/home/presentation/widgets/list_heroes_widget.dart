import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import 'package:marvelapp/app/core/extensions/screen_extension.dart';
import 'package:marvelapp/app/modules/details/details_module.dart';
import 'package:marvelapp/app/modules/home/presentation/home_controller.dart';

import '../../../../core/domain/entities/char_entity.dart';
import '../../../../core/style/assets.dart';
import 'dart:math' as math;

class ListHeroes extends StatefulWidget {
  final HomeController controller;
  const ListHeroes({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ListHeroes> createState() => _ListHeroesState();
}

class _ListHeroesState extends State<ListHeroes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Observer(
      builder: (_) {
        if (widget.controller.state.isEmpty) {
          return Center(
            child: Text(
              'No hero was found, please try another',
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4!.merge(
                TextStyle(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          );
        }
        if (widget.controller.state.isLoading) {
          return Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                AssetsMarvel.shield,
                height: 100.scale,
              ),
            ),
          );
        }
        if (widget.controller.state.isSuccess) {
          return Observer(
            builder: (_) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    SizedBox(height: 16.scale),
                shrinkWrap: true,
                itemCount: widget.controller.heroes.length,
                itemBuilder: (context, index) {
                  final Char char = widget.controller.heroes[index];
                  return InkWell(
                    onTap: () => Modular.to.pushNamed(
                      DetailsModule.routeName,
                      arguments: {
                        'hero': char,
                      },
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: theme.disabledColor,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.scale),
                        child: Row(
                          children: [
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                char.imageUrl,
                              ),
                              radius: 50.scale,
                            ),
                            SizedBox(
                              width: 32.scale,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    char.name,
                                    style: theme.textTheme.headline5!.merge(
                                      TextStyle(
                                        color: theme.primaryColor,
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
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
