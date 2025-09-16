import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/UI/chemical/models/chemicals_model.dart';

class ChemicalController extends GetxController {

  RxDouble kgm = 0.0.obs;
  RxDouble ckgm = 0.0.obs;
  RxString selectedGrade = ''.obs;

  List gradeList = [
    'A53A',
    'A53B',
    'A106A',
    'A106B',
    'A106C',
    'A179',
    'A192',
    'A209 / A335T1 / P1',
    'A209T1a',
    'A209T1b',
    'A210A1',
    'A210C',
    'A213 / A335T2 / P2',
    'A213 / A335T5 / P5',
    'A213 / A335T5b / T5b',
    'A213 / A335T5c / T5c',
    'A213 / A335T9 / P9',
    'A213 / A335T11 / P11',
    'A213 / A335T12 / P12',
    'A335P15',
    'A213T17',
    'A213 / A335T21 / P21',
    'A213 / A335T22 / P22',
    'A213 / A335T91 / P91',
    'A333 / A3341',
    'A333 / A3343',
    'A333 4',
    'A333 / A3346',
    'A333 10',
    'A519MT 1010',
    'A519MT 1015',
    'A519MT X 1015',
    'A519MT 1020',
    'A519MT X 1020',
    'A5191008',
    'A5191010',
    'A5191012',
    'A5191015',
    'A5191016',
    'A5191017',
    'A5191018',
    'A5191019',
    'A5191020',
    'A5191021',
    'A5191022',
    'A5191025',
    'A5191026',
    'A5191030',
    'A5191518',
    'A5191524',
    'A5191330',
    'A5191335',
    'A5194012',
    'A5194023',
    'A5194024',
    'A5194027',
    'A5194028',
    'A5194118',
    'A5194422',
    'A5194427',
    'A5194520',
    'A5195015',
    'A5195115',
    'A5195120',
    'A5196118',
    'A5196120',
    'A556A2',
    'A556B2',
    'A556C2',
    'DIN 2391ST 30 SI',
    'DIN 2391ST 30 AL',
    'DIN 2391ST 35',
    'DIN 2391ST 45',
    'DIN 2391ST 52',
    'SAE 1008',
    'SAE 1010 / P195TR1 / P195TR2 / P195GH',
    'SAE 1012 / P235TR1 / P235TR2 / P235GH / P215NL / P255QL / S235JRH / 297E235',
    'SAE 1015',
    'SAE 1016',
    'SAE 1017',
    'SAE 1018/1019 / P265TR1 / P265TR2 / P265GH / P265NL',
    'SAE 1021',
    'SAE 1025',
    'SAE 1026',
    'SAE 1030',
    'SAE 1030 M',
    'SAE 1035',
    'SAE 1038',
    'SAE 1038',
    'SAE 1039',
    'SAE 1040',
    'SAE 1045/En 43 B',
    'SAE 1050',
    'SAE 1050',
    'SAE 1060',
    'SAE 1070(M)',
    'SAE 1117',
    'SAE 1118',
    'SAE 1137V',
    'SAE 1141',
    'SAE 1144',
    'SAE 1518',
    'SAE 1524(Mod)',
    'SAE 1527',
    'SAE 1527J',
    'SAE 1535',
    'SAE 1537 V',
    'SAE 1541',
    'SAE 1552',
    'SAE 4042H',
    'SAE 4042M',
    'SAE 40B37',
    'SAE 4118 ( MS 6668)',
    'SAE 4118 H / EX4',
    'SAE 4125 SPECIAL',
    'SAE 4125/ J55 (WSI)',
    'SAE 4130',
    'SAE 4130M',
    'SAE 4135H',
    'SAE 4135H',
    'SAE 4137',
    'SAE 4140/4142',
    'SAE 4320 H',
    'SAE 4320H',
    'SAE 4340 (AMS 6415)',
    'SAE 5120H',
    'SAE 5130',
    'SAE 5140H  (Matl code. 0250)',
    'SAE 52100/100Cr6',
    'SAE 8617 H',
    'SAE 8617H',
    'SAE 8620 H',
    'SAE 8620 HS',
    'SAE 8620H',
    'SAE 8620H  (Modified)',
    'SAE 8622 H',
    'SAE 8625 M',
    'SAE 8630',
    'SAE 8720(M)',
    'SAE 9310',
    'SAE 9310H',
    'SAE 94B17H',
    'SAE1530',
    'T1E166/SAE15B24Cr',
    '040A10      (EN 2A)',
    '2C40 (BSEN10083)',
    '42Cr4Mo2 / EN 19B / 40Cr4Mo3',
    '530A40  / EN 18D',
    '637H17     (EN 352)',
    '708M40 / EN 19A / 40CrMo4',
    'EN 15A M',
    'EN 16',
    'EN 16/35Mn6Mo3',
    'EN 18D',
    'EN 19',
    'EN 19M',
    'EN 207',
    'EN 32B',
    'EN 353',
    'EN 355   (822M17)',
    'EN 36 C',
    'EN 3A',
    'EN 41 B',
    'EN 41B',
    'EN 8',
    'EN 9',
    'EN 9',
    'EN24',
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    // setChemicalsSheet();
    fetchChemicalsSheet();
    super.onInit();
  }

