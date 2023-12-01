import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/app_theme/text_helper.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;
  const CharacterDetailPage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender: ${character.gender}',
                        style: AppTextStyle.fS16FW500,
                      ),
                      Text(
                        'Status: ${character.status}',
                        style: AppTextStyle.fS16FW500,
                      ),
                      Text(
                        'Location: ${character.location.name}',
                        style: AppTextStyle.fS16FW500,
                      ),
                      Text(
                        'Origin: ${character.origin.name}',
                        style: AppTextStyle.fS16FW500,
                      ),
                      Text(
                        'Species: ${character.species}',
                        style: AppTextStyle.fS16FW500,
                      ),
                      Text(
                        'Created date: ${DateTime.parse(character.created).year}.${DateTime.parse(character.created).month}.${DateTime.parse(character.created).day}',
                        style: AppTextStyle.fS16FW500,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
