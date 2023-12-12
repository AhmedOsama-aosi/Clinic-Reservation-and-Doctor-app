List<Map<String, dynamic>> eXAMBLcategories = [
  {
    "categoryid": 1,
    "categoryname": "اسنان",
    "categorypicture": "assets/images/dintistLogo.svg",
  },
  {
    "categoryid": 4,
    "categoryname": "اطفال",
    "categorypicture": "assets/images/cryBabyLogo.svg",
  },
  {
    "categoryid": 2,
    "categoryname": "قلب",
    "categorypicture": "assets/images/heartlogo.svg",
  },
  {
    "categoryid": 3,
    "categoryname": "عظام",
    "categorypicture": "assets/images/boneLogo.svg",
  },
  {
    "categoryid": 5,
    "categoryname": "جلدية",
    "categorypicture": "assets/images/dermatologyLogo.svg",
  },
];

const List<Map<String, dynamic>> eXAMBLdoctorslist = [
  {
    "id": 1,
    "name": "د.وحيد فريد العدوى",
    "isMale": true,
    "picture": null,
    "feildid": 2,
    "description": "دكتور قلب",
    "address":
        " 1 ميدان الحجاز - برج الصفا الطبى، الجيزة، المهندسين 1 ميدان الحجاز - برج الصفا الطبى، الجيزة، المهندسين 1 ميدان الحجاز - برج الصفا الطبى، الجيزة، المهندسين"
  },
  {
    "id": 2,
    "name": "د.وفاء عطية",
    "isMale": false,
    "picture": null,
    "feildid": 2,
    "description": "دكتورة قلب",
    "address": "60 ش الخليفة المأمون, روكسى، القاهرة، مصر الجديدة"
  },
  {
    "id": 3,
    "name": "د.صلاح فتحي",
    "isMale": true,
    "picture": null,
    "feildid": 4,
    "description": "طبيب اطفال",
    "address": "شارع مصطفى كامل-المعادي"
  },
  {
    "id": 4,
    "name": "د.محمود جمال العربي",
    "isMale": true,
    "picture": null,
    "feildid": 1,
    "description": "أخصائي جراحة وزراعة وتجميل الفم والأسنان",
    "address":
        " 27 شارع النصر، أمام سيراميكا كليوباترا، المعادي الجديدة، المعادي، القاهرة"
  },
  {
    "id": 5,
    "name": "د.دينا فؤاد بركات ",
    "isMale": false,
    "picture": null,
    "feildid": 1,
    "description": "اخصائية تجميل أسنان وعلاج جذور",
    "address":
        "كابيتال بيزنس بارك ، مبنى 6 ب ، عيادة 312 . 6 اكتوبر، الشيخ زايد، 6 اكتوبر"
  },
  {
    "id": 6,
    "name": "د.عصام محمد نور الدين",
    "isMale": true,
    "picture": null,
    "feildid": 1,
    "description": "دكتور اسنان متخصص في اسنان اطفالاسنان بالغين",
    "address": "98 شارع التحرير، الدقي، الدقي، الجيزة"
  },
  {
    "id": 7,
    "name": "د.محمد زين العابدين محمود خضر",
    "isMale": true,
    "picture": null,
    "feildid": 4,
    "description": "دكتور اطفال وحديثي الولادة",
    "address":
        "4 شارع عمرو بن العاص محور خدمات الحي الثاني أمام مول السلام، مدينة السادات، المنوفية"
  },
  {
    "id": 8,
    "name": "د.أشرف حماد",
    "isMale": true,
    "picture": null,
    "feildid": 4,
    "description": "دكتور اطفال وحديثي الولادة",
    "address": "75 المنطقة الثالثة، مدينة السادات، المنوفية"
  },
  {
    "id": 9,
    "name": "د.لؤي سرور",
    "isMale": true,
    "picture": null,
    "feildid": 3,
    "description":
        "دكتور عظام متخصص في اصابات ملاعب ومناظير مفاصل,تشوهات عظام,تغيير المفاصل,تقويم عظام,جراحة الاعصاب الطرفيةجراحة عظام اطفال,جراحة عظام بالغين,عظام اطفال,عظام القدم والكاحل,عظام اليد والكتف,عظام بالغين",
    "address": "1 البر الشرقي - خلف ميجا ماركت، شبين الكوم، المنوفية"
  },
  {
    "id": 10,
    "name": "د.يحيى نور الدين",
    "isMale": true,
    "picture": null,
    "feildid": 3,
    "description": "دكتور عظام",
    "address": "(55) عبد المنعم رياض، الجيزة، المهندسين"
  },
  {
    "id": 11,
    "name": "د.هاني زكي",
    "isMale": true,
    "picture": null,
    "feildid": 2,
    "description": "دكتور قلب",
    "address": "11 شارع خالد عبد العال، كفر الزيات، الغربية"
  },
  {
    "id": 12,
    "name": "د.وفاء صابر عبد الحليم",
    "isMale": false,
    "picture": null,
    "feildid": 2,
    "description": "دكتورة قلب",
    "address": "4 ش مصطفى اسماعيل، الازاريطة، الاسكندرية"
  },
];
const Map eXAMBLdayslist = {
  "1": {
    "23/9/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "3:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "3:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
    "26/9/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "4:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "4:30",
          "isMorning": false,
          "isAvailable": false,
        },
      ]
    },
  },
  "2": {
    "30/9/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "5:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "5:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
    "15/10/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "5:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "5:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
    "20/10/2021": {
      "status": "Notavilable",
      "times": [
        {
          "time": "6:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "6:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
  },
  "3": {
    "25/9/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "5:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "5:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
    "20/9/2021": {
      "status": "avilable",
      "times": [
        {
          "time": "5:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "5:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
    "30/9/2021": {
      "status": "Notavilable",
      "times": [
        {
          "time": "6:00",
          "isMorning": false,
          "isAvailable": true,
        },
        {
          "time": "6:30",
          "isMorning": false,
          "isAvailable": true,
        },
      ]
    },
  },
};
List eXAMBLclintreservations = [
  {
    "operationid": 2,
    "status": "success",
    "patientid": 1,
    "doctorid": 2,
    "date": "الجمعة 2021/8/20",
    "time": "3:00",
    "isMoring": false,
  },
  {
    "operationid": 3,
    "status": "cancled",
    "patientid": 1,
    "doctorid": 2,
    "date": "الثلاثاء 2021/8/10",
    "time": "3:00",
    "isMoring": false,
  },
];
List<Map<String, dynamic>> eXAMBLuserfavorites = [
  {
    "userid": 1,
    "favoritesdoctors": [1, 2],
  }
];