  Map globalChemicalMap = {};
  void setChemicalsSheet() async {
    ByteData data = await rootBundle.load('assets/sheets/chemical.xlsx');
    Uint8List bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print('Sheet: $table');

      var rows = excel.tables[table]!.rows;

      for (int i = 0; i < rows.length; i++) {
        // if (i == 0) {
        //   print(rows[i].map((cell) => cell?.value.toString() ?? ' ').toList());
        // } else if (i == 1) {}
        if(i==0 || i==1){
          continue;
        }

        globalChemicalMap[rows[i][0]?.value.toString()] = {
          '%C': rows[i][1]?.value,
          '%Mn':rows[i][2]?.value,
          '%P':rows[i][3]?.value,
          '%S':rows[i][4]?.value,
          '%Si':rows[i][5]?.value,
          '%Cr':rows[i][6]?.value,
          '%Cu':rows[i][7]?.value,
          '%Mo':rows[i][8]?.value,
          '%Ni':rows[i][9]?.value,
          '%V':rows[i][10]?.value,
          '%B':rows[i][11]?.value,
          '%Nb':rows[i][12]?.value,
          '%N':rows[i][13]?.value,
          '%Al':rows[i][14]?.value,
          '%TI':rows[i][15]?.value,
          '%Zr':rows[i][16]?.value,
          'Hardness':rows[i][17]?.value,
          'Y.S.':rows[i][18]?.value,
          'U.T.S.':rows[i][19]?.value,
          '%E':rows[i][20]?.value,
        };
        // print('Row --${rows[i][0]?.value}-- ${rows[i].map((cell) => cell?.value.toString() ?? ' ').toList()}');
        print('-----------------------------------------------------------------------------------------------------');
      }

      print('goo ${globalChemicalMap.length}');
      return;
    }
  }

  Rx<ChemicalsModel> chemicalsModel = ChemicalsModel().obs;
  void fetchChemicalsSheet() {
    ApiService().getApi(url: 'https://intelliworkz.co.in/hmtl-portal/api/chemical').then((value) {
      if (value != null) {
        chemicalsModel.value = chemicalsModelFromJson(value);

        print('model-- ${chemicalsModel.value.data?.length}');

        for (int i = 0; i < chemicalsModel.value.data!.length; i++) {
          // if (i == 0) {
          //   print(rows[i].map((cell) => cell?.value.toString() ?? ' ').toList());
          // } else if (i == 1) {}
          // if(i==0 || i==1){
          //   continue;
          // }

          globalChemicalMap[chemicalsModel.value.data![i].specificationGrade.toString()] = {
            '%C': chemicalsModel.value.data![i].c,
            '%Mn': chemicalsModel.value.data![i].Mn,
            '%P': chemicalsModel.value.data![i].p,
            '%S': chemicalsModel.value.data![i].s,
            '%Si': chemicalsModel.value.data![i].Si,
            '%Cr': chemicalsModel.value.data![i].Cr,
            '%Cu': chemicalsModel.value.data![i].Cu,
            '%Mo': chemicalsModel.value.data![i].Mo,
            '%Ni': chemicalsModel.value.data![i].Ni,
            '%V': chemicalsModel.value.data![i].v,
            '%B': chemicalsModel.value.data![i].b,
            '%Nb': chemicalsModel.value.data![i].Nb,
            '%N': chemicalsModel.value.data![i].n,
            '%Al': chemicalsModel.value.data![i].Al,
            '%TI': chemicalsModel.value.data![i].ti,
            '%Zr': chemicalsModel.value.data![i].Zr,
            'Hardness': chemicalsModel.value.data![i].hardness,
            'Y.S.': chemicalsModel.value.data![i].ys,
            'U.T.S.': chemicalsModel.value.data![i].uts,
            '%E': chemicalsModel.value.data![i].e,
          };
          // print('Row --${rows[i][0]?.value}-- ${rows[i].map((cell) => cell?.value.toString() ?? ' ').toList()}');
          print('-----------------------------------------------------------------------------------------------------');
        }


      }
    });
  }


}
