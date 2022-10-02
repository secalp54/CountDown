import 'package:counter_down/core/save_data_manager.dart';
import 'package:flutter/material.dart';

import '../core/Isaved_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _TextFormFieldKey = GlobalKey();

  final TextEditingController _controller = TextEditingController();
  @override
  IData manager = DataManager();
//_TextFormFieldKey.currentState.value;
  String _girilendeger = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manager.initFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              key: _TextFormFieldKey, // bu form alanı için benzersiz anahtar/kimlik
              controller:
                  _controller, //Düzenlenmekte olan metni kontrol etmek için TextEditingController turunden metin kontol edicisi.
              obscureText: false, // true ise girilen yazıyı gizler. şifre gizleme de kullanılır.
              decoration: const InputDecoration(
                // dekorasyon metin girişi kutusunu biçimlendirebilmemize olanak sağlar.
                icon: Icon(Icons.calendar_today), // icon alır
                hintText: 'Geri sayım dakikası', // küçülen yazı
                labelText:
                    'Geri Sayım Dakikası', // metin girilmeye başlayınca silinecek yazı. Arama kutularındaki "lütfen bir kelime girin" şeklindeki bir yazı gilince silinen yazı.
              ),
              onChanged: (value) {
                _girilendeger = value;
              },
              validator: (value) {
                return null;
              }, // Bir girişi doğrulayan isteğe bağlı bir yöntem. Girdi geçersizse veya aksi takdirde null olursa görüntülemek için bir hata dizesi döndürür.Bu form alanına girilen değeri yakalayabilir ve kontrol edebiliriz.
              keyboardType: TextInputType.number, // klavye tipini atabileceğimiz parametre
              onSaved: (value) {
                _girilendeger = value ?? "0";
              }, // Form kaydedildiğinde çalışır. Bu form alanına girilen değeri yakalayabilir ve kaydedebiliriz.
            ),
            ElevatedButton(
                onPressed: () async {
                  int saniye = int.parse(_girilendeger) * 60;
                  manager.writeDataString("setTime", saniye.toString());
                  Navigator.pop(context);
                },
                child: const Text("Kaydet")),
          ],
        ),
      ),
    );
  }
}
