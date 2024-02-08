import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/core/injection.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_query.dart';
import 'package:smart_fit_test_signal/helpers/app_assets.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';
import 'package:smart_fit_test_signal/presentation/commons/locale_button.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/legend_card.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/screen/unities_controller.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/search_card/search_card.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/unity_list_card.dart';

class SearchUnityScreen extends StatefulWidget {
  const SearchUnityScreen({super.key});

  @override
  State<SearchUnityScreen> createState() => _SearchUnityScreenState();
}

class _SearchUnityScreenState extends State<SearchUnityScreen> {
  final barHeight = 100.0;
  final unitiesController = getIt<UnitiesController>();
  final query = signal(const UnityQuery());
  late ScrollController scrollController;

  @override
  void initState() {
    unitiesController.load();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<UnityEntity> filter({
    required UnityQuery query,
    required List<UnityEntity> list,
  }) {
    if (query.closedUnities == true && query.time == null) return list;
    List<UnityEntity> newList = [];
    for (final unity in list) {
      final hasTime = query.hasSchedule(unity.schedules);
      if (hasTime && (unity.isOpened || query.closedUnities)) {
        newList.add(unity);
      }
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unitiesState = unitiesController.state.watch(context);
    final currentQuery = query.watch(context);
    final filteredState = switch (unitiesState) {
      UnitiesStateError state => state,
      UnitiesStateLoading state => state,
      UnitiesStateReady state => UnitiesStateReady(
          filter(
            list: state.data,
            query: currentQuery,
          ),
        ),
    };
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        trackVisibility: true,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                height: barHeight,
                color: Colors.black,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Spacer(),
                    Image.asset(
                      AppAssets.logo,
                      height: 50,
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LocaleButton(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 220,
                      child: Text(
                        i10n(context).headerTitle,
                        style: textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 80,
                      height: 8,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      i10n(context).warningHeader,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SearchCard(
                      count: switch (filteredState) {
                        UnitiesStateError _ => 0,
                        UnitiesStateLoading _ => null,
                        UnitiesStateReady state => state.data.length,
                      },
                      onSearch: (newQuery) {
                        query.set(newQuery);
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Durations.medium3,
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const LegendWidget(),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              switch (filteredState) {
                UnitiesStateError state => Text(state.error.text(context)),
                UnitiesStateLoading _ => const SizedBox.shrink(),
                UnitiesStateReady state => UnitiesListWidget(
                    unities: state.data,
                  ),
              },
              const SizedBox(
                height: 50,
              ),
              Container(
                height: barHeight,
                color: AppColors.darkGrey,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      AppAssets.logo,
                      height: 25,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      i10n(context).footerRights,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
