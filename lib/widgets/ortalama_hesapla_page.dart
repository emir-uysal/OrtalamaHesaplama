import 'package:dinamik_ortalama_hesapla/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama_hesapla/widgets/harf_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesapla/widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  double secilenHarfDegeri = 4 ;
  double secilenKrediDegeri = 1;
  var formKey = GlobalKey<FormState>();
  String girilenDersAdi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(Sabitler.baslikText, style: Sabitler.baslikStyle,),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildForm(),
            ),
        Expanded(
          flex: 1,
          child: OrtalamaGoster(dersSayisi: DataHelper.tumEklenenDersler.length, ortalama: DataHelper.ortalamahesapla()),
        )
        ],
      ),
      Expanded(
        child: DersListesi(
          onElemanCikarildi: (index){
            DataHelper.tumEklenenDersler.removeAt(index);
            setState(() {
              
            });
          },
        ),
      ),
        ],
    ),
    );
  }
  
  _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
            ),
            SizedBox(
              height: 5,
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: Sabitler.yatayPadding8,
                 child: HarfDropdownWidget(
                  onHarfSecildi: (harf){
                    secilenHarfDegeri = harf;
                  },
                 ),
                 ),
                 ),
            Expanded(
              child: Padding(
                padding: Sabitler.yatayPadding8,
                child: KrediDropdownWidget(onKrediSecildi: (kredi){
                  secilenKrediDegeri = kredi;
                },),
              ),
            ),
            IconButton(
              onPressed: _dersEkleVeOrtalamaHesapla(),
              icon: Icon(Icons.arrow_forward_ios_sharp),
              color: Sabitler.anaRenk,
              iconSize: 30,
              ),
          ],
        ),
        SizedBox(height: 5,)
      ],),
    );
  }
  
  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger){
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s){
        if(s!.length <=0){
          return "Ders adını giriniz";
        }else
        return null; 
      },
      decoration: InputDecoration(
        hintText: "mobil uygulama geliştirme",
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3)
      ),
    );
  }
  

  
  _dersEkleVeOrtalamaHesapla() {
    if(formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
        ad: girilenDersAdi,
        harfDegeri: secilenHarfDegeri,
        krediDegeri: secilenKrediDegeri);
        DataHelper.dersEkle(eklenecekDers);
        setState(() {
          
        });
    }
  }
}