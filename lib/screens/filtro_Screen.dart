import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
//import 'package:filter_list/filter_list.dart';

class filtroautos extends StatelessWidget {
  const filtroautos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _passwordController = TextEditingController();

    return IconButton(
        onPressed: () {
          // showSearch(
          //     context: context,
          //     delegate: SearchAuto("Buscar Auto..."));
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  insetPadding: EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    height: 680,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Buscador",
                                    style: TextStyle(
                                      fontFamily: 'biko',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 6),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 10),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                hintText: "Buscar Carro",
                                hintStyle: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black.withOpacity(.5)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black.withOpacity(.5),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close,
                                      color: Colors.black.withOpacity(.5)),
                                  onPressed: () => _passwordController.clear(),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(.4),
                          ),
                          Container(
                            height: 460,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Chevrolet",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: RED_CAR,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "BMW",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Ford",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: RED_CAR,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Nissan",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Toyota",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Audi",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Mazda",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: RED_CAR,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Kia",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Ford",
                                              style: TextStyle(
                                                fontFamily: 'biko',
                                                fontWeight: FontWeight.w500,
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  for (var i = 0; i < 6; i++)
                                    _DropdownItemState(),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(.4),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPrimary: Colors.white,
                                      primary: Colors.black,
                                      shadowColor: Colors.black,
                                      elevation: 15,
                                    ),
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: Text(
                                        "Borrar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'biko',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 6),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        icon: Icon(Icons.search));
  }
}

class _DropdownItemState extends StatefulWidget {
  _DropdownItemState({Key? key}) : super(key: key);

  @override
  State<_DropdownItemState> createState() => __DropdownItemStateState();
}

class __DropdownItemStateState extends State<_DropdownItemState> {
  String selectedValue = "USA";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "USA",
            style: TextStyle(fontSize: 12),
          ),
          value: "USA"),
      DropdownMenuItem(
          child: Text(
            "Canada",
            style: TextStyle(fontSize: 12),
          ),
          value: "Canada"),
      DropdownMenuItem(
          child: Text(
            "Brazil",
            style: TextStyle(fontSize: 12),
          ),
          value: "Brazil"),
      DropdownMenuItem(
          child: Text(
            "England",
            style: TextStyle(fontSize: 12),
          ),
          value: "England"),
    ];
    return menuItems;
  }

  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "Modelo",
                style: TextStyle(
                  fontFamily: 'biko',
                  fontWeight: FontWeight.w500,
                  fontSize: LABEL_CAJA,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 55,
              margin: EdgeInsets.all(15),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
            ),
          ],
        ));
  }
}
