import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mybindel_test/palette/palette.dart';
import 'package:mybindel_test/providers/Member_Of_Your_Pages_WorldOfFriendsProvider.dart';
import 'package:mybindel_test/providers/selectTheme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Scroll_View_Member_Of_Your_Pages_WordOfFriend.dart';

class Member_Of_Your_Pages_WorldOfFriends extends StatefulWidget {
  const Member_Of_Your_Pages_WorldOfFriends({super.key});

  @override
  State<Member_Of_Your_Pages_WorldOfFriends> createState() => _Member_Of_Your_Pages_WorldOfFriendsState();
}

class _Member_Of_Your_Pages_WorldOfFriendsState extends State<Member_Of_Your_Pages_WorldOfFriends> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Themeprovider>(context);
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => Member_Of_Your_Pages_WorldOfFriendsProvider(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: provider.currentTheme ? light_Scaffold_color : dark_Scaffold_color,
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: (4.300).h,
                    left: (3.800).w,
                    right: (3.800).w,
                    bottom: (1.800).h),
                width: (100).w,
                height: (6.900).h,
                // color: Colors.red,
                color: provider.currentTheme
                    ? light_Scaffold_color
                    : dark_Scaffold_color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (10.00).w,
                      height: (4.500).h,
                      decoration: provider.currentTheme
                          ? square_neu_Morphism
                          : square_dark_neu_Morphism,
                      margin: EdgeInsets.symmetric(
                        vertical: (1.00).h,
                        // horizontal: ().w * 0.040
                      ),
                      child: InkWell(
                        onTap: () {
                          print("menu tapped");
                        },
                        child: Icon(
                          Icons.menu,
                          color: provider.currentTheme ? dim_black : dim_white,
                        ),
                      ),
                    ),
                    Container(
                      width: (10.00).w,
                      height: (5.00).h,
                      // color: Colors.black,
                      margin: EdgeInsets.symmetric(
                          vertical: (1.00).h, horizontal: (3.00).w),
                      child: Image.asset("asset/images/logo.png"),
                    ),
                    Container(
                      width: (14.800).w,
                      height: (6.400).h,
                      padding: EdgeInsets.symmetric(
                          vertical: (0.6).h, horizontal: (1.400).w),
                      // color: Colors.black,
                      decoration: provider.currentTheme
                          ? square_neu_Morphism
                          : square_dark_neu_Morphism,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "asset/images/user_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: (95.0).w,
                margin: EdgeInsets.symmetric(
                  // vertical: ().h * 0.010,
                    horizontal: (3.00).w),
                decoration: provider.currentTheme
                    ? textFormField_neu_morphism
                    : dark_textFormField_neu_morphism,
                child: TextFormField(
                  // controller: _find,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search In Pages",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: provider.currentTheme ? dim_black : dim_white,
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: (4.00).w)),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ),

              Consumer(
                builder: (context, Member_Of_Your_Pages_WorldOfFriendsProvider member_Of_Your_Pages_WordOfFriendsProvider, child) {
                  return Visibility(
                    visible: member_Of_Your_Pages_WordOfFriendsProvider.getItem.length > 0 ? true:false,
                    child: Container(
                      height: (15).h,
                      width: (100).w,
                      child: ListView.builder(
                        // reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: member_Of_Your_Pages_WordOfFriendsProvider.getItem.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all((2).w),
                                  height: (8).h,
                                  width: (20).w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          member_Of_Your_Pages_WordOfFriendsProvider.getItem[index].picture,
                                        )),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        member_Of_Your_Pages_WordOfFriendsProvider.removeItem(index);
                                        print("removed");
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: dim_white ,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                Text( member_Of_Your_Pages_WordOfFriendsProvider.getItem[index].name)
                              ],
                            );
                          }),
                    ),
                  );
                },
              ),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.047,
                    vertical: size.height * 0.010),
                color: provider.currentTheme
                    ? light_Scaffold_color
                    : dark_Scaffold_color,
                height: size.height * 0.060,
                width: size.width,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Your Pages",
                      style: TextStyle(
                          color: provider.currentTheme ? dim_black : dim_white,
                          fontFamily: 'Avant',
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: (0.5).h),
                        decoration: provider.currentTheme
                            ? square_neu_Morphism
                            : square_dark_neu_Morphism,
                        child: Text(
                          "Done",
                          style: TextStyle(color: orange_color),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer(builder:
                    (context, Member_Of_Your_Pages_WorldOfFriendsProvider member_Of_Your_Pages_WordOfFriendsProvider, child) {
                  return Member_Of_Your_Pages_WorldOfFriend_Scoll_View(
                    items: const [
                      'Aiden', 'Alice', 'Alex', 'Amelia', 'Andrew', 'Anna',
                      'Benjamin', 'Brooke', 'Brandon', 'Bella', 'Caleb', 'Chloe', 'Christopher', 'Charlotte','Daniel', 'David', 'Diana', 'Dylan', 'Emily', 'Ethan', 'Elizabeth', 'Ella',
                      'Finn', 'Fiona', 'Faith', 'Gabriel', 'Grace', 'Gavin', 'Hannah', 'Henry', 'Haley',
                      'Isaac', 'Isabella', 'Ivy', 'Ian', 'Jackson', 'Julia', 'Jacob', 'James',
                      'Kevin', 'Kayla', 'Kyle', 'Katherine', 'Liam', 'Lily', 'Lucas', 'Leah',
                      'Mason', 'Mia', 'Michael', 'Madison', 'Noah', 'Natalie', 'Nathan', 'Olivia',
                      'Owen', 'Sophia', 'Samuel', 'Samantha', 'Thomas', 'Taylor', 'Tyler',
                      'Victoria', 'Violet', 'Vincent', 'Valerie', 'William', 'Willow', 'Wyatt',
                      'Xavier', 'Ximena', 'Xander',
                      'Yasmine', 'Yvonne', 'Yara',
                      'Zachary', 'Zoe', 'Zane', 'Zara'
                    ],
                    // onClickedIem : (item){},
                  );
                }),
              )
            ],
          )),
    );
  }
}