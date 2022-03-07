import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/home_care_sub_category_model.dart';

import 'package:patient/Screens/DoctorScreens/doctor_profile_4.dart';

import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfile3 extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  const DoctorProfile3({Key? key, required this.cat_id, required this.cat_name})
      : super(key: key);

  @override
  _DoctorProfile3State createState() => _DoctorProfile3State();
}

class _DoctorProfile3State extends State<DoctorProfile3> {
  TextEditingController care = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  late HomeCareSubCategoriesModel homeCareSubCategories;

  Future<HomeCareSubCategoriesModel> getsubCate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_home_care_sub_cat_services.php',
        params: {
          'token': Token,
          'cat_id': widget.cat_id,
          'user_id': preferences.getString('user_id')
        });

    return HomeCareSubCategoriesModel.fromJson(response);
  }

  bool loading = true;
  Future addCareServices(
    BuildContext context, {
    required String subcareid,
    required String careid,
    required String name,
    required String email,
    required String phone,
    required String care_requirement,
  }) async {
    var loader = ProgressView(context);
    loader.show();
    late Map<String, dynamic> data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(PARAM_URL: 'add_homecare_sub_requirement.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'name': name,
      'email': email,
      'phone': phone,
      'service_category_id': careid,
      'service_subcategory_id': subcareid,
      'postal_code': care_requirement,
    }).then((value) {
      loader.dismiss();
      (value['status'])
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              backgroundColor: apptealColor,
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              backgroundColor: Colors.red,
            ));
      data = value;
      print(
          name + '\n' + email + '\n' + phone + '\n' + care_requirement + '\n');
    });
  }

  void homecarealert(
    BuildContext context, {
    required String subcatName,
    required String subCatId,
    required TextEditingController careController,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phonenumberController,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            backgroundColor: Color(0xffF1F1F1),
            elevation: 0,
            insetPadding: EdgeInsets.all(15),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find In-Home Care Near You',
                      style: GoogleFonts.montserrat(
                          color: appblueColor, fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),
                  ],
                ),
                Divider(color: Colors.grey),
              ],
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: Color(0xffF1F1F1),
              //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Category - ',
                          style: GoogleFonts.montserrat(
                              color: apptealColor, fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          widget.cat_name,
                          style: GoogleFonts.montserrat(
                              color: appblueColor, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Sub Category - ',
                          style: GoogleFonts.montserrat(
                              color: apptealColor, fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          subcatName,
                          style: GoogleFonts.montserrat(
                              color: appblueColor, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    alertTextField(
                        inputType: TextInputType.number,
                        controller: careController,
                        label: 'What is the care needed?',
                        textFieldtext: 'Enter Postal Code'),
                    SizedBox(
                      height: 10,
                    ),
                    alertTextField(
                        controller: nameController,
                        label: 'Name',
                        textFieldtext: 'Enter Full Name'),
                    SizedBox(
                      height: 10,
                    ),
                    alertTextField(
                        controller: emailController,
                        label: 'Email',
                        textFieldtext: 'Enter Email Id'),
                    SizedBox(
                      height: 10,
                    ),
                    alertTextField(
                        inputType: TextInputType.number,
                        controller: phonenumberController,
                        label: 'Phone Number',
                        textFieldtext: 'Enter Phone Number'),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: commonBtn(
                        s: 'Submit Care',
                        bgcolor: Color(0xff161616).withOpacity(0.6),
                        textColor: Colors.white,
                        onPressed: () {
                          print(careController.text);
                          addCareServices(context,
                                  subcareid: subCatId,
                                  careid: widget.cat_id,
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phonenumberController.text,
                                  care_requirement: careController.text)
                              .then((value) {
                            nameController.clear();
                            emailController.clear();
                            phonenumberController.clear();
                            careController.clear();

                            Pop(context);
                          });
                        },
                        height: 40,
                        width: 115,
                        borderRadius: 4,
                        textSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsubCate().then((value) {
      setState(() {
        homeCareSubCategories = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) => GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: appblueColor,
                    size: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  Scaffold.of(context).openDrawer();
                });
              },
            ),
          ),
        ),
      ),
      drawer: commonDrawer(),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xff161616).withOpacity(0.6),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Search',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Color(0xff161616).withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeCareSubCategories.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 150,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      homeCareSubCategories
                                                          .data[index].image),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  homeCareSubCategories
                                                      .data[index].name,
                                                  style: KHeader),
                                              Row(
                                                children: [
                                                  rowTextIcon(
                                                      asset:
                                                          'assets/pngs/payments_black_24dp (1).png',
                                                      text: 'Starting at'),
                                                  Text(
                                                    homeCareSubCategories
                                                        .data[index].price,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: apptealColor,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                  homeCareSubCategories
                                                      .data[index].description,
                                                  style: KBodyText),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                appblueColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                        ))),
                                    onPressed: () {
                                      homecarealert(context,
                                          subcatName: homeCareSubCategories
                                              .data[index].name,
                                          careController: care,
                                          subCatId: homeCareSubCategories
                                              .data[index].subCareId,
                                          nameController: name,
                                          emailController: email,
                                          phonenumberController: phonenumber);
                                    },
                                    child: Text(
                                      'Book An Appointment',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: navbarht + 20,
                ),
              ],
            ),
    );
  }
}
