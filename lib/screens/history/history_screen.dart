import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:search_delegete_example/bloc/region/region_bloc.dart';
import 'package:search_delegete_example/bloc/region/region_event.dart';
import 'package:search_delegete_example/bloc/region/region_state.dart';
import 'package:search_delegete_example/data/model/forms_status/forms_satatus.dart';
import 'package:search_delegete_example/utils/app_images/app_images.dart';
import 'package:search_delegete_example/utils/style/app_style.dart';

class SearchHistoryScreen extends StatefulWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  @override
  void initState() {
    context.read<RegionBloc>().add(GetSaveSearchRegion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qidiruv Tarixi",
          style: AppStyle.poppinsSemiBold.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () async {
              context.read<RegionBloc>().add(DeleteSaveSearchRegion());
            },
          ),
        ],
      ),
      body: BlocBuilder<RegionBloc, RegionState>(
        builder: (context, state) {
          if (state.formsStatus == FormsStatus.success) {
            if (state.savedRegions.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(AppImages.empty),
                    const Text("Hech qanday ma'lumot yo'q")
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.savedRegions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.savedRegions[index],
                    style:
                        AppStyle.poppinsRegular.copyWith(color: Colors.black),
                  ),
                );
              },
            );
          }
          if (state.formsStatus == FormsStatus.error) {
            return Center(
              child: Text(state.errorText),
            );
          }
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
