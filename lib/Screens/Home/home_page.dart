import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:aarogyamswadeshi/Admin/product/product_controller.dart';
import 'package:aarogyamswadeshi/Admin/subcategory/subcategory_controller.dart';
import 'package:aarogyamswadeshi/Screens/desc/buynow_bottom.dart';
import 'package:aarogyamswadeshi/Services/admin_services.dart';
import 'package:aarogyamswadeshi/Services/cart_service.dart';
import 'package:aarogyamswadeshi/Services/category_service.dart';
import 'package:aarogyamswadeshi/Services/product_services.dart';
import 'package:aarogyamswadeshi/Services/subcategory_service.dart';
import 'package:aarogyamswadeshi/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:aarogyamswadeshi/Admin/category/category_controller.dart';
import 'package:aarogyamswadeshi/Constants/constants.dart';
import 'package:aarogyamswadeshi/Screens/Home/home_controller.dart';
import 'package:aarogyamswadeshi/Screens/allproduct/viewall_product.dart';
import 'package:aarogyamswadeshi/Screens/category/category_product_screen.dart';
import 'package:aarogyamswadeshi/Screens/desc/desc_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Homecontroller homecontroller = Get.put(Homecontroller());
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());
  SubcategoryController subcategoryController =
      Get.put(SubcategoryController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController searchController = TextEditingController();

  List colorlist = [
    {
      "first": Color(0xffffafbd),
      "second": Color(0xffffc3a0),
    },
    {
      "first": Color(0xff2193b0),
      "second": Color(0xff6dd5ed),
    },
    {
      "first": Color(0xffee9ca7),
      "second": Color(0xffffdde1),
    },
    {
      "first": Color(0xffcc2b5e),
      "second": Color(0xff753a88),
    },
    {
      "first": Color(0xff42275a),
      "second": Color(0xff734b6d),
    },
    {
      "first": Color(0xffbdc3c7),
      "second": Color(0xff2c3e50),
    },
    {
      "first": Color(0xffde6262),
      "second": Color(0xffffb88c),
    },
    {
      "first": Color(0xffdd5e89),
      "second": Color(0xfff7bb97),
    },
    {
      "first": Color(0xffddd6f3),
      "second": Color(0xfffaaca8),
    },
  ];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer timer;
  RxBool isSearch = false.obs;
  RxBool isProduct = false.obs;
  Icon searchicon = Icon(Icons.search);
  void serchPressed() async {
    homecontroller.searchlist.clear();
    await getSearch(searchController.text).then((value) {
      if (value == "noproduct") {
        Fluttertoast.showToast(msg: "No Products Found!");
      } else if (value == "product") {
        isProduct.value = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (productController.productlist.isEmpty) {
      firstLoad();
    }
    productController.scontroller.addListener(() {
      if (productController.scontroller.position.maxScrollExtent ==
          productController.scontroller.position.pixels) {
        loadMore();
      }
    });
    if (homecontroller.scrollableImages.isEmpty) {
      getImages().then((value) {
        homecontroller.scrollableImages.clear();
        for (var i = 0; i < sliderController.imgList.length; i++) {
          String imgString = sliderController.imgList[i]["galleryImage"];
          Uint8List decodedbytes = base64.decode(imgString);
          homecontroller.scrollableImages.add(decodedbytes);
        }
      });
    }
  }

  @override
  void dispose() {
    productController.scontroller.removeListener(loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Container(
          alignment: Alignment.center,
          width: Get.width * 0.9,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: searchController,
                onTap: () {
                  isSearch.value = true;
                },
                onFieldSubmitted: (value) {
                  serchPressed();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    suffixIcon: Obx(() => IconButton(
                          icon: isSearch.value
                              ? InkWell(
                                  onTap: () {
                                    isSearch.value = false;
                                    searchController.text = "";
                                    homecontroller.searchlist.clear();
                                    isProduct.value ? firstLoad() : null;
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black54,
                                  ))
                              : Icon(Icons.search, color: Colors.black54),
                          onPressed: () {
                            serchPressed();
                            FocusScope.of(context).unfocus();
                          },
                        )),
                    hintStyle: TextStyle(fontSize: 14),
                    hintText: 'Search for Category, Products...',
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: refreshController,
        onRefresh: () {
          getAllproduct().then((value) {
            // ignore: unnecessary_statements
            setState(() {
              refreshController.refreshCompleted();
            });
          });
        },
        child: SingleChildScrollView(
          controller: productController.scontroller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => homecontroller.searchlist.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Container(
                        height: Get.height * 0.13,
                        width: Get.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: homecontroller.searchlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            String imgString =
                                homecontroller.searchlist[index]["imagePath"];
                            Uint8List decodedbytes = base64.decode(imgString);
                            return InkWell(
                              onTap: () async {
                                if (homecontroller.searchlist[index]["type"] ==
                                    "Category") {
                                  await getProductbycategory(
                                    homecontroller.searchlist[index]["id"],
                                  ).then((value) {
                                    Get.to(ProductCategoryScreen(
                                      title: homecontroller.searchlist[index]
                                          ["name"],
                                    ));
                                  });
                                } else if (homecontroller.searchlist[index]
                                        ["type"] ==
                                    "Subcategory") {
                                  await getProductbysubcategory(
                                      homecontroller.searchlist[index]["id"]);
                                  Get.to(ViewAllProductScreen(
                                      title:
                                          "Product of ${homecontroller.searchlist[index]["name"]}",
                                      datalist: homecontroller
                                          .subcategoryviseProductlist));
                                }
                              },
                              child: Container(
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kPrimaryColor, width: 1),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.memory(
                                              decodedbytes,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Text(
                                      homecontroller.searchlist[index]["name"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    )),

              Obx(() => homecontroller.scrollableImages.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: Get.height * 0.3,
                          aspectRatio: 16 / 10,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1100),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: homecontroller.scrollableImages.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                height: Get.height * 0.25,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    url,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    )
                  : Container()),

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Categories",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w700,
              //             fontSize: 20,
              //             color: Colors.black),
              //       ),
              //     ],
              //   ),
              // ),

              // //Gridview of cate
              // Obx(() {
              //   if (categoryController.categorylist.isNotEmpty) {
              //     return Wrap(
              //       children: [
              //         GridView.builder(
              //             padding: EdgeInsets.only(top: 5),
              //             physics: NeverScrollableScrollPhysics(),
              //             shrinkWrap: true,
              //             itemCount: categoryController.categorylist.length > 8
              //                 ? 8
              //                 : categoryController.categorylist.length,
              //             gridDelegate:
              //                 SliverGridDelegateWithFixedCrossAxisCount(
              //                     mainAxisExtent: 90, crossAxisCount: 4),
              //             itemBuilder: (BuildContext context, index) {
              //               String imgString = categoryController
              //                   .categorylist[index]["imagepath"];
              //               Uint8List decodedbytes = base64.decode(imgString);

              //               return InkWell(
              //                 onTap: () async {
              //                   await getProductbycategory(
              //                     categoryController.categorylist[index]
              //                         ["categoryId"],
              //                   ).then((value) {
              //                     Get.to(ProductCategoryScreen(
              //                       title: categoryController
              //                           .categorylist[index]["categoryName"],
              //                     ));
              //                   });
              //                 },
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     Container(
              //                       height: 70,
              //                       width: 70,
              //                       decoration: BoxDecoration(
              //                         border: Border.all(
              //                             color: kPrimaryColor, width: 1),
              //                         borderRadius: BorderRadius.circular(60),
              //                       ),
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(50),
              //                         child: Padding(
              //                             padding: const EdgeInsets.all(6.0),
              //                             child: Image.memory(
              //                               decodedbytes,
              //                               fit: BoxFit.cover,
              //                             )),
              //                       ),
              //                     ),
              //                     Text(
              //                       categoryController.categorylist[index]
              //                           ["categoryName"],
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.w500,
              //                           fontSize: 11,
              //                           color: Colors.black),
              //                     )
              //                   ],
              //                 ),
              //               );
              //             }),
              //       ],
              //     );
              //   } else if (!categoryController.iscategoryloading.value) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       child: Center(
              //           child: Text(
              //         "Opps, No Category available!",
              //         style: TextStyle(color: Colors.red[300], fontSize: 16),
              //       )),
              //     );
              //   } else if (!categoryController.iscaterror.value) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       child: Center(
              //           child: Text(
              //         "Somthing Went wrong, Please Try Again!",
              //         style: TextStyle(color: Colors.red[300], fontSize: 16),
              //       )),
              //     );
              //   } else {
              //     return Center(
              //       child: CircularProgressIndicator(
              //         color: kPrimaryColor,
              //       ),
              //     );
              //   }
              // }),

              // Container(
              //   margin: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width * 0.05,
              //       vertical: MediaQuery.of(context).size.width * 0.05),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Sub Categories",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w700,
              //             fontSize: 20,
              //             color: Colors.black),
              //       ),
              //       // InkWell(
              //       //   onTap: () {
              //       //     // Get.to(CategoryScreen());
              //       //   },
              //       //   child: Text(
              //       //     "View All",
              //       //     style: TextStyle(
              //       //         fontWeight: FontWeight.w500,
              //       //         color: kPrimaryColor,
              //       //         fontSize: 15),
              //       //   ),
              //       // )
              //     ],
              //   ),
              // ),

              // Obx(() {
              //   if (subcategoryController.subcategorylist.isNotEmpty) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Container(
              //         // width: double.infinity,
              //         height: Get.size.height * 0.13,
              //         child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             shrinkWrap: true,
              //             itemCount:
              //                 subcategoryController.subcategorylist.length < 10
              //                     ? subcategoryController.subcategorylist.length
              //                     : 10,
              //             itemBuilder: (context, index) {
              //               // final _random = new Random();
              //               // var element = colorlist[
              //               //     _random.nextInt(colorlist.length)];
              //               // print(index);
              //               return InkWell(
              //                 onTap: () async {
              //                   await getProductbysubcategory(
              //                       subcategoryController.subcategorylist[index]
              //                           ["subcategoryId"]);
              //                   Get.to(ViewAllProductScreen(
              //                       title:
              //                           "Product of ${subcategoryController.subcategorylist[index]["subCategoryName"]}",
              //                       datalist: homecontroller
              //                           .subcategoryviseProductlist));
              //                 },
              //                 child: Container(
              //                   margin: EdgeInsets.only(
              //                       left: index == 0
              //                           ? MediaQuery.of(context).size.width *
              //                               0.025
              //                           : 5),
              //                   width: MediaQuery.of(context).size.width * 0.42,
              //                   child: Container(
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(10),
              //                           gradient: LinearGradient(
              //                               begin: Alignment.centerLeft,
              //                               end: Alignment.centerRight,
              //                               colors: [
              //                                 colorlist[index]["first"],
              //                                 colorlist[index]["second"],
              //                               ])),
              //                       child: Center(
              //                         child: Text(
              //                           subcategoryController
              //                                   .subcategorylist[index]
              //                               ["subCategoryName"],
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.w500,
              //                               fontSize: 16,
              //                               color:
              //                                   Colors.white.withOpacity(0.6)),
              //                           maxLines: 1,
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //                       )),
              //                 ),
              //               );
              //             }),
              //       ),
              //     );
              //   } else if (!subcategoryController
              //       .isSubcategoryloadingoading.value) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       child: Center(
              //           child: Text(
              //         "Opps, No SubCategory available!",
              //         style: TextStyle(color: Colors.red[300], fontSize: 16),
              //       )),
              //     );
              //   } else if (!subcategoryController.issubcaterror.value) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       child: Center(
              //           child: Text(
              //         "Somthing Went wrong, Please Try Again!",
              //         style: TextStyle(color: Colors.red[300], fontSize: 16),
              //       )),
              //     );
              //   } else {
              //     return Center(
              //       child: CircularProgressIndicator(
              //         color: kPrimaryColor,
              //       ),
              //     );
              //   }
              // }),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     productController.productlist.isNotEmpty
                    //         ? Get.to(ViewAllProductScreen(
                    //             title: "All Products",
                    //             datalist: productController.productlist,
                    //           ))
                    //         : Fluttertoast.showToast(
                    //             msg: "No Products Find !",
                    //             backgroundColor: Colors.red[300]);
                    //   },
                    //   child: Text(
                    //     "View All",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         color: kPrimaryColor,
                    //         fontSize: 15),
                    //   ),
                    // )
                  ],
                ),
              ),
              Obx(() {
                if (productController.isFirstLoadRunning.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                } else {
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController.productlist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width * 0.025,
                          crossAxisSpacing:
                              MediaQuery.of(context).size.width * 0.025,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.25,
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, index) {
                        String imgString = productController.productlist[index]
                            ["productimagepath"];
                        Uint8List decodedbytes = base64.decode(imgString);
                        return InkWell(
                          onTap: () async {
                            Get.to(HomeCategoryProductDescription(
                              productdatalist:
                                  productController.productlist[index],
                            ));
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.1,
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.memory(
                                          decodedbytes,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 2),
                                  child: Text(
                                    productController.productlist[index]
                                        ["productName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black54.withOpacity(0.6)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Text(
                                      "₹ ${productController.productlist[index]["price"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: kPrimaryColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                // Container(
                                //   margin: EdgeInsets.symmetric(horizontal: 8),
                                //   child: Container(
                                //       child: Text(
                                //     productController.productlist[index]
                                //             ["isProductAvailable"]
                                //         ? "Available"
                                //         : "Not Available",
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 12),
                                //   )),
                                // ),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Map data = {
                                        "productID": productController
                                            .productlist[index]["productId"],
                                        "quantity": 1,
                                      };
                                      addTocart(data).then((value) {
                                        if (value == "Added To Cart") {
                                          Fluttertoast.showToast(
                                              msg: value,
                                              backgroundColor: Colors.green);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: value,
                                              backgroundColor: Colors.red);
                                        }
                                        getCart().then((value) {
                                          cartController.getCarttotal();
                                        });
                                        Get.back();
                                      });
                                    },
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: kPrimaryColor)))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
              Obx(() => productController.isLoadMoreRunning.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  : Container()),

              Obx(() => productController.hasNextPage.value == false
                  ? Container(
                      height: 50,
                      color: kPrimaryColor,
                      child: Center(
                        child: Text(
                          'Fetched all product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
