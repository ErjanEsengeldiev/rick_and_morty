import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/app_theme/text_helper.dart';
import 'package:rick_and_morty/core/constans/app_constans.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/generated/l10n.dart';

class FilterBottomsheet {
  static showModalBottomsheet(BuildContext context,
      {required CharactersBloc charactersBloc}) {
    String name = '';
    String status = '';
    String gender = '';

    showModalBottomSheet(
      useRootNavigator: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    width: 70,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: S.of(context).searchByName,
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).status,
                        style: AppTextStyle.fS15FW600,
                      ),
                      const SizedBox(width: 10),
                      Wrap(
                        children: AppConstans.listOfStatus
                            .map(
                              (e) => Card(
                                color: e == status ? Colors.blue[100] : null,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    setState(
                                      () {
                                        status = e;
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        S.of(context).gender,
                        style: AppTextStyle.fS15FW600,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          children: AppConstans.listOfGender
                              .map(
                                (e) => Card(
                                  color: e == gender ? Colors.blue[100] : null,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      setState(
                                        () {
                                          gender = e;
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      charactersBloc.add(
                        SortedCharactersEvent(
                          status: status,
                          gender: gender,
                          name: name,
                        ),
                      );
                      context.pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(S.of(context).search),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
