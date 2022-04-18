
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/utils/constants/image_constant.dart';

class NoDataFound extends StatelessWidget {

  final String? msg;
  final IconData? iconData;
  final String? icon;

  const NoDataFound({Key? key,this.msg,this.iconData,this.icon=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData!=null?Icon(iconData!=null?iconData:Icons.cloud_off,color: Colors.grey.shade500,size: 32.sp,):SvgPicture.asset(icon!,color:Colors.grey.shade500,height: 70.sp,width: 70.sp),
          SizedBox(height: 2.h,),
          Text(
          msg!=null && msg!=""?msg!:'No Data found!',
          style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.grey),
    ),
        ],
      ),
    );
  }
}

class SearchData extends StatelessWidget {

  const SearchData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(DImg.nosearch,color:Colors.grey.shade500,height: 70.sp,width: 70.sp),
          // Icon(
          //   Icons.search,
          //   color: Colors.grey.shade500,
          //   size: 32.sp,
          // ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Search here...',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

