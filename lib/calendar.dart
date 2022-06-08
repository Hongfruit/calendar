import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {  //오늘의 기록 홈화면 구현
  var _index = 0;
  late Map<DateTime,List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }
  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date]??[];
  }
  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("오늘의 기록"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2010),
            lastDay: DateTime(2060),
            locale: 'ko-KR',
            daysOfWeekHeight: 30,
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay,DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay,date);
            },

            eventLoader: _getEventsfromDay,



            calendarStyle: CalendarStyle (
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color:Colors.blue,
                shape: BoxShape.circle
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color:Color(0xffA66CB1FF),
                shape: BoxShape.circle
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
            ),
          ),
          ..._getEventsfromDay(selectedDay).map((Event event) => ListTile())
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(  //운동기록 추가 버튼
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => FormScreen()));
          },
          label: Text("운동기록"),
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar( //밑에 홈버튼
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),

          BottomNavigationBarItem(
            label: '몸무게',
            icon: Icon(Icons.bathroom_rounded),
          ),

          BottomNavigationBarItem(
            label: '통계',
            icon: Icon(Icons.signal_cellular_alt_rounded),
          ),

        ],
      ),
    );
  }
}
class FormScreen extends StatefulWidget {     //운동기록 구현
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();    //form 사용
}

class _FormScreenState extends State<FormScreen> {    //운동기록 입력 페이지

  late Map<DateTime,List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }
  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date]??[];
  }
  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }


  late String _Exname;  //운동이름
  late String _Expart;  //운동부위
  late String _Extime;  //운동시간
  late String _Exnum;   //운동횟수
  late String _Exwei;   //운동무게
  late String _Weight;  //몸무게
  late String _Mus;     //골격근
  late String _Fat;   //지방

  final _formKey = GlobalKey<FormState>();


  Widget _buildExname() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: '운동이름',
      ),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z ㄱ-ㅎ 가-힣 ]+$').hasMatch(value)) {
          return '운동이름을 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Exname;
      },
    );
  }

  Widget _buildExpart() {
    return TextFormField(

      decoration: InputDecoration(labelText: '운동부위'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z ㄱ-ㅎ 가-힣 ]+$').hasMatch(value)) {
          return '운동부위를 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Expart;
      },
    );
  }

  Widget _buildExtime() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: '운동시간 (분)',
      ),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '운동시간을 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Extime;
      },
    );
  }

  Widget _buildExnum() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '운동횟수(개)'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '운동횟수를 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Exnum;
      },
    );
  }

  Widget _buildExwei() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '운동무게(kg)'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '운동무게를 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Exwei;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '몸무게 (Kg)'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '몸무게를 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Weight;
      },
    );
  }
  Widget _buildMus() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '골격근 (Kg)'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '골격근을 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Mus;
      },
    );
  }
  Widget _buildFat() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '지방 (Kg)'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(value)) {
          return '지방을 입력하세요.';
        }
        else {
          return null;
        }
      },
      onSaved: (value) {
        value = _Fat;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("운동 기록"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column
              ( mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildExname(),
                SizedBox(height: 16,),
                _buildExpart(),
                SizedBox(height: 16,),
                _buildExtime(),
                SizedBox(height: 16,),
                _buildExnum(),
                SizedBox(height: 16,),
                _buildExwei(),
                SizedBox(height: 50),
                _buildWeight(),
                SizedBox(height: 16,),
                _buildMus(),
                SizedBox(height: 16,),
                _buildFat(),
                SizedBox(height: 80,),

                ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        showDialog <String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('운동기록'),
                              content: Text('저장하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed:()=> Navigator.pop(context,'Cancel'),
                                    child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed:()=> Navigator.pop(context,'OK'),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                        );
                      }


                      /*if(_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.blueGrey,
                              content: Text(
                                  '저장완료!',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  fontSize: 18.0,
                                ),
                              )
                          )
                        );
                      }*/
                    },
                    child: const Text('등록',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16),
                    )
                )
              ],
          ),
          ),
        ),
      ),
    );
  }
}





/*class ScreenB extends StatefulWidget {  @override
  State<ScreenB> createState() => _ScreenBState();
}*/

/* class _ScreenBState extends State<ScreenB> {  //운동기록 추가 페이지 구현
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("운동 기록"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            TextField(
              controller: nameController,
              style: TextStyle(fontSize: 15, color: Colors.black),
              decoration: InputDecoration(
                hintText: "입력",
                labelText: '운동이름',
                labelStyle: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                    letterSpacing: 1.5
                ),
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.all(5),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () { nameController.clear(); },
                  ),
                ),
              ),
            SizedBox(height: 10.0),
              TextField(
                controller: nameController,
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                decoration: InputDecoration(
                  hintText: "입력",
                  labelText: '운동부위',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      letterSpacing: 1.5
                  ),
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () { nameController.clear(); },
                  ),
                ),
              ),

            SizedBox(height: 100.0),
            TextField(
              controller: nameController,
              style: TextStyle(fontSize: 15, color: Colors.black),
              decoration: InputDecoration(
                hintText: "입력",
                labelText: '운동시간',
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    letterSpacing: 1.5
                ),
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.all(5),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () { nameController.clear(); },
                ),
              ),
            ),

    ],


        ),
      ),
    );
  }
} */
