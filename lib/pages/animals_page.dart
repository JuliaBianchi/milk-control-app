import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/snackbar_component.dart';
import 'package:milkcontrolapp/pages/animal_registration.dart';
import 'package:milkcontrolapp/services/animais_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../components/title_component.dart';
import '../models/animal.dart';
import '../provider/animais_provider.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnimalProvider>(context, listen: false).fetchAnimals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Vector (2).png',
              height: 120,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              color: const Color(0xff194a7a),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
              ],
            ),
            const ContainerTitlePage(
              title: 'Animais cadastrados',
              subtitle: '',
            ),
            Consumer<AnimalProvider>(
              builder: (context, animalProvider, child) {
                if (animalProvider.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: SpinKitFadingCircle(color: Color(0xff1C6E8C)),
                  );
                }

                if (animalProvider.animals.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          'assets/images/undraw_no_data_re_kwbl (1).svg',
                          height: 120),
                      const SizedBox(
                        height: 50,
                      ),
                      Text('Nenhum animal cadastrado!',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade500)),
                      Text(
                        'Adicione alguns animais na página de cadastro de animais.',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade500),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButtonComponent(
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                              child: AnimalRegistration(),
                              childCurrent: AnimalsPage(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          ),
                          text: 'Ir para a página de cadastro',
                          width: 280,
                          color: const Color(0xff194a7a),
                          colorText: Colors.white,
                        ),
                      ),
                    ],
                  );
                }

                return Expanded(
                  child: Scrollbar(
                    interactive: true,
                    trackVisibility: true,
                    thickness: 5,
                    radius: const Radius.circular(10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: animalProvider.animals.length,
                      itemBuilder: (context, index) {
                        Animal? animalItem = animalProvider.animals[index];

                        return GestureDetector(
                          child: Card(
                            elevation: 2,
                            color: animalItem.ativado
                                ? Colors.blue.shade50
                                : const Color(0xffe9ecef),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Identificação',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            animalItem.identificacao.toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Nome',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            animalItem.nome != ''
                                                ? animalItem.nome!
                                                : 'Indefinido',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Raça',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            animalItem.raca != ''
                                                ? animalItem.raca!
                                                : 'Indefinida',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              // Cor do texto
                                              fontSize: 15,
                                            ),
                                            maxLines: 3,
                                          )
                                        ],
                                      ),

                                      if(animalItem.ativado)
                                        SvgPicture.asset(
                                          'assets/icons/pencil-square.svg',
                                          height: 25,
                                          width: 25,
                                          fit: BoxFit.cover,
                                        ),
                                    ],
                                  ),
                                  if (animalItem.ativado == false)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Cadastro desativado',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {

                            if(animalItem.ativado) {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => AnimalRegistration(animal: animalItem)));
                              if (!context.mounted) return;

                            }else{
                              showSnackBar(context: context, message: 'Cadastro desativado, você não pode mais editar', backgroundColor: Colors.red);
                            }

                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ]),
    );
  }
}
