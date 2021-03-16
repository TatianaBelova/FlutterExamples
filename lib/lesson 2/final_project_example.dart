import 'package:flutter/material.dart';
import 'package:my_flutter_note/res/strings.dart';

class FinalProjectExampleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FinalProjectExampleDetail()));
                },
                child: Row(
                  children: [
                    const Icon(Icons.check),
                    Column(
                      children: [
                        Text('Объект списка ${index + 1}'),
                        Text('Краткое описание объекта ${index + 1}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: Colors.green)
          ],
        );
      },
      itemCount: 10,
    );
  }
}

class FinalProjectExampleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детальная страница'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset('qr_telegram.png',
                            width: 170, height: 170)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Текст на картинке'))
                  ],
                ),
              ),
              Text(Strings.lorem)
            ],
          ),
        ),
      ),
    );
  }
}
