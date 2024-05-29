import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_delegete_example/bloc/region/region_state.dart';
import 'package:search_delegete_example/utils/app_images/app_images.dart';
import 'package:search_delegete_example/utils/style/app_style.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.state, required this.textEditingController});
  final RegionState state;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...List.generate(
            state.currentRegions.length,
                (index) => ListTile(
              leading: Icon(Icons.location_on_rounded,color: Colors.red,size: 24.sp),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: state.currentRegions[index].name
                          .substring(
                          0, textEditingController.text.length),
                      style: AppStyle.poppinsBold.copyWith(color: Colors.blue),
                    ),
                    TextSpan(
                        text: state.currentRegions[index].name
                            .substring(
                            textEditingController.text.length,
                            state.currentRegions[index].name
                                .length),
                        style: AppStyle.poppinsRegular),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
