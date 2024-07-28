import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:uber_clone/core/utils/snack_bar.dart';
import 'package:uber_clone/faetures/home/bloc/fetch_data_bloc.dart';
import 'package:uber_clone/faetures/home/view/widgets/custom_button.dart';
import 'package:uber_clone/faetures/models/booking.dart';
import 'package:uber_clone/faetures/models/driver_model.dart';
import 'package:uber_clone/faetures/models/user_model.dart';
import 'package:uuid/uuid.dart';

class SliderWidget extends StatelessWidget {
  final double height;
  final UserModel userModel;
  final List<DriverModel> drivers;
  const SliderWidget({super.key, required this.height, required this.drivers, required this.userModel});




  @override
  Widget build(BuildContext context) {

    
   
    return FlutterCarousel(
      items: drivers.map((e) {
        return Builder(builder: (BuildContext context) {
           Booking booking=Booking(status: 'success', rideId:const Uuid().v1(), driverModel: e, estamateTime: '30 min');
          return Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Image.network(
                  e.carImg,
                  height: 80,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          e.rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.carModel,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    BlocConsumer<FetchDataBloc, FetchDataState>(
                      listener: (context, state) {
                        if (state is FetchDataFailure) {
                        return  showSnackBar(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is FetchDataLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return CustomButton(
                          ontap: () =>context.read<FetchDataBloc>().add(BookRideEvent(booking: booking)),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        });
      }).toList(),
      options: CarouselOptions(
          height: height,
          showIndicator: true,
          slideIndicator: const CircularSlideIndicator()),
    );
  }
}
