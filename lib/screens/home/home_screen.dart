import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_delegete_example/data/model/forms_status/forms_satatus.dart';
import 'package:search_delegete_example/screens/history/history_screen.dart';
import 'package:search_delegete_example/screens/home/widgets/place_item.dart';
import 'package:search_delegete_example/screens/home/widgets/textfield_container.dart';
import 'package:search_delegete_example/utils/style/app_style.dart';
import '../../bloc/region/region_bloc.dart';
import '../../bloc/region/region_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Joy Nomlari",
          style: AppStyle.poppinsSemiBold.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SearchHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RegionBloc, RegionState>(
        builder: (context, state) {
          if (state.formsStatus == FormsStatus.error) {
            return Center(
              child:
                  Text("Qandaydur xatplilk", style: AppStyle.poppinsSemiBold),
            );
          }
          if (state.formsStatus == FormsStatus.success) {
            return Column(
              children: [
                TextFieldContainer(
                    textEditingController: textEditingController),
                PlaceItem(state: state, textEditingController: textEditingController),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
