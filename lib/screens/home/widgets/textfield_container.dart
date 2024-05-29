import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_delegete_example/bloc/region/region_bloc.dart';
import 'package:search_delegete_example/bloc/region/region_event.dart';
import 'package:search_delegete_example/data/local/places_data.dart';
import 'package:search_delegete_example/utils/app_images/app_images.dart';

class TextFieldContainer extends StatefulWidget {
  const TextFieldContainer({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: widget.textEditingController,
        style: const TextStyle(
            fontFamily: AppImages.fontPoppins, color: Colors.black),
        onChanged: (v) {
          context
              .read<RegionBloc>()
              .add(SearchRegionCallEvent(searchTitle: v));
          setState(() {});
        },
        onSubmitted: (v) async {
          await PlacesDatabase.instance.saveSearchQuery(v);
        },
        decoration: InputDecoration(
            hintText: "Qidirish...",
            hintStyle: const TextStyle(
                fontFamily: AppImages.fontPoppins,
                color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 1.sp, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 1.sp, color: Colors.black),
            )),
      ),
    );
  }
}
