import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/widget_constant.dart';

class OthersProfilePage extends StatelessWidget {
  const OthersProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 30,
            )),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 225,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                              ),
                              child: SizedBox(
                                height: 160,
                                width: 240,
                                // color: Colors.black,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Suhail', style: gPoppines33),
                                        Text(
                                          'suhail_karrat',
                                          style: gfontRalewayFont18,
                                        )
                                      ],
                                    ),
                                    Text(' Bio here',
                                        style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: kgreyColor,
                                        ),
                                        Text(
                                          " 4"
                                          '  Followers',
                                          style: gfontRalewayFont18,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: ksnackbarGreen,
                        ),
                      ],
                    ),
                    ksizedbox20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        profilebutton('Following'),
                        profilebutton('Message')
                      ],
                    ),
                  ],
                )),
            ksizedbox10,
            kdivider(),
            Center(
              child: Text(
                'Post',
                style: gFaBeeZe(20, Colors.black),
              ),
            ),
            kdivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: ksnackbarGreen,
                    height: 50,
                    width: 50,
                  );
                },
                itemCount: 14 , // Adjust the itemCount as needed
              ),
              // GridView.count(crossAxisCount: 3,padding: const EdgeInsets.all(4.0),
              //         mainAxisSpacing: 4.0,
              //         crossAxisSpacing: 4.0,
              // children: [
              //   Container(color: kmain200,height: 150,width: 150,),

              // ],),
            )
          ],
        ),
      ),
    );
  }
}
