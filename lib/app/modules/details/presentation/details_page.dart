import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:marvelapp/app/core/extensions/screen_extension.dart';
import 'package:marvelapp/app/core/style/fonts.dart';

import '../../../core/domain/entities/char_entity.dart';

class DetailsPage extends StatelessWidget {
  final Char hero;
  final List<Char> relatedHeroes;
  const DetailsPage({
    Key? key,
    required this.hero,
    required this.relatedHeroes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 48.scale),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(48.scale),
            child: Column(
              children: [
                const DetailHeader(),
                SizedBox(height: 32.scale),
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    hero.imageUrl,
                  ),
                  radius: 70.scale,
                ),
                SizedBox(height: 24.scale),
                Center(
                  child: Text(
                    hero.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline2!.merge(
                      TextStyle(
                        height: 1,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.scale),
                Text(
                  hero.description.isEmpty
                      ? 'No description found 😥'
                      : hero.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.merge(
                    TextStyle(
                      fontFamily: FontsMarvel.quicksand,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 16.scale),
              ],
            ),
          ),
          if (relatedHeroes.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.scale),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Related ',
                          style: theme.textTheme.headline3!.merge(
                            TextStyle(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Heroes',
                          style: theme.textTheme.headline3!.merge(
                            TextStyle(
                              height: 0.8,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 32.scale),
                  SizedBox(
                    height: 220.scale,
                    child: ListView.separated(
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16.scale,
                      ),
                      itemCount: relatedHeroes.length,
                      itemBuilder: (context, index) {
                        final Char relatedHeroe = relatedHeroes[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                relatedHeroe.imageUrl,
                              ),
                              radius: 40.scale,
                            ),
                            SizedBox(height: 16.scale),
                            Flexible(
                              child: SizedBox(
                                width: 120.scale,
                                child: Text(
                                  relatedHeroe.name,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headline5!.merge(
                                    TextStyle(
                                      height: 1,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: Modular.to.pop,
          child: Icon(
            Icons.arrow_back_ios,
            size: 50.scale,
            color: theme.colorScheme.secondary,
          ),
        ),
        Flexible(
          child: Text.rich(
            textAlign: TextAlign.right,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hero ',
                  style: theme.textTheme.headline2!.merge(
                    TextStyle(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                TextSpan(
                  text: 'Details',
                  style: theme.textTheme.headline2!.merge(
                    TextStyle(
                      height: 0.8,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
