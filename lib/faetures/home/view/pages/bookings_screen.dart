import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/core/utils/snack_bar.dart';
import 'package:uber_clone/faetures/home/bloc/fetch_data_bloc.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  void initState() {
    context.read<FetchDataBloc>().add(FetchRideDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: BlocConsumer<FetchDataBloc, FetchDataState>(
        listener: (context, state) {
          if (state is FetchDataFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is FetchDataLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is FetchRideSuccess) {
            return ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final data = state.bookings[index];
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // shadow color
                              spreadRadius: 1, // spread radius
                              blurRadius: 5, // blur radius
                              offset: const Offset(0,
                                  3), // changes position of shadow to the bottom
                            ),
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            data.driverModel.carImg,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.driverModel.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                
                              const SizedBox(height: 4,),
                              Text(data.driverModel.carModel,  style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w200),),
                              RichText(
                                text: TextSpan(
                                  text: "status : ",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(text:data.status,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green) )
                                      ]
                                ),
                                
                              ),
                              
                            ],
                          ),
                          const SizedBox(
                                width: 10,
                              ),
                              Text(data.estamateTime,style: const TextStyle(color: Colors.red),)
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
