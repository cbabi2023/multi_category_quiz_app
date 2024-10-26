import 'package:flutter/material.dart';
import 'package:quiz_app/controller/dummy_db/dummy_db.dart';
import 'package:quiz_app/utils/color_constants/color_constants.dart';
import 'package:quiz_app/utils/image_constants/image_constants.dart';
import 'package:quiz_app/view/quiz_page/quiz_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40.0, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------ Header Section ------------------------------------------------------
            const DashboardHeader(),

            // ------------------------ Header Section ENDS ---------------------------------------------

            const SizedBox(
              height: 20,
            ),

            // ----------------------- Ranking & Points -------------------------------------------------

            const RankingPointContainer(),

            // ----------------------- Ranking & Points ENDS -------------------------------------------------

            const SizedBox(
              height: 30,
            ),

            // ----------------------- Lets Play -------------------------------------------------

            const Text(
              "Let's Play",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textColor,
              ),
            ),

            // ----------------------- Lets Play ENDS -------------------------------------------------

            const SizedBox(
              height: 8,
            ),

            // ----------------------- Categories  -------------------------------------------------

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (index >= 0 && index < DummyDb.categoryList.length) {
                      final category = DummyDb.categoryList[index];
                      if (category['name'] != null &&
                          category['questionsList'] != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              categoryName: category['name'],
                              categoryBaseQuestionCount:
                                  category['questionsList'],
                            ),
                          ),
                        );
                      } else {
                        // Handle null values accordingly (e.g., show an error message)
                      }
                    } else {
                      // Handle invalid index (e.g., show an error message)
                    }
                  },
                  child: SizedBox(
                    height: 150,
                    width: 155,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            height: 155,
                            width: 155,
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundContainerColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DummyDb.categoryList[index]["name"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.textColor,
                                  ),
                                ),
                                Text(
                                  '${DummyDb.categoryList[index]["questions"]} Questions',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top:
                              0, // Adjust this value to control how far the image overlaps the container
                          left: 25, // Centers the image horizontally
                          child: Container(
                            height: 90,
                            width: 90, // You can adjust the width as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    DummyDb.categoryList[index]["image"]),
                                fit: BoxFit
                                    .cover, // Use cover to maintain aspect ratio
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: DummyDb.categoryList.length,
              ),
            ),

            // ----------------------- Categories  ENDS -------------------------------------------------
          ],
        ),
      ),
    );
  }
}

class RankingPointContainer extends StatelessWidget {
  const RankingPointContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            width: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: ColorConstants.backgroundContainerColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ColorConstants.backgroundContainerBorderColor,
              ),
              boxShadow: const [BoxShadow(blurRadius: 3, offset: Offset(3, 4))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage(ImageConstants.trophy),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ranking',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: ColorConstants.textColor,
                            )),
                        Text('350',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.rankValueColor,
                            ))
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: ColorConstants.containerDivider,
                      width: 2,
                    ))
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage(ImageConstants.coin),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Points',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: ColorConstants.textColor,
                            )),
                        Text('1209',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.rankValueColor,
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ------------------------ Header Section Widget ------------------------------------------------------

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, John',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textColor,
              ),
            ),
            Text("Let's make this day productive",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.textColor,
                )),
          ],
        ),

        // --------------- Profile --------------------------------------------
        CircleAvatar(
          radius: 27,
          backgroundColor: Colors.amber,
          child: Image(
            image: AssetImage(
              ImageConstants.profileImage,
            ),
            fit: BoxFit.cover,
          ),
        ),

        // --------------- Profile --------------------------------------------
      ],
    );
  }
}
