import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final productImageList = [
    "assets/images/pro_1.jpg",
    "assets/images/pro_2.jpg",
    "assets/images/pro_3.jpg",
    "assets/images/pro_4.jpg",
  ];

  final productTitles = [
    "Cold Drawn Stainless Steel",
    "Cold Drawn Carbon & Alloy Steel",
    "Hot & Cold Carbon, Alloy & Stainless Steel",
    "Stainless Steel U Tube",
  ];

  final productDescriptions = [
    "HMT has a dedicated plant of 27,500 sq. mtr. of covered area for manufacturing cold drawn of Stainless Steel Seamless & Welded Tubes/pipes with 15 pilger mills, bright annealing furnace, 5 Draw benches, 3 tube mills etc.\n\n"
        "Cold finished Tubes / Pipes are produced out of quality seamless hollows which are manufactured in house or procured from reputed mills. Seamless hollows are either cold pilgered over pilger mills or cold drawn over draw benches using precision tooling (dies & plugs) to achieve perfect dimensions and smooth surfaces.",
    "HMT has a dedicated plant of 13,500 sq. mtr. of covered area for manufacturing cold drawn of Carbon & Alloy Steel Tubes / pipes.\n\n"
        "Cold finished Tubes / Pipes are produced out of quality seamless hollows produced in house. Seamless hollows are either cold pilgered over pilger mills or drawn over draw benches using precision tooling (dies & plugs) to achieve perfect dimensions and smooth surfaces.",
    "HMT HFS Unit has been commenced and commissioned with state-of-the-art manufacturing process of cross roll piercing, accu roiling, SRM technology In Dec 2011 and produces various carbon, alloy and stainless steel grades of seamless tubular products.\n\n"
        "Cross roll piercing process begins with piercing of a hot round bar cut piece on the piercer, followed by accu roll for precision dimensional control of intermediate product, hollow cylindrical shell. Finally, the dimensions are controlled within specified variations on the stretch reducing mill (SRM). This process ensures better control over wall thickness variations as compared to other manufacturing process.",
    "Latest type of \"U\" bending machine is used for precision cold bending of tubes. Specifically prepared jigs and fixtures are used to ensure three dimensional accuracy for \"U\" bend tubes.\n\n"
        "Bending is done for all kinds of heat exchangers, condensers, economizers, boiler tubes in carbon steel, alloy steel and stainless steel seamless as well as welded. HT of bent portion is carried out.",
  ];

  // Quality Section
  final qualityImageList = [
    "assets/images/qual_1.jpg",
    "assets/images/qual_2.jpg",
    "assets/images/qual_3.jpg",
    "assets/images/qual_4.webp",
    "assets/images/qual_5.jpg",
  ];

  final qualityTitles = [
    "Quality Assurance",
    "Destructive Testing",
    "Non-Destructive Testing",
    "Certificates",
    "Packing & Dispatch",
  ];

  final qualityDescriptions = [
    "Quality Assurance System implemented at HMT covers all production stages right from raw materials, cold working, heat treatment, till the final tubular product is ready for dispatch. The elements of the Quality Assurance System correspond to the requirements of National and International codes, as well as customer's own Quality Assurance requirements.\n\n"
        "The Quality Control department is independent of manufacturing shop. All tests are carried out by trained quality personnel in compliance with the guidelines of the Quality Assurance system. The documented 'Quality Assurance Manual' establishes the practice concerning these guidelines.",
    "Destructive testing methods ensure the highest quality standards. By rigorously testing our materials to their failure points, we guarantee the strength, durability, and reliability of our products. This process helps us deliver top-tier solutions for your industrial needs.",
    "Online Testing of tubes/pipes by Ultrasonic Testing & Eddy Current Method to check dimension, length and other defects. 100% tubes are hydro tested at HMT irrespective of client requirement.\n\n"
        "If asked by the customer, pipes are subjected to Ultrasonic testing. An acoustic transmitter probe generates a sound beam which is applied to test piece using water as Couplant. The Ultrasonic Test Equipment is calibrated using a reference test piece with artificial defect test which is from the same pipe lot that is to be tested. The tested tubes are considered flawless if they do not cause any indications longer than that produce by the reference test piece. The Ultrasonic Test is conducted as described in ASTM E 213/A-450.",
    "Related certificates attached here from reputed industries such as Meru Industrial, Bharat Heavy Electricals, HMEL, Indian Oil, and others.",
    "At Heavy Metals & Tubes (India) Pvt. Ltd., we understand that a product's journey doesn't end when it leaves our facility. Ensuring our steel tubes and pipes arrive in perfect condition is crucial.\n\n"
        "That's why we offer a range of packaging solutions tailored to meet the diverse needs of our customers and the specific requirements of each product.",
  ];

  // --- 📞 Launch Phone Call ---
  Future<void> _launchPhoneCall() async {
    final Uri phoneUri =
        Uri(scheme: 'tel', path: '+919876543210'); // Replace later
    if (!await launchUrl(phoneUri)) {
      throw Exception('Could not launch $phoneUri');
    }
  }

  /// --- 🌐 Open Website ---
  Future<void> _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://www.hmtl.in');
    if (!await launchUrl(websiteUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $websiteUri');
    }
  }

  /// --- 📄 Download Brochure (Sample PDF Link) ---
  Future<void> _downloadBrochure() async {
    final Uri pdfUri = Uri.parse(
      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    );
    if (!await launchUrl(pdfUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open brochure');
    }
  }

  bool isDownloading = false;

  // Future<void> _downloadAndOpenBrochure() async {
  //   try {
  //     // ✅ Step 1: Check Connectivity (WiFi/Data adapter)
  //     final connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult == ConnectivityResult.none) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Internet connection not available.')),
  //       );
  //       return;
  //     }
  //
  //     // ✅ Step 2: Verify Actual Internet Access
  //     bool hasInternet = false;
  //     try {
  //       final result = await InternetAddress.lookup('google.com')
  //           .timeout(const Duration(seconds: 3));
  //       if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
  //         hasInternet = true;
  //       }
  //     } catch (_) {
  //       hasInternet = false;
  //     }
  //
  //     if (!hasInternet) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Internet connection not available.')),
  //       );
  //       return;
  //     }
  //
  //     // ✅ Step 3: Proceed with download
  //     setState(() => isDownloading = true);
  //
  //     const String pdfUrl =
  //         'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  //     final Dio dio = Dio();
  //
  //     final dir = await getApplicationDocumentsDirectory();
  //     final filePath = '${dir.path}/HMT_Brochure.pdf';
  //
  //     try {
  //       await dio.download(pdfUrl, filePath);
  //     } on DioException catch (_) {
  //       setState(() => isDownloading = false);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to download. Please check internet.')),
  //       );
  //       return;
  //     }
  //
  //     setState(() => isDownloading = false);
  //
  //     // ✅ Step 4: Open the file
  //     if (await File(filePath).exists()) {
  //       await OpenFilex.open(filePath);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Download failed. Please try again.')),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() => isDownloading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Internet connection not available.')),
  //     );
  //   }
  // }

  Future<void> _downloadAndOpenBrochure() async {
    try {
      setState(() => isDownloading = true);

      // ✅ Step 1: Load the PDF from assets
      final byteData = await rootBundle.load('assets/images/HMTL Brochure.pdf');

      // ✅ Step 2: Write to a temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/HMTL_Brochure.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      setState(() => isDownloading = false);

      // ✅ Step 3: Open in default PDF viewer
      await OpenFilex.open(file.path);
    } catch (e) {
      setState(() => isDownloading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening brochure: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About HMT'),
          bottom: TabBar(
            controller: _tabController, // ✅ Connected here

            indicatorColor: AppColor.primaryRedColor,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.pages_outlined,
                  ),
                  text: 'Infra'),
              Tab(icon: Icon(Icons.inventory_2), text: 'Products'),
              Tab(icon: Icon(Icons.verified), text: 'Quality'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            buildInfraTab(),
            buildProductTab(),
            buildQualityTab(),
          ],
        ),
      ),
    );
  }

  /// --- INFRA TAB (styled like other tabs) ---
  Widget buildInfraTab() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildInfraItem(
            AppImage.about1,
            'Cold finished Tubes / Pipes are produced out of quality seamless hollows which are manufactured in house or procured from reputed mills. Seamless hollows are either cold pilgered over pilger mills or cold drawn over draw benches using precision tooling (dies & plugs) to achieve perfect dimensions and smooth surfaces.',
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildInfraItem(
            AppImage.about2,
            'HMT has a dedicated plant of 13,500 sq. mtr. of covered area for manufacturing cold drawn of Carbon & Alloy Steel Tubes / pipes.',
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildInfraItem(
            AppImage.about3,
            'HMT manufactures specialized tubes for various mechanical applications in Boilers and Boiler components, Economizers, Heat Exchangers and pipes used for cryogenic applications. These items can be customized to the requirement of individual customers in terms of heat treatment and end finishes.',
          ),
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 1),
        const SizedBox(height: 20),

        /// --- ACTION BUTTONS ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton(
                'Visit hmtl.in', Icons.language, Colors.blue, _launchWebsite),
            // buildActionButton(
            //     'Call Inquiry', Icons.phone, Colors.green, _launchPhoneCall),
            buildActionButton(
              isDownloading ? 'Downloading...' : 'Brochure',
              isDownloading ? Icons.downloading : Icons.download,
              Colors.brown,
              isDownloading ? null : () => _downloadAndOpenBrochure(),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildInfraItem(String imagePath, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget buildActionButton(
      String label, IconData icon, Color color, VoidCallback? onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  /// --- PRODUCT TAB ---
  Widget buildProductTab() {
    return ListView.builder(
      itemCount: productImageList.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productTitles[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  productImageList[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                productDescriptions[index],
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  /// --- QUALITY TAB ---
  Widget buildQualityTab() {
    return ListView.builder(
      itemCount: qualityImageList.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                qualityTitles[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  qualityImageList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                qualityDescriptions[index],
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
